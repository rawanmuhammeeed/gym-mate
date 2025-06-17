import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';

class Camerascreen extends StatefulWidget {
  const Camerascreen({Key? key}) : super(key: key);

  @override
  State<Camerascreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<Camerascreen> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  Timer? _timer;

  final String userId = "684c461a50fe6fec20928088"; // ثابت
  final String exerciseType = "Bicep Curl"; // لازم يكون مضبوط بالضبط

  String _result = "";

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    final frontCamera = _cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => _cameras[0],
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _controller.initialize();
    if (mounted) {
      setState(() => _isCameraInitialized = true);

      _timer = Timer.periodic(const Duration(seconds: 2), (_) {
        captureAndSendFrame();
      });
    }
  }

  Future<void> captureAndSendFrame() async {
    if (!_controller.value.isInitialized || _controller.value.isTakingPicture) return;

    try {
      final directory = await getTemporaryDirectory();
      final imagePath = join(directory.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

      XFile picture = await _controller.takePicture();
      File imageFile = File(picture.path);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://mo7amedsalah-gym-form-correction.hf.space/analyze_frame/$exerciseType/$userId"),
      );

      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);

        print("🔍 Full Response JSON: $jsonResponse");

        setState(() {
          _result = """
Feedback: ${jsonResponse['feedback'] ?? 'N/A'}
Reps Counter: ${jsonResponse['counter'] ?? 'N/A'}
Angles: ${jsonResponse['angles'] ?? 'N/A'}
""";
        });
      } else {
        debugPrint("❌ Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Camera (Selfie)'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isCameraInitialized
                ? CameraPreview(_controller)
                : const Center(child: CircularProgressIndicator()),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              _result.isNotEmpty ? _result : "Waiting for AI response...",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
