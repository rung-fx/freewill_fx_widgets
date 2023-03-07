import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freewill_fx_widgets/fx.dart';
import 'package:freewill_fx_widgets/value_constant.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class FXQrScanner extends StatefulWidget {
  final Color? appBarColor;
  final Color? buttonColor;
  final double? fontSize;

  const FXQrScanner({
    Key? key,
    this.appBarColor = Colors.white,
    this.buttonColor = Colors.black,
    this.fontSize = fontSizeXL,
  }) : super(key: key);

  @override
  State<FXQrScanner> createState() => _FXQrScannerState();
}

class _FXQrScannerState extends State<FXQrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  bool _scanning = true;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        title: FXText(
          'สแกน QR Code',
          color: widget.buttonColor,
          size: widget.fontSize,
          weight: FontWeight.bold,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: widget.buttonColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ],
          ),
          CustomPaint(
            painter: QROverlayPainter(),
            child: Container(),
          ),
        ],
      ),
    );
  }

  _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcode) {
      scanData(barcode);
    });
  }

  scanData(Barcode data) {
    if (_scanning && data.code != null) {
      setState(() {
        _scanning = false;
      });

      Get.back(result: data);
    }
  }
}

class QROverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const paddingLR = 50.0;
    const cornerSize = 25.0;
    final boxSize = Get.width - (paddingLR * 2);
    final top = (size.height / 2) - (boxSize / 2);

    final paint = Paint()..color = Colors.black38;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, Get.width, Get.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                paddingLR,
                top,
                boxSize,
                boxSize,
              ),
              const Radius.circular(20.0),
            ),
          )
          ..close(),
      ),
      paint,
    );

    Paint red = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // TopLeft corner
    canvas.drawLine(
      Offset(paddingLR + cornerSize, top),
      Offset(paddingLR + (cornerSize * 2), top),
      red,
    );
    canvas.drawLine(
      Offset(paddingLR, top + cornerSize),
      Offset(paddingLR, top + (cornerSize * 2)),
      red,
    );
    canvas.drawPath(
      Path()
        ..moveTo(paddingLR, top + cornerSize)
        ..quadraticBezierTo(
          paddingLR,
          top,
          paddingLR + cornerSize,
          top,
        ),
      red,
    );

    // TopRight corner
    canvas.drawLine(
      Offset(paddingLR + boxSize - (cornerSize * 2), top),
      Offset(paddingLR + boxSize - cornerSize, top),
      red,
    );
    canvas.drawLine(
      Offset(paddingLR + boxSize, top + cornerSize),
      Offset(paddingLR + boxSize, top + (cornerSize * 2)),
      red,
    );
    canvas.drawPath(
      Path()
        ..moveTo(paddingLR + boxSize - cornerSize, top)
        ..quadraticBezierTo(
          paddingLR + boxSize,
          top,
          paddingLR + boxSize,
          top + cornerSize,
        ),
      red,
    );

    // BottomLeft corner
    canvas.drawLine(
      Offset(paddingLR + cornerSize, top + boxSize),
      Offset(paddingLR + (cornerSize * 2), top + boxSize),
      red,
    );
    canvas.drawLine(
      Offset(paddingLR, top + boxSize - (cornerSize * 2)),
      Offset(paddingLR, top + boxSize - cornerSize),
      red,
    );
    canvas.drawPath(
      Path()
        ..moveTo(paddingLR, top + boxSize - cornerSize)
        ..quadraticBezierTo(
          paddingLR,
          top + boxSize,
          paddingLR + cornerSize,
          top + boxSize,
        ),
      red,
    );

    // BottomRight corner
    canvas.drawLine(
      Offset(paddingLR + boxSize - (cornerSize * 2), top + boxSize),
      Offset(paddingLR + boxSize - cornerSize, top + boxSize),
      red,
    );
    canvas.drawLine(
      Offset(paddingLR + boxSize, top + boxSize - (cornerSize * 2)),
      Offset(paddingLR + boxSize, top + boxSize - cornerSize),
      red,
    );
    canvas.drawPath(
      Path()
        ..moveTo(paddingLR + boxSize - cornerSize, top + boxSize)
        ..quadraticBezierTo(
          paddingLR + boxSize,
          top + boxSize,
          paddingLR + boxSize,
          top + boxSize - cornerSize,
        ),
      red,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
