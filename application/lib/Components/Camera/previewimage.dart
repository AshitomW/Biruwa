import 'dart:io';

import 'package:biruwa/Components/Camera/photoscreen.dart';
import 'package:biruwa/Components/homescreen/action_card.dart';
import 'package:biruwa/Components/results/resultsview.dart';
import 'package:biruwa/main.dart';
import 'package:biruwa/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final XFile file;
  ImagePreview({required this.file, super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            PopTillFirst(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Preview",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF7F7FA),
              borderRadius: BorderRadius.circular(12),
            ),
            width: size.width * 0.3,
            height: size.height * 0.3,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(14),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Lighter shadow color
                          blurRadius: 3, // Subtle blur effect
                          spreadRadius: 0.25, // No spread
                          offset: Offset(2, 2), // Small offset
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        picture,
                        width: double.infinity,
                        height: size.height * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ActionCard(
                          Height: 96,
                          text: "Predict",
                          ClickHandler: () async {
                            PopTillFirst(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Results(picture: picture),
                              ),
                            );
                          },
                          icon: Icons.send,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {},
        label: Text("Submit"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

    // child: Image.file(
              //   picture,
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              // ),