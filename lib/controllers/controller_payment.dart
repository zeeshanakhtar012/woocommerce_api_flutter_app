import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zrj/model/product.dart';
import '../model/user.dart';

class PaymentsController extends GetxController {
  static const stripePublishableKey = "pk_test_51QK3OSKuV05bCvMeTcEqLo612iOCFZ8B3CG5BVRgG6nycWMX0VkhhZnaumh7W3uBTzyDdT7CNm8NjM8uF1yRgToW00IxYTH05s";
  final String apiKey = "sk_test_51QK3OSKuV05bCvMel64lq3Q2FeWdtJciwv1TxBXshz8qUqrjOkDuSEba7VqGyglWW4HrLlGBTyIeBLuvXfM8MlCe00IxXuVp58";
  final String wooCommerceApiUrl = "https://zrjfashionstyle.com/wp-json/wc/v3/orders";

  Rx<bool> paymentLoading = false.obs;
  Map<String, dynamic>? paymentIntent;

  @override
  void onInit() {
    super.onInit();
    Stripe.publishableKey = stripePublishableKey;
    Stripe.instance.applySettings();
  }

  Future<void> makePayment(String amount, Product product, UserModel user, {Function(Map<String, dynamic> infoData)? onSuccess, Function(String error)? onError}) async {
    try {
      paymentLoading(true);

      paymentIntent = await createPaymentIntent(amount, product.id.toString());

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customerId: "1",
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: "ZRJ",
          // applePay: PaymentSheetApplePay(
          //   merchantCountryCode: "PK",
          // ),
          googlePay: PaymentSheetGooglePay(
              currencyCode: "PKR",
              merchantCountryCode: "PK", testEnv: true),
        ),
      );

      Map<String, dynamic> infoData = {
        "id": "${paymentIntent?["id"] ?? ""}",
        "status": "requires_payment_method",
        "amount": ((paymentIntent?["amount"] ?? -100) / 100),
        "created": paymentIntent?["created"] ?? 0,
        "currency": paymentIntent?["currency"] ?? "",
        "livemode": paymentIntent?["livemode"] ?? false,
        "payment_method": "",
        "product_details": {
          "id": product.id,
          "name": product.name,
          "description": product.description,
          "price": product.price,
        },
        "user_details": {
          "first_name": user.firstName,
          "last_name": user.lastName,
          "email": user.email,
          "phone": user.billing!.phone
        }
      };

      await displayPaymentSheet(onSuccess, onError, infoData);
    } catch (err) {
      log(err.toString());
      if (onError != null) {
        onError(err.toString());
      }
    } finally {
      paymentLoading(false);
    }
  }

  Future<void> displayPaymentSheet(Function(Map<String, dynamic> infoData)? onSuccess, Function(String error)? onError, Map<String, dynamic> infoData) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        final paymentIntentId = infoData["id"];
        final paymentIntentDetails = await retrievePaymentIntent(paymentIntentId);

        infoData["status"] = paymentIntentDetails['status'];
        infoData["payment_method"] = paymentIntentDetails['payment_method'];

        paymentIntent = null;

        if (paymentIntentDetails['status'] == 'succeeded') {
          await createWooCommerceOrder(infoData, infoData['user_details'], infoData['product_details']);
        }

        if (onSuccess != null) {
          onSuccess(infoData);
        }
      });
    } catch (e) {
      log('$e');
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String productId) async {
    try {
      final String corsUrl = "https://corsproxy.io/?";
      final String baseUrl = '${corsUrl}https://api.stripe.com/v1/payment_intents';

      var headers = <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $apiKey',
      };

      var response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: {
          "amount": (double.parse(amount) * 100).toStringAsFixed(0),
          "currency": "usd",
          "payment_method_types[]": "card",
          "metadata[product_id]": productId,
        },
      );

      log(response.body);

      return json.decode(response.body);
    } catch (err) {
      log(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> retrievePaymentIntent(String paymentIntentId) async {
    try {
      final String corsUrl = "https://corsproxy.io/?";
      final String baseUrl = '${corsUrl}https://api.stripe.com/v1/payment_intents/$paymentIntentId';

      var headers = <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $apiKey',
      };

      var response = await http.get(
        Uri.parse(baseUrl),
        headers: headers,
      );

      log(response.body);

      return json.decode(response.body);
    } catch (err) {
      log(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<void> createWooCommerceOrder(Map<String, dynamic> paymentInfo, Map<String, dynamic> userDetails, Map<String, dynamic> productDetails) async {
    try {
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('ck_your_consumer_key:cs_your_consumer_secret'))}',
      };

      var orderData = {
        "payment_method": paymentInfo['method'],
        "payment_method_title": paymentInfo['method_title'],
        "set_paid": true,
        "billing": {
          "first_name": userDetails['first_name'],
          "last_name": userDetails['last_name'],
          "email": userDetails['email'],
          "phone": userDetails['phone'],
          "address_1": userDetails['address1'] ?? '',
          "address_2": userDetails['address2'] ?? '',
          "city": userDetails['city'] ?? '',
          "state": userDetails['state'] ?? '',
          "postcode": userDetails['postcode'] ?? '94103',
          "country": userDetails['country'] ?? 'US'
        },
        "shipping": {
          "first_name": userDetails['first_name'],
          "last_name": userDetails['last_name'],
          "address_1": userDetails['address1'] ?? '',
          "address_2": userDetails['address2'] ?? '',
          "city": userDetails['city'] ?? '',
          "state": userDetails['state'] ?? '',
          "postcode": userDetails['postcode'] ?? '94103',
          "country": userDetails['country'] ?? 'US'
        },
        "line_items": [
          {
            "product_id": productDetails['id'],
            "quantity": productDetails['quantity'],
            "total": productDetails['price'],
            "name": productDetails['name'],
          }
        ],
        "shipping_lines": [
          {
            "method_id": "flat_rate",
            "method_title": "Flat Rate",
            "total": productDetails['price']
          }
        ]
      };

      var response = await http.post(
        Uri.parse('https://zrjfashionstyle.com/wp-json/wc/v3/orders'),
        headers: headers,
        body: json.encode(orderData),
      );

      if (response.statusCode == 201) {
        String cleanedResponse = response.body.replaceFirst('JWT route is registered', '');
        var responseBody = json.decode(cleanedResponse);

        log('Order created successfully:');
        log('Order ID: ${responseBody['id']}');
        log('Status: ${responseBody['status']}');
        log('Total: ${responseBody['total']} ${responseBody['currency']}');
      } else {
        log('Failed to create order: ${response.body}');
      }
    } catch (err) {
      log('Error creating WooCommerce order: $err');
      throw Exception("Failed to create order: $err");
    }
  }
}
