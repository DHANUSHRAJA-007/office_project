import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UploadProductPage extends StatefulWidget {
  const UploadProductPage({super.key});

  @override
  State<UploadProductPage> createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final ImagePicker picker = ImagePicker();

  
  List<XFile> images = [];

  /// -------- PICK IMAGES ----------
  Future<void> pickImages() async {
    final List<XFile>? picked = await picker.pickMultiImage();

    if (picked != null) {
      setState(() {
        images = picked;
      });
    }
  }

  /// -------- IMAGE BUILDER (Web + Mobile Support) ----------
  Widget buildImage(XFile image) {
    if (kIsWeb) {
      return FutureBuilder(
        future: image.readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Image.memory(
            snapshot.data!,
            height: 150,
            width: 120,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.file(
        File(image.path),
        height: 150,
        width: 120,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: const Color(0xff4CAF50),
        title: const Text("Product", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Upload Images",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Select atleast one image for your product.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            /// ✅ DOTTED UPLOAD BOX
            GestureDetector(
              onTap: pickImages,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 4],
                color: Colors.grey,
                strokeWidth: 1.5,

                child: Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.white,

                  child: images.isEmpty
                      /// EMPTY STATE
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.cloud_upload,
                              size: 50,
                              color: Color(0xff4CAF50),
                            ),

                            SizedBox(height: 10),

                            Text("Drag & drop your files here"),

                            SizedBox(height: 5),

                            Text("OR"),

                            SizedBox(height: 5),

                            Text(
                              "Browse Files",
                              style: TextStyle(
                                color: Color(0xff4CAF50),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        )
                      /// IMAGE PREVIEW
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: buildImage(images[index]),
                                  ),

                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                      child: const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),

            const Spacer(),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (images.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Upload atleast one image")),
                    );
                    return;
                  }

                  print("Images Selected: ${images.length}");
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
