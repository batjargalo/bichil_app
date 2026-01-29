import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QpayController extends IOSuperController {
  final QpayScreenModel model;
  final check = IOButtonModel(
    label: 'Төлбөр шалгах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
  ).obs;
  QpayController({required this.model});

  @override
  void onResumed() {
    checkPayment();
  }

  Future onCheck(QpayModel item) async {
    try {
      await launchUrlString(item.link, mode: LaunchMode.externalApplication);
    } catch (e) {
      showWarning(
        text: 'Уг банкний аппликейшнийг суулгана уу',
        acceptText: 'Тийм',
      );
    }
  }

  Future checkPayment() async {
    if (isLoading.value) return;

    isLoading.value = true;
    check.update((val) {
      val?.isLoading = true;
    });

    final response = await InfoApi().checkQpayInvoice(invoice: model.invoice);

    isLoading.value = false;
    check.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      // final paid = response.data['status'].stringValue;
      Get.back(
        result: true,
      ); // Prod орчинд оруулахад энэ мөрийг идэвхгүй болгож доор байгаа шалгалтыг нээх хэрэгтэй
      // if (paid == 'paid') {
      //   Get.back(result: true);
      // } else {
      //   showWarning(text: 'Таны төлбөр төлөгдөөгүй байна', acceptText: 'Ойлголоо');
      // }
    } else {
      showError(text: response.message);
    }
  }
}
