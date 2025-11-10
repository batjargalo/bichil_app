import 'package:bichil/library/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBarModel {
  final String icon;
  final String label;
  final Widget screen;
  final color = IOColors.textTertiary;
  final activeColor = IOColors.brand500;

  TabBarModel({
    this.icon = '',
    this.label = '',
    required this.screen,
  });
}
