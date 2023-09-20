import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXSwitch extends StatelessWidget {
  final bool onOffMode;
  final bool onOffCondition;
  final Color? onColor;
  final Color? offColor;
  final String onText;
  final String offText;
  final bool onSelected;
  final bool offSelected;
  final Function()? onTap;

  const FXSwitch({
    Key? key,
    this.onOffMode = true,
    this.onOffCondition = true,
    this.onColor,
    this.offColor,
    this.onText = 'เปิด',
    this.offText = 'ปิด',
    required this.onSelected,
    required this.offSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 32.0,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: _switchColor(),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: customBoxShadow,
      ),
      child: onOffMode
          ? Row(
              children: [
                _switch(
                  title: onText,
                  isSelected: onSelected,
                ),
                _switch(
                  title: offText,
                  isSelected: offSelected,
                ),
              ],
            )
          : Row(
              children: [
                _switch(
                  title: onText,
                  isSelected: onSelected,
                ),
                _switch(
                  title: offText,
                  isSelected: offSelected,
                ),
              ],
            ),
    );
  }

  _switch({
    required bool isSelected,
    required String title,
  }) {
    return GestureDetector(
      onScaleStart: (value) {
        if (value.pointerCount == 1) {
          if (onTap != null) {
            onTap!();
          }
        }
      },
      onTap: onTap,
      child: !isSelected
          ? Container(
              width: 28.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: isSelected ? customBoxShadow : null,
              ),
              child: FXText(
                title,
                size: fontSizeM,
                weight: FontWeight.bold,
                color: Colors.white,
                align: TextAlign.center,
              ),
            )
          : Container(
              width: 28.0,
              height: 28.0,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: isSelected ? customBoxShadow : null,
              ),
              child: const SizedBox(),
            ),
    );
  }

  _switchColor() {
    if (onOffMode) {
      if (onOffCondition) {
        return onColor ?? const Color.fromRGBO(1, 158, 223, 1);
      } else {
        return offColor ?? Colors.grey.shade400;
      }
    } else {
      return offColor ?? Colors.grey.shade400;
    }
  }
}
