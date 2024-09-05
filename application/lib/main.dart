import "package:biruwa/Components/homescreen/homescreen.dart";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  print(cameras);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      )),
      home: HomeScreen(),
    );
  }
}
