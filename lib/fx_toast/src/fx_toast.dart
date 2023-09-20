import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXToast extends StatelessWidget {
  final String msg;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry toastPadding;
  final EdgeInsetsGeometry toastMargin;

  const FXToast({
    Key? key,
    required this.msg,
    this.backgroundColor = Colors.black87,
    this.borderRadius = 10.0,
    this.toastPadding = const EdgeInsets.all(margin),
    this.toastMargin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: toastPadding,
      margin: toastMargin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FXText(
        msg,
        color: Colors.white,
        size: fontSizeM,
      ),
    );
  }
}
