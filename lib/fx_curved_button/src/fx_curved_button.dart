import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXCurvedButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final String title;
  final String testKey;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color textColor;

  const FXCurvedButton({
    Key? key,
    required this.width,
    required this.title,
    required this.onTap,
    this.testKey = '',
    this.backgroundColor = Colors.grey,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 0.0,
    this.boxShadow,
    this.textColor = Colors.black,
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
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: boxShadow ?? [
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
              size: fontSizeM,
            ),
          ),
        ),
      ),
    );
  }
}