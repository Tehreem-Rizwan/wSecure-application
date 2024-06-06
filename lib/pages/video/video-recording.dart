import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/video/video_player_screen.dart';

class VideoRecording extends StatefulWidget {
  const VideoRecording({Key? key}) : super(key: key);

  @override
  _VideoRecordingState createState() => _VideoRecordingState();
}

class _VideoRecordingState extends State<VideoRecording> {
  late CameraController _cameraController;
  bool _isLoading = true;
  bool _isRecording = false;
  late List<CameraDescription> _cameras;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    _cameras = await availableCameras();
    _cameraController =
        CameraController(_cameras[_selectedCameraIndex], ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  void _toggleCamera() {
    setState(() {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _cameraController = CameraController(
          _cameras[_selectedCameraIndex], ResolutionPreset.max);
      _cameraController.initialize().then((_) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF81C7DC),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AspectRatio(
                    aspectRatio: 10 / 16,
                    child: CameraPreview(_cameraController),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.flip_camera_android),
                          onPressed: _toggleCamera,
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: Icon(_isRecording ? Icons.stop : Icons.circle),
                          onPressed: _recordVideo,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
