import 'package:camerawesome/models/orientations.dart';
import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/services.dart';

class Camerawesome extends StatefulWidget {
  @override
  _CamerawesomeState createState() => _CamerawesomeState();
}

class _CamerawesomeState extends State<Camerawesome>
    with TickerProviderStateMixin {
  // [...]
  // Notifiers

  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.ON);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.VIDEO);
  ValueNotifier<Size> _photoSize = ValueNotifier(null);

  // Controllers
  PictureController _pictureController = new PictureController();
  VideoController _videoController = new VideoController();

// [...]

// [...]
  @override
  Widget build(BuildContext context) {
    return CameraAwesome(
      testMode: false,
      onPermissionsResult: (bool result) {},
      selectDefaultSize: (List<Size> availableSizes) => Size(1080, 720),
      onCameraStarted: () async {
        await _pictureController.takePicture('THE_IMAGE_PATH/myimage.jpg');
        await _videoController.recordVideo('THE_IMAGE_PATH/myvideo.mp4');
        await _videoController.stopRecordingVideo();
      },
      onOrientationChanged: (CameraOrientations newOrientation) {},
      //zoom: 0.64,
      sensor: _sensor,
      photoSize: _photoSize,
      switchFlashMode: _switchFlash,
      captureMode: _captureMode,
      orientation: DeviceOrientation.portraitUp,
      fitted: true,

      imagesStreamBuilder: (imageStream) {
        /// listen for images preview stream
        /// you can use it to process AI recognition or anything else...
        print('-- init CamerAwesome images stream');
      },
    );
  }

// [...]

}
