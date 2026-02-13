import 'dart:convert';
import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/digital_loan_create/digital_loan_ceate_amount/models/digital_loan_create_model.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class DigitalLoanSignatureController extends IOController {
  final html = ''.obs;
  final DigitalLoanCreateModel? item;

  DigitalLoanSignatureController({required this.item});
  HandSignatureControl control = HandSignatureControl();
  ValueNotifier<String?> svg = ValueNotifier<String?>(null);
  ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);
  ValueNotifier<Map?> savedState = ValueNotifier<Map?>(null);
  ValueNotifier<int> pageIndex = ValueNotifier<int>(0);
  final isConfirmed = false.obs;

  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final clearSig = IOButtonModel(
    label: 'Арилгах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: true,
  ).obs;

  final sentSig = IOButtonModel(
    label: 'Зөвшөөрөх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: true,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    onTapClear();
    ever(isConfirmed, (value) {
      next.update((val) {
        val?.isEnabled = value;
      });
    });
  }

  Future onTapNext() async {}
  Future onTapClear() async {
    control.clear();
    svg.value = null;
    rawImage.value = null;
  }

  Future onTapSend() async {
    final args = Get.arguments as Map<String, dynamic>?;
    final contractId = args?['contractId'];
    rawImage.value = await control.toImage(
      color: Colors.black,
      background: Colors.white,
      fit: true,
    );
    List<int> imageBytes = rawImage.value?.buffer.asUint8List() ?? [];
    String base64Image = base64Encode(imageBytes);
    sendSignature(
      image: "data:image/png;base64,$base64Image",
      contractId: contractId,
    );
  }

  Future sendSignature({required String image, required int contractId}) async {
    isInitialLoading.value = true;
    final response = await LoanApi().sendSignature(
      image: image,
      contract: contractId,
      term_lem: item!.term,
      total_amount: item!.amount,
    );

    if (response.isSuccess) {
      html.value = response.data['body'].stringValue;
      onTapClear();
      final responseLoan = await LoanApi().createDigitalLoan(model: item!);
      if (!responseLoan.isSuccess) {
        isInitialLoading.value = false;
        showError(text: responseLoan.message);
        return;
      }
      await showSuccess(text: 'Амжилттай илгээлээ');

      // Get.back();
      IOPages.toHome();
    } else {
      Get.back();
      showError(text: response.message);
    }
  }
}
