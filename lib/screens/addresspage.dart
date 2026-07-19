import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressPage extends StatefulWidget {
  final bool fromCheckout;

  const AddAddressPage({super.key, this.fromCheckout = false});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  /// 🔥 ADD ADDRESS FUNCTION
  Future<String> addAddress(String address) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return "User not logged in";

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final doc = await userRef.get();

      if (!doc.exists) return "User document not found";

      /// 🔥 CHECK IF ADDRESS EXISTS
      if (doc.data()!.containsKey('address') &&
          doc['address'] != null &&
          doc['address'].toString().isNotEmpty) {
        return "Address already exists";
      }

      /// ✅ SAVE ADDRESS
      await userRef.set({'address': address}, SetOptions(merge: true));
      Get.back();

      print("✅ Address saved to Firestore");

      return "Address added successfully";
    } catch (e) {
      print("❌ ERROR saving address: $e");
      return "Error: $e";
    }
  }

  /// 🔥 BUTTON FUNCTION (IMPORTANT)
  void saveAddress() async {
    String address = addressController.text.trim();

    if (address.isEmpty) {
      Get.snackbar("Error", "Enter address");
      return;
    }

    setState(() => isLoading = true);

    /// ✅ CALL FUNCTION WITH PARAMETER
    String result = await addAddress(address);

    setState(() => isLoading = false);

    if (result == "Address added successfully") {
      Get.snackbar("Success", result);

      /// 🔥 RETURN TRUE (FOR CHECKOUT FLOW)
      if (widget.fromCheckout) {
        Get.back(result: true);
      } else {
        Get.back();
      }
    } else {
      Get.snackbar("Error", result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text("Add Address", style: TextStyle(color: Colors.white)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔥 ADDRESS FIELD
            TextField(
              controller: addressController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter your address",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Save Address",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
