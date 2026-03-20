import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:g_json/g_json.dart';

class DigitalLoanLimitDanController extends IOController {
  final webController = WebViewController();
  final danUrl = '$domain/api/user/authorize?score=true';
  final chargeAmount = 0.0.obs;
  final limitChargeLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    webController
      // ..setBackgroundColor(IOColors.backgroundSecondary)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isInitialLoading.value = true;
          },
          onPageFinished: (String url) {
            isInitialLoading.value = false;
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('sms:')) {
              launchUrlString(request.url);
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https://api.bichilglobus.mn/api/user/callback-dan')) {
              getData(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(danUrl),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${HelperManager.token.access}"},
      );
  }

  Future getData(String urlString) async {
    isLoading.value = true;

    try {
      final responses = await Dio().get(urlString);
      final res = IOClient.getResponse(responses);
      if (res.isSuccess) {
        // final amount = chargeAmount.value;

        isLoading.value = true;
        limitChargeLoading.value = true;

        final response = await LoanApi().payLimitCharge(amount: 2700);

        isLoading.value = false;
        limitChargeLoading.value = false;

        if (response.isSuccess) {
          onResult(
            danId: responses.data["data"]["dan_id"].toString(),
            data: response.data,
            amount: 2700,
            payType: LoanLimitType.create,
          );
        } else if (response.message == "Та өөрийн ашигладаг мэйл хаягаа бүртгүүлнэ үү") {
          toWarningEmail(titleText: 'Анхаарна уу.', text: response.message, buttonText: 'Мэйл хаяг бүртгүүлэх');
        } else {
          showError(text: response.message);
        }
        // Get.back();
        // LoanRoute.toCreateAmount();
        // LoanRoute.toDigitalLoanContract();
        // Get.back(result: res.data);
      } else {
        Get.back();
        showError(text: res.message);
      }
    } on DioException catch (error) {
      final response = IOClient.getErrorResponse(error);
      Get.back();
      showError(text: response.message);
    }
  }

  Future getChargeAmount() async {
    chargeAmount.value = 2700;
  }

  Future onResult({
    required String danId,
    required JSON data,
    required double amount,
    required LoanLimitType payType,
  }) async {
    final fee = data['fee'].ddoubleValue;
    final invoice = data['local_invoice_number'].stringValue;
    final urls = data['urls'].listValue.map((e) => QpayDanModel.fromJson(e)).toList();
    final typeText = switch (payType) {
      LoanLimitType.create => 'Эрх тогтоох',
      LoanLimitType.change => 'эрх шинэчлэх',
    };
    final info = [
      QpayDanInfoModel(title: 'Төрөл', value: typeText),
      // QpayInfoModel(title: 'Төлөх мөнгөн дүн', value: amount.toCurrency()),
      // QpayInfoModel(title: 'Qpay хураамж', value: fee.toCurrency()),
      QpayDanInfoModel(title: 'Нийт төлөх дүн', value: (fee + amount).toCurrency()),
    ];
    final qpay = QpayDanScreenModel(title: 'Зээлийн эрх', invoice: invoice, info: info, urls: urls);
    final result = await AppRoute.toQpayDan(model: qpay, danId: danId);
    if (result == null) return;
  }
}
