import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:get/get.dart';

class SignUpInfoController extends IOController {
  final model = Get.arguments as SignUpModel;
  final fields = <SignUpInfoModel>[].obs;

  final back = IOButtonModel(
    label: 'Буцах',
    type: IOButtonType.secondary,
    size: IOButtonSize.medium,
  );
  final next = IOButtonModel(
    label: 'Үргэлжлүүлэх',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fields.value = model.fields;
    setValidation();
  }

  void setValidation() {
    for (var e in fields) {
      switch (e.inputType) {
        case SignUpInfoInputType.select:
          e.dropdown.status.addListener(checkValidation);
          break;
        case SignUpInfoInputType.manual:
          e.field.status.addListener(checkValidation);
          break;
      }
    }
  }

  void checkValidation() {
    var isValid = true;
    for (var e in fields) {
      if (e.isValid == false) {
        isValid = false;
      }
    }
    next.update((val) {
      val?.isEnabled = isValid;
    });
  }

  Future onNext() async {
    Get.focusScope?.unfocus();
    final data = {for (final item in fields) item.paramKey: item.value};
    model.info.addAll(data);
    AuthRoute.toSignUpPassword(model);
    //   isLoading.value = true;
    //   next.update((val) {
    //     val?.isLoading = true;
    //   });

    //   final data = {for (final item in fields) item.paramKey: item.value};
    //   data['phone'] = page.model.phone;
    //   data['otp_token'] = page.model.otpToken;
    //   data['password'] = page.model.password;
    //   Log.warning(JSON(data).toString(), 'name');
    //   final response = await UserApi().register(data: data);
    //   Log.warning(response.json.toString(), 'name');

    //   isLoading.value = false;
    //   next.update((val) {
    //     val?.isLoading = false;
    //   });

    //   if (response.isSuccess) {
    //     await AppRoute.toSuccess(
    //       title: 'Бүртгэл амжилттай үүслээ',
    //       description: 'Та шинэ бүртгэлээ ашиглан нэвтрэх боломжтой',
    //     );
    //     Get.until((route) => route.isFirst);
    //   } else {
    //     showError(text: response.message);
    //   }
  }
}
