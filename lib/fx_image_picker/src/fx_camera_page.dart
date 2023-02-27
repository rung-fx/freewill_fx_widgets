import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FXCameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final ResolutionPreset resolution;

  const FXCameraPage({
    Key? key,
    required this.cameras,
    required this.resolution,
  }) : super(key: key);

  @override
  State<FXCameraPage> createState() => _CameraPage();
}

class _CameraPage extends State<FXCameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void initState() {
    super.initState();
    initCamera(
      widget.cameras![0],
      widget.resolution,
    );
  }

  void _takePicture(BuildContext context) async {
    try {
      final image = await _cameraController.takePicture();

      Get.back(result: File(image.path));
    } catch (e) {
      log(e.toString());
    }
  }

  Future initCamera(
      CameraDescription camera, ResolutionPreset resolution) async {
    _cameraController = CameraController(camera, resolution);

    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          (_cameraController.value.isInitialized)
              ? CameraPreview(_cameraController)
              : Container(
            color: Colors.black,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: InkWell(
                onTap: () {
                  _takePicture(context);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 28.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 27.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: InkWell(
                onTap: () {
                  setState(
                          () => _isRearCameraSelected = !_isRearCameraSelected);
                  initCamera(
                    widget.cameras![_isRearCameraSelected ? 0 : 1],
                    ResolutionPreset.medium,
                  );
                },
                child: const CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.cached_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
