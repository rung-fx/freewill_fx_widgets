import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx_text/fx_text.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';

class FXLoading extends StatefulWidget {
  final Color color;

  const FXLoading({
    Key? key,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  State<FXLoading> createState() => _FXLoadingState();
}

class _FXLoadingState extends State<FXLoading> {
  String label = '';

  @override
  void initState() {
    super.initState();
    _getLocale();
  }

  _getLocale() {
    if (Get.locale == const Locale('th_TH') || Get.locale == const Locale('th')) {
      label = 'กำลังโหลด';
    } else if (Get.locale == const Locale('en_EN') || Get.locale == const Locale('en')) {
      label = 'Loading';
    } else {
      label = 'กำลังโหลด';
    }

    setState(() {});
  }

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
                color: widget.color,
              ),
              const SizedBox(height: marginX2),
              FXText(
                label,
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
