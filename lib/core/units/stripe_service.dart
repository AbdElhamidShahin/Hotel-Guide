import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../features/payment/data/model/payment_intent_input_model.dart';
import '../../features/payment/data/model/payment_intent_model.dart';
import 'api_constants.dart';
import 'api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
        body: paymentIntentInputModel.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        url: ApiConstants.Url,
        token: ApiConstants.secretKey);

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "abdo"));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }


  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}

//createPaymentIntent
//initPaymentSheet
//displayPaymentSheet
//makePayment
