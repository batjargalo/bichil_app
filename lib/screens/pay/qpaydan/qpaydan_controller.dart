import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QpayDanController extends IOSuperController {
  final QpayDanScreenModel model;
  final String danId;
  final loadingScore = false.obs;
  final check = IOButtonModel(label: 'Төлбөр шалгах', type: IOButtonType.primary, size: IOButtonSize.medium).obs;
  QpayDanController({required this.model, required this.danId});

  @override
  void onResumed() {
    checkPayment();
  }

  Future onCheck(QpayDanModel item) async {
    try {
      await launchUrlString(item.link, mode: LaunchMode.externalApplication);
    } catch (e) {
      showWarning(text: 'Уг банкний аппликейшнийг суулгана уу', acceptText: 'Тийм');
    }
  }

  Future checkPayment() async {
    if (isLoading.value) return;

    isLoading.value = true;
    check.update((val) {
      val?.isLoading = true;
    });

    final response = await InfoApi().checkQpayInvoice(invoice: model.invoice);

    if (response.isSuccess) {
      final paid = response.data['status'].stringValue;
      isLoading.value = false;
      // Get.back(
      //   result: true,
      // ); // Prod орчинд оруулахад энэ мөрийг идэвхгүй болгож доор байгаа шалгалтыг нээх хэрэгтэй
      if (paid == 'paid') {
        loadingScore.value = true;
        showSuccess(text: 'Таны төлбөр амжилттай төлөгдсөн байна.');
        final response = await LoanApi().calculateScore(danId: danId);

        if (response.isSuccess) {
          check.update((val) {
            val?.isLoading = false;
          });
          Get.until((route) => route.isFirst);
          if (Get.isRegistered<LoanProductController>()) {
            Get.find<LoanProductController>().onRefresh();
          }
        } else {
          showError(text: response.message);
          Get.until((route) => route.isFirst);
          if (Get.isRegistered<LoanProductController>()) {
            Get.find<LoanProductController>().onRefresh();
          }
        }
      } else {
        showWarning(text: 'Таны төлбөр төлөгдөөгүй байна', acceptText: 'Ойлголоо');
        Get.until((route) => route.isFirst);
        if (Get.isRegistered<LoanProductController>()) {
          Get.find<LoanProductController>().onRefresh();
        }
      }
    } else {
      showError(text: response.message);
    }
  }
}
