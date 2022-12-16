import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXCurvedButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final String title;
  final String testKey;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding1;
  final EdgeInsetsGeometry padding2;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final Color textColor;
  final double fontSize;

  const FXCurvedButton({
    Key? key,
    required this.width,
    required this.title,
    required this.onTap,
    this.testKey = '',
    this.backgroundColor = Colors.grey,
    this.padding1 = const EdgeInsets.all(10.0),
    this.padding2 = const EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: margin,
    ),
    this.borderRadius = 0.0,
    this.borderWidth = 0.0,
    this.borderColor,
    this.boxShadow,
    this.textColor = Colors.black,
    this.fontSize = fontSizeM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: marginX2),
      child: InkWell(
        key: ValueKey(testKey),
        onTap: onTap,
        child: Container(
          width: width,
          padding: borderWidth == 0
              ? padding1
              : padding2,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: borderWidth,
              color: borderWidth > 0 ? borderColor! : Colors.transparent,
            ),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1.0,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
          ),
          child: Center(
            child: FXText(
              title,
              color: textColor,
              weight: FontWeight.bold,
              size: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
