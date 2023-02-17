import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FXCameraPage extends StatefulWidget {
  final CameraDescription camera;
  final Color color;

  const FXCameraPage({
    Key? key,
    required this.camera,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  FXCameraPageState createState() => FXCameraPageState();
}

class FXCameraPageState extends State<FXCameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: _initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                _takePicture(context);
              },
              child: Icon(
                Icons.camera_alt,
                color: widget.color,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;
      XFile file = await _cameraController.takePicture();

      Get.back(result: file.path);
    } catch (e) {
      // print(e);
    }
  }
}
