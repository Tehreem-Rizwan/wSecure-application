import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  String? _renamedFilePath;

  @override
  void initState() {
    super.initState();
    _renameTempFile();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _renameTempFile() async {
    try {
      // Check if the file has a .temp extension
      if (widget.filePath.endsWith('.temp')) {
        // Rename the file to have a .mp4 extension
        _renamedFilePath = widget.filePath.replaceAll('.temp', '.mp4');
        File originalFile = File(widget.filePath);
        await originalFile.rename(_renamedFilePath!);
        _initVideoPlayer(_renamedFilePath!);
      } else {
        _renamedFilePath = widget.filePath;
        _initVideoPlayer(widget.filePath);
      }
    } catch (e) {
      print('Error renaming file: $e');
    }
  }

  Future<void> _initVideoPlayer(String filePath) async {
    _videoPlayerController = VideoPlayerController.file(File(filePath))
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.setLooping(true);
        _videoPlayerController.play();
      });
  }

  Future<void> _saveVideoLocally() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Get the external storage directory
        Directory? externalDir = await getExternalStorageDirectory();
        if (externalDir == null) {
          throw 'External storage is not available';
        }

        // Define the path for the video
        String fileName = _renamedFilePath!.split('/').last;
        String newPath = '${externalDir.path}/$fileName';

        // Copy the video file to the new path
        File originalFile = File(_renamedFilePath!);
        await originalFile.copy(newPath);
        print('Video saved locally: $newPath');

        // Notify the system that a new file has been added to the gallery
        final result = await File(newPath).exists();
        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Video saved locally: $newPath'),
            duration: Duration(seconds: 2),
          ));
        } else {
          throw 'Failed to save video locally';
        }
      } catch (e) {
        print('Error saving video locally: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to save video locally: $e'),
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      print('Permission to access storage was denied');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permission to access storage was denied'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> _uploadVideoToFirebase() async {
    try {
      File videoFile = File(_renamedFilePath!);
      String fileName = videoFile.path.split('/').last;
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('videos/$fileName');
      await firebaseStorageRef.putFile(videoFile);
      print('Video uploaded to Firebase Storage: $fileName');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Video uploaded to Firebase Storage: $fileName'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print('Error uploading video to Firebase: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload video to Firebase: $e'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preview',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
            onPressed: () async {
              await _saveVideoLocally();
              await _uploadVideoToFirebase();
              print('Video saved locally and uploaded to Firebase Storage');
            },
          ),
        ],
      ),
      body: Center(
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
