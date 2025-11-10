import 'package:flutter/material.dart';
import 'package:bichil/library/library.dart';

class IOOtpTimerWidget extends StatefulWidget {
  final IOOtpTimerModel model;
  final VoidCallback? onTap;
  const IOOtpTimerWidget({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  State<IOOtpTimerWidget> createState() => _IOOtpTimerState();
}

class _IOOtpTimerState extends State<IOOtpTimerWidget> {
  @override
  void initState() {
    super.initState();
    widget.model.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // widget.model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: widget.model.isTimerEnded
          ? IOButtonWidget(
              model: widget.model.buttonModel,
              onPressed: widget.onTap,
            )
          : Text(
              '${widget.model.minute}:${widget.model.second}',
              style: IOStyles.caption1Bold.copyWith(
                color: IOColors.brand500,
              ),
            ),
    );
  }
}
