import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_guide/core/network/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;
import '../../features/payment/data/model/ephemeral_keys_model.dart';
import '../../features/payment/data/model/init_payment_sheet_payment_input_model.dart';
import '../../features/payment/data/model/payment_intent_input_model.dart';
import '../../features/payment/data/model/payment_intent_model.dart';
import '../constants/api_constants.dart';
import '../error/error_handler.dart';
import '../error/failure.dart';
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
      url: ApiConstants.ephemeralKeysUrl,
      token: ApiConstants.secretKey,
      headers: {'Stripe-Version': '2024-06-20'},
    );
    return EphemeralKeysModel.fromJson(response.data);
  }

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      var paymentIntentModel = await createPaymentIntent(
        paymentIntentInputModel,
      );

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
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        throw const PaymentFailure("تم إلغاء عملية الدفع بواسطة المستخدم");
      }
      throw PaymentFailure(e.error.message ?? "حدث خطأ غير متوقع أثناء الدفع");
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<String> getOrCreateStripeCustomerId(UserProfileModel user) async {
    if (user.stripeCustomerId != null && user.stripeCustomerId!.isNotEmpty) {
      return user.stripeCustomerId!;
    }

    try {
      var response = await apiService.post(
        url: ApiConstants.customersUrl,
        token: ApiConstants.secretKey,
        contentType: Headers.formUrlEncodedContentType,
        body: {'email': user.email, 'metadata[supabase_id]': user.id},
      );

      String newCustomerId = response.data['id'];

      await Supabase.instance.client
          .from(AppTableNames.profiles)
          .update({'stripe_customer_id': newCustomerId})
          .eq('id', user.id);

      return newCustomerId;
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    } catch (e) {
      throw UnknownFailure("فشل في إنشاء حساب العميل: ${e.toString()}");
    }
  }
}
