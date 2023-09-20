import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/value_constant.dart';

class FXOtp extends StatelessWidget {
  final String testKey1;
  final String testKey2;
  final String testKey3;
  final String testKey4;
  final String testKey5;
  final String testKey6;
  final TextEditingController? textEditingController1;
  final TextEditingController? textEditingController2;
  final TextEditingController? textEditingController3;
  final TextEditingController? textEditingController4;
  final TextEditingController? textEditingController5;
  final TextEditingController? textEditingController6;
  final Color? borderColor;

  const FXOtp({
    Key? key,
    this.testKey1 = '',
    this.testKey2 = '',
    this.testKey3 = '',
    this.testKey4 = '',
    this.testKey5 = '',
    this.testKey6 = '',
    this.textEditingController1,
    this.textEditingController2,
    this.textEditingController3,
    this.textEditingController4,
    this.textEditingController5,
    this.textEditingController6,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OTPBox(
          textEditingController: textEditingController1,
          autoFocus: true,
          testKey: testKey1,
          borderColor: borderColor,
        ),
        OTPBox(
          textEditingController: textEditingController2,
          testKey: testKey2,
          borderColor: borderColor,
        ),
        OTPBox(
          textEditingController: textEditingController3,
          testKey: testKey3,
          borderColor: borderColor,
        ),
        OTPBox(
          textEditingController: textEditingController4,
          testKey: testKey4,
          borderColor: borderColor,
        ),
        OTPBox(
          textEditingController: textEditingController5,
          testKey: testKey5,
          borderColor: borderColor,
        ),
        OTPBox(
          textEditingController: textEditingController6,
          testKey: testKey6,
          borderColor: borderColor,
        ),
      ],
    );
  }
}

class OTPBox extends StatelessWidget {
  final String testKey;
  final bool autoFocus;
  final TextEditingController? textEditingController;
  final Color? borderColor;

  const OTPBox({
    Key? key,
    this.testKey = '',
    this.autoFocus = false,
    this.textEditingController,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 45.0,
      child: TextField(
        key: ValueKey(testKey),
        controller: textEditingController,
        maxLength: 1,
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: fontSizeXL,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.blue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            if (!autoFocus) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
      ),
    );
  }
}

