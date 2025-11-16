import 'dart:typed_data';
import 'package:bichil/library/library.dart';
import 'package:bichil/screens/loan/digital_loan_limit/digital_loan_signature/digital_loan_signature_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

HandSignatureControl control = new HandSignatureControl();
ValueNotifier<String?> svg = ValueNotifier<String?>(null);
ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);
ValueNotifier<Map?> savedState = ValueNotifier<Map?>(null);
ValueNotifier<int> pageIndex = ValueNotifier<int>(0);

class DigitalLoanSignatureScreen
    extends GetView<DigitalLoanSignatureController> {
  const DigitalLoanSignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(titleText: "Зээлийн гэрээ"),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: pageIndex,
              builder: (context, index, child) => IndexedStack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      spacing: 24.0,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 3 / 2,
                              child: Container(
                                constraints: BoxConstraints.expand(),
                                color: Colors.white,
                                child: HandSignature(
                                  control: control,
                                  drawer: ShapeSignatureDrawer(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Buttons
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            spacing: 8.0,
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    svg.value = control.toSvg(
                                      color: Colors.blueGrey,
                                      type: SignatureDrawType.shape,
                                      fit: true,
                                    );

                                    rawImage.value = await control.toImage(
                                      color: Colors.purple,
                                      background: Colors.grey,
                                      fit: true,
                                    );
                                  },
                                  child: Text('Илгээх'),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    control.clear();
                                    svg.value = null;
                                    rawImage.value = null;
                                  },
                                  child: Text('Цэвэрлэх'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
