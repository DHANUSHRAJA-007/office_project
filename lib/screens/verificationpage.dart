// import 'package:flutter/material.dart';

// class VerificationPage extends StatelessWidget {
//   const VerificationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isTablet = size.width > 600;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(

//           child: SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: isTablet ? 420 : double.infinity,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 10),

//                     // Back button (UI only)
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.arrow_back),
//                     ),

//                     SizedBox(height: size.height * 0.05),

//                     // Title
//                     const Text(
//                       "Verification code",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     // Subtitle
//                     const Text(
//                       "Please enter the verification code we sent\n"
//                       "to your email address",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         height: 1.4,
//                       ),
//                     ),

//                     SizedBox(height: size.height * 0.06),

//                     // OTP circles (UI only)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: List.generate(
//                         4,
//                         (_) => _otpCircle(),
//                       ),
//                     ),

//                     SizedBox(height: size.height * 0.06),

//                     // Resend text (UI only)
//                     const Text(
//                       "Resend in 00:10",
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),

//                     SizedBox(height: size.height * 0.1),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),

//     );
//   }

//   // OTP Circle UI
//   static Widget _otpCircle() {
//     return Container(
//       width: 56,
//       height: 56,
//       decoration: BoxDecoration(

//       ),
//       child: TextField(
//         maxLength: 1,
//         decoration: InputDecoration(
//             counterText: "",
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/forgotpass.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              IconButton(
                onPressed: () {
                  Get.to(Forgotpass());
                },
                icon: const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 40),

              const Text(
                "Verification code",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const Text(
                "Please enter the verification code we sent\n"
                "to your email address",
                style: TextStyle(color: Colors.grey, height: 1.4),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) => _otpField(index)),
              ),

              const SizedBox(height: 40),

              const Text(
                "Resend in 00:10",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C1B18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        onChanged: (value) {
          // Move forward
          if (value.isNotEmpty && index < 3) {
            focusNodes[index + 1].requestFocus();
          }

          // Move backward
          if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
