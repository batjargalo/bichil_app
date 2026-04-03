import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoanCardWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String mainIcon;
  final String amountLimit;
  final String interest;
  final String duration;
  final String? loanLimit;
  final String? limitDate;
  final String? rightButtonLabel;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final VoidCallback? onRightButtonTap;

  const LoanCardWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.mainIcon,
    required this.amountLimit,
    required this.interest,
    required this.duration,
    this.loanLimit,
    this.limitDate,
    this.rightButtonLabel,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.onRightButtonTap,
  });

  @override
  State<LoanCardWidget> createState() => _LoanCardWidgetState();
}

class _LoanCardWidgetState extends State<LoanCardWidget> {
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [_buildTopSection(), _buildAnimatedFooter()]),
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
                      Text(widget.title, style: IOStyles.body1Bold.copyWith(color: IOColors.brand500)),
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
            const SizedBox(height: 12),
            Row(
              children: [
                _infoItem('money', widget.amountLimit),
                const SizedBox(width: 12),
                _infoItem('clock', widget.duration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedFooter() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      sizeCurve: Curves.easeInOut,
      crossFadeState: (widget.loanLimit != null && _isExpanded) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: const SizedBox(width: double.infinity, height: 0),
      secondChild: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("ЗЭЭЛЖИХ ЭРХ ● ", style: IOStyles.caption2Medium.copyWith(color: IOColors.textTertiary)),
                    Text(
                      " ${widget.loanLimit ?? ''}",
                      style: IOStyles.body2Medium.copyWith(color: IOColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: widget.onPrimaryTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A651),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
              ),
              child: const Text(
                "Зээл авах",
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String icon, String label) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/$icon.svg',
          width: 12,
          height: 12,
          colorFilter: ColorFilter.mode(IOColors.textPrimary, BlendMode.srcIn),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
