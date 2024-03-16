// // ignore_for_file: unnecessary_null_comparison

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CameraApp(),
//     );
//   }
// }

// class CameraApp extends StatefulWidget {
//   @override
//   _CameraAppState createState() => _CameraAppState();
// }

// class _CameraAppState extends State<CameraApp> {
//   late CameraController _controller;

//   @override
//   void initState() {
//     super.initState();

//     availableCameras().then((cameras) {
//       if (cameras.isNotEmpty) {
//         _controller = CameraController(cameras[0], ResolutionPreset.max,
//             imageFormatGroup: ImageFormatGroup.jpeg);
//         _controller.initialize().then((_) {
//           if (!mounted) {
//             return;
//           }
//           setState(() {});
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_controller == null || !_controller.value.isInitialized) {
//       return Container();
//     }

//     return Scaffold(
//       body: Center(
//           child: Stack(
//         children: [
//           Positioned.fill(
//             child: CameraPreview(_controller),
//           ),
//           Container(
//             height: 80,
//             width: double.infinity,
//             decoration:
//                 const BoxDecoration(color: Color.fromARGB(106, 0, 0, 0)),
//             child: Row(
//               children: [],
//             ),
//           )
//         ],
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _takePicture();
//         },
//         child: const Icon(Icons.camera),
//       ),
//     );
//   }

//   void _takePicture() async {
//     if (!_controller.value.isInitialized) {
//       return;
//     }
//     final XFile file = await _controller.takePicture();
//     print(file.path);

//     // Alınan fotoğrafı işlemek için kullanabilirsiniz.
//   }
// }
