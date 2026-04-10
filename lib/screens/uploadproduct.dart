// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:office_project/screens/adddetailspage.dart';

// class UploadProductPage extends StatefulWidget {
//   const UploadProductPage({super.key});

//   @override
//   State<UploadProductPage> createState() => _UploadProductPageState();
// }

// class _UploadProductPageState extends State<UploadProductPage> {
//   final ImagePicker picker = ImagePicker();

//   List<XFile> images = [];

//   /// -------- PICK IMAGES ----------
//   Future<void> pickImages() async {
//     final List<XFile>? picked = await picker.pickMultiImage();

//     if (picked != null) {
//       setState(() {
//         images = picked;
//       });
//     }
//   }

//   /// -------- IMAGE BUILDER (Web + Mobile Support) ----------
//   Widget buildImage(XFile image) {
//     if (kIsWeb) {
//       return FutureBuilder(
//         future: image.readAsBytes(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return Image.memory(
//             snapshot.data!,
//             height: 150,
//             width: 120,
//             fit: BoxFit.cover,
//           );
//         },
//       );
//     } else {
//       return Image.file(
//         File(image.path),
//         height: 150,
//         width: 120,
//         fit: BoxFit.cover,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,

//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         backgroundColor: const Color(0xff4CAF50),
//         title: const Text("Product", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),

//             const Text(
//               "Upload Images",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 8),

//             const Text(
//               "Select atleast one image for your product.",
//               style: TextStyle(color: Colors.grey),
//             ),

//             const SizedBox(height: 30),

//             /// ✅ DOTTED UPLOAD BOX
//             GestureDetector(
//               onTap: pickImages,
//               child: DottedBorder(
//                 borderType: BorderType.RRect,
//                 radius: const Radius.circular(12),
//                 dashPattern: const [6, 4],
//                 color: Colors.grey,
//                 strokeWidth: 1.5,

//                 child: Container(
//                   width: double.infinity,
//                   height: 180,
//                   color: Colors.white,

//                   child: images.isEmpty
//                       /// EMPTY STATE
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Icon(
//                               Icons.cloud_upload,
//                               size: 50,
//                               color: Color(0xff4CAF50),
//                             ),

//                             SizedBox(height: 10),

//                             Text("Drag & drop your files here"),

//                             SizedBox(height: 5),

//                             Text("OR"),

//                             SizedBox(height: 5),

//                             Text(
//                               "Browse Files",
//                               style: TextStyle(
//                                 color: Color(0xff4CAF50),
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ],
//                         )
//                       /// IMAGE PREVIEW
//                       : ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: images.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8),
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: buildImage(images[index]),
//                                   ),

//                                   Positioned(
//                                     top: 5,
//                                     right: 5,
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           images.removeAt(index);
//                                         });
//                                       },
//                                       child: const CircleAvatar(
//                                         radius: 12,
//                                         backgroundColor: Colors.red,
//                                         child: Icon(
//                                           Icons.close,
//                                           size: 14,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ),
//             ),

//             const Spacer(),

//             /// SAVE BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xff4CAF50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),

//                 // onPressed: () {
//                 //   if (images.isEmpty) {
//                 //     ScaffoldMessenger.of(context).showSnackBar(
//                 //       const SnackBar(content: Text("Upload atleast one image")),
//                 //     );
//                 //     return;
//                 //   } else {
//                 //     Get.to(Adddetailspage());
//                 //   }

//                 //   print("Images Selected: ${images.length}");
//                 // },
//                 onPressed: () => Get.to(Adddetailspage()),
//                 child: const Text(
//                   "Next",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/adddetailspage.dart';

class UploadProductPage extends StatefulWidget {
  const UploadProductPage({super.key});

  @override
  State<UploadProductPage> createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {

  /// ✅ ASSET IMAGES
  List<String> assetImages = [
    "assets/images/img1.png",
    "assets/images/img2.png",
    "assets/images/img3.png",
    "assets/images/img4.png",
    "assets/images/img5.png",
  ];

  /// ✅ SELECTED IMAGES
  List<String> selectedImages = [];

  /// ✅ PICK FROM ASSETS (BOTTOM SHEET)
  void pickImages() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: assetImages.length,
          itemBuilder: (context, index) {
            final image = assetImages[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (!selectedImages.contains(image)) {
                    selectedImages.add(image);
                  }
                });
                Navigator.pop(context);
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),

                  /// ✅ SELECTED CHECK
                  if (selectedImages.contains(image))
                    const Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.check, size: 14, color: Colors.white),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// ✅ IMAGE BUILDER
  Widget buildImage(String image) {
    return Image.asset(
      image,
      height: 150,
      width: 120,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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

            /// ✅ UPLOAD BOX
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

                  child: selectedImages.isEmpty

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
                            Text("Tap to choose product images"),
                            SizedBox(height: 5),
                            Text("OR"),
                            SizedBox(height: 5),
                            Text(
                              "Browse Assets",
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
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: buildImage(selectedImages[index]),
                                  ),

                                  /// REMOVE BUTTON
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedImages.removeAt(index);
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

            /// ✅ NEXT BUTTON
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
                  if (selectedImages.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Upload atleast one image"),
                      ),
                    );
                    return;
                  }

                  Get.to(Adddetailspage());
                },

                child: const Text(
                  "Next",
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