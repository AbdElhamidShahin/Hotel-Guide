import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_guide/core/network/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;
import '../../features/payment/data/model/ephemeral_keys_model.dart';
import '../../features/payment/data/model/init_payment_sheet_payment_input_model.dart';
import '../../features/payment/data/model/payment_intent_input_model.dart';
import '../../features/payment/data/model/payment_intent_model.dart';
import '../constants/api_constants.dart';
import 'api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: ApiConstants.Url,
      token: ApiConstants.secretKey,
    );
    return PaymentIntentModel.fromJson(response.data);
  }

  Future initPaymentSheet({
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
        customerEphemeralKeySecret:
            initPaymentSheetInputModel.ephermeralKeysSecret,
        customerId: initPaymentSheetInputModel.customerId,
        merchantDisplayName: 'Hotel Guide',
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<EphemeralKeysModel> createEphermeralKeys({
    required String customerId,
  }) async {
    var response = await apiService.post(
      body: {'customer': customerId},
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      token: ApiConstants.secretKey,
      headers: {
        // 'Authorization': "bearer ${ApiConstants.secretKey}",
        'Stripe-Version': '2024-06-20',
      },
    );
    return EphemeralKeysModel.fromJson(response.data);
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephermeralKeysModel = await createEphermeralKeys(
      customerId: paymentIntentInputModel.customerId!,
    );
    var initPaymentSheetInputModel = InitPaymentSheetInputModel(
      clientSecret: paymentIntentModel.clientSecret!,
      ephermeralKeysSecret: ephermeralKeysModel.secret!,
      customerId: paymentIntentInputModel.customerId!,
    );
    await initPaymentSheet(
      initPaymentSheetInputModel: initPaymentSheetInputModel,
    );
    await displayPaymentSheet();
  }





  Future<String> getOrCreateStripeCustomerId(UserProfileModel user) async {
    // 1. إذا كان المستخدم لديه ID مخزن مسبقاً في قاعدة بياناتك، استخدمه مباشرة
    if (user.stripeCustomerId != null && user.stripeCustomerId!.isNotEmpty) {
      return user.stripeCustomerId!;
    }

    // 2. إذا لم يوجد، نقوم بإنشاء واحد جديد في Stripe
    try {
      var response = await apiService.post(
        url: 'https://api.stripe.com/v1/customers', // تأكد من أن الرابط هو لـ customers
        token: ApiConstants.secretKey,
        contentType: Headers.formUrlEncodedContentType,
        body: {
          'email': user.email, // Stripe يفضل وجود الإيميل
          'metadata[supabase_id]': user.id, // اختياري: لربط الهويتين ببعض
        },
      );

      String newCustomerId = response.data['id'];

      // 3. (خطوة هامة) يجب أن تقوم بتحديث بيانات المستخدم في Supabase
      // لكي لا تضطر لإنشاء Customer جديد في كل مرة يضغط فيها المستخدم على الدفع
      await Supabase.instance.client
          .from('profiles')
          .update({'stripe_customer_id': newCustomerId})
          .eq('id', user.id);

      return newCustomerId;
    } catch (e) {
      print("Error creating Stripe Customer: $e");
      rethrow;
    }
  }

}
