import 'package:flutter/material.dart';
import 'package:bichil/library/library.dart';

class IOSwitch extends Switch {
  const IOSwitch({
    super.key,
    super.onChanged,
    required super.value,
  }) : super(
          inactiveTrackColor: IOColors.brand50,
          activeTrackColor: IOColors.brand500,
          trackOutlineWidth: const WidgetStatePropertyAll(0),
          trackOutlineColor: const WidgetStatePropertyAll(
            Colors.transparent,
          ),
          thumbColor: const WidgetStatePropertyAll(
            IOColors.backgroundPrimary,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
}
