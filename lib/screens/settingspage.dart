import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:office_project/screens/loginpage.dart';
import 'package:office_project/screens/privacypolicy.dart';
import 'package:office_project/screens/profilepage.dart';
import 'package:office_project/screens/reports.dart';
import 'package:office_project/screens/termsandcond.dart';
import 'package:office_project/theme_controller.dart';

class Settingspage extends StatelessWidget {
  Settingspage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Account Settings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 480,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        _reportItems(
                          "Profile",
                          '/profile',
                          Icons.person,
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "App Settings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 480,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        Divider(),
                        _reportItems(
                          "Privacy",
                          '/privacy',
                          Icons.privacy_tip,
                          Icons.arrow_forward_ios,
                        ),
                        Divider(),
                        _reportItems(
                          "Terms & Conditions",
                          '/terms',
                          Icons.file_copy,
                          Icons.arrow_forward_ios,
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.dark_mode),
                          title: Text(
                            "Dark Mode",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Switch(
                            focusColor: Theme.of(context).cardColor,
                            value: themeNotifier.value == ThemeMode.dark,
                            onChanged: (value) {
                              themeNotifier.value = value
                                  ? ThemeMode.dark
                                  : ThemeMode.light;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  elevation: 2,
                  shape: BeveledRectangleBorder(),
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: InkWell(
                      child: Text(
                        "Log out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await _auth.signOut();
                      Get.offAll(() => LoginPage());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reportItems(String name, route, IconData icon, icon2) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(icon2),
      onTap: () {
        if (route == '/profile') {
          Get.to(ProfilePage());
        } else if (route == '/report') {
          Get.to(Reports());
        } else if (route == '/privacy') {
          Get.to(PrivacyPolicyPage());
        } else if (route == '/terms') {
          Get.to(TermsAndConditionsPage());
        }
      },
    );
  }
}
