import 'package:bichil/library/library.dart';
import 'package:bichil/screens/home/home.dart';
import 'package:flutter/material.dart';

class HomeSavingWidget extends StatelessWidget {
  final HomeProductModel model;
  final ValueChanged<HomeProductModel> onTap;
  const HomeSavingWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOGesture(
      onTap: () => onTap(model),
      child: AspectRatio(
        aspectRatio: 2.8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4E7BDF),
                Color(0xFF504CFE),
              ],
            ),
            image: DecorationImage(
              image: NetworkImage(
                model.image,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              model.name,
              style: IOStyles.body1Bold.copyWith(
                color: IOColors.backgroundPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
