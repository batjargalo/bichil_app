import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpInfoScreen extends GetView<SignUpInfoController> {
  const SignUpInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: IOScaffold(
          appBar: IOAppBar(
            titleText: 'Бүртгүүлэх',
          ),
          body: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Та мэдээллээ оруулна уу.',
                    style: IOStyles.h6,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    final item = controller.fields[index];
                    return SignUpInfoFieldWidget(model: item);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                  itemCount: controller.fields.length,
                ),
              )
            ],
          ),
          bottomNavigationBar: IOBottomNavigationBar(
            child: IOButtonWidget(
              model: controller.next.value,
              onPressed: controller.onNext,
            ),
          ),
        ),
      ),
    );
  }
}
