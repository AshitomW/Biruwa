import "package:biruwa/Components/Camera/previewimage.dart";
import "package:camera/camera.dart";
import "package:flutter/material.dart";

class PhotoScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  PhotoScreen(this.cameras);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late CameraController controller;

  bool isRearCamera = true;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    controller =
        CameraController(isRearCamera ? widget.cameras[0] : widget.cameras[1], ResolutionPreset.high);

    try {
      await controller.initialize();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void flipCamera() async {
    setState(() {
      isRearCamera = !isRearCamera;
    });
    await initializeCamera();
  }

  void toggleDeviceFlash() async {
    if (isFlashOn) {
      await controller.setFlashMode(FlashMode.off);
    } else {
      await controller.setFlashMode(FlashMode.torch);
    }

    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  void takePicture() async {
    if (!controller.value.isInitialized) {
      return;
    }
    if (controller.value.isTakingPicture) {
      return;
    }
    try {
      XFile picture = await controller.takePicture();
      Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePreview(file: picture)));
    } on CameraException catch (error) {
      debugPrint("Error : ${error}");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: CameraPreview(controller),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                        onPressed: () {
                          flipCamera();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                        ),
                        child: Icon(
                          Icons.flip_camera_ios,
                          size: 30,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                        onPressed: () {
                          takePicture();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                        ),
                        child: Icon(
                          Icons.camera,
                          size: 30,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                        onPressed: () {
                          toggleDeviceFlash();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                        ),
                        child: Icon(
                          isFlashOn ? Icons.flash_on : Icons.flash_off,
                          size: 30,
                        )),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
