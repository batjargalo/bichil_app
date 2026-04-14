import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LineLoanCardWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String mainIcon;
  final String duration;
  final String? loanLimit;
  final String? limitDate;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onRightButtonTap;

  const LineLoanCardWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.mainIcon,
    required this.duration,
    this.loanLimit,
    this.limitDate,
    this.onPrimaryTap,
    this.onRightButtonTap,
  });

  @override
  State<LineLoanCardWidget> createState() => _LineLoanCardWidgetState();
}

class _LineLoanCardWidgetState extends State<LineLoanCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/${widget.mainIcon}.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(IOColors.brand500, BlendMode.srcIn),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.title, style: IOStyles.body2Bold.copyWith(color: IOColors.brand500)),
                      if (widget.subtitle != null)
                        Text(widget.subtitle!, style: IOStyles.caption2Regular.copyWith(color: IOColors.brand500)),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: IOColors.brand500,
                  size: 20,
                ),
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
                    Text("ЗЭЭЛИЙН ЭРХ ● ", style: IOStyles.caption2Medium.copyWith(color: IOColors.textTertiary)),
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
}
