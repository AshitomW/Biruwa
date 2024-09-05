import "package:biruwa/Components/Camera/photoscreen.dart";
import "package:biruwa/Components/Camera/previewimage.dart";
import "package:biruwa/Components/homescreen/action_card.dart";
import "package:biruwa/main.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:url_launcher/url_launcher.dart";

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? file;

  Future<void> pickImage() async {
    file = null;
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = pickedFile;
    }
  }

  void uploadImage() {
    pickImage().then((_) {
      if (file == null) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ImagePreview(file: file!);
          },
        ),
      );
    });
  }

  void openWebPage() async {
    final url = Uri.parse("https://plantvillage.psu.edu/plants");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF388E3C), // Balanced dark green
              Color(0xFF66BB6A), // Medium green
              Color(0xFFD4E157),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Size.height,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: Size.height * 0.4),
                      //  height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        color: Color(0xFFF7F7FA),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        padding: const EdgeInsets.symmetric(vertical: 42),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "What Would You Like to Do?",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                ActionCard(
                                  text: "Take Picture",
                                  icon: Icons.camera_alt_outlined,
                                  ClickHandler: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoScreen(cameras),
                                      ),
                                    );
                                  },
                                ),
                                Spacer(),
                                ActionCard(
                                  text: "Upload Picture",
                                  icon: Icons.drive_folder_upload,
                                  ClickHandler: () {
                                    uploadImage();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: ActionCard(
                                text: "Learn About Plants",
                                icon: Icons.menu_book_sharp,
                                ClickHandler: () {
                                  openWebPage();
                                },
                                Width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.health_and_safety, color: Colors.white, size: 28),
                                SizedBox(width: 8),
                                Text(
                                  "Biruwa",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Text(
                              "“Healthy plants, healthy planet.”",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "assets/flower_pot.png",
                                fit: BoxFit.contain,
                                width: Size.width * 0.32,
                                height: Size.height * 0.32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
