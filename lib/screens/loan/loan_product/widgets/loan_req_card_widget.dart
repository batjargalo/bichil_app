import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoanReqCardWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String mainIcon;
  final String duration;
  final String? loanLimit;
  final String? limitDate;
  final String? rightButtonLabel;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final VoidCallback? onRightButtonTap;

  const LoanReqCardWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.mainIcon,
    required this.duration,
    this.loanLimit,
    this.limitDate,
    this.rightButtonLabel,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.onRightButtonTap,
  });

  @override
  State<LoanReqCardWidget> createState() => _LoanReqCardWidgetState();
}

class _LoanReqCardWidgetState extends State<LoanReqCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [_buildTopSection()]),
      ),
    );
  }

  Widget _buildTopSection() {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/${widget.mainIcon}.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(IOColors.brand500, BlendMode.srcIn),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: IOStyles.body2Bold.copyWith(color: IOColors.brand500)),
                      if (widget.subtitle != null)
                        Text(widget.subtitle!, style: IOStyles.caption2Regular.copyWith(color: IOColors.brand500)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (widget.rightButtonLabel != null) ...[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: widget.onSecondaryTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IOColors.brand300,
                      elevation: 0,
                      minimumSize: const Size(80, 30),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(widget.rightButtonLabel!, style: const TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
