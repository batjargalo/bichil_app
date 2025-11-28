import 'package:bichil/library/library.dart';
import 'package:bichil/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanPledgeListScreen extends GetView<LoanPledgeListController> {
  const LoanPledgeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = controller.uiItems;
    return IOScaffold(
      appBar: IOAppBar(titleText: 'Барьцаа хөрөнгө'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: items.isEmpty
            ? const IOEmptyWidget()
            : ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final model = items[index];
                  return IOCardBorderWidget(
                    child: LoanPledgeTile(model: model),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: items.length,
              ),
      ),
    );
  }
}
