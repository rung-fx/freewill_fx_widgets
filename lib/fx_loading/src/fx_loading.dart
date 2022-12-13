import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx_text/fx_text.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';

class FXLoading extends StatelessWidget {
  final Color color;

  const FXLoading({
    Key? key,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black12,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: color,
              ),
              const SizedBox(height: marginX2),
              const FXText(
                'กำลังโหลด',
                color: Colors.black,
                weight: FontWeight.bold,
                size: fontSizeM,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
