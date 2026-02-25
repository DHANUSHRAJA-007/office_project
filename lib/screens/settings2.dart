import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Settings2 extends StatelessWidget {
  const Settings2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
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
                style: TextStyle(
                  color: const Color.fromARGB(156, 66, 66, 66),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
                        Icons.person,
                        Icons.arrow_forward_ios,
                      ),
                      Divider(),
                      _reportItems(
                        "Change Email",
                        Icons.email,
                        Icons.arrow_forward_ios,
                      ),
                      Divider(),
                      _reportItems(
                        "Change Password",
                        Icons.lock,
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
                style: TextStyle(
                  color: const Color.fromARGB(156, 66, 66, 66),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
                        "Sales Report",
                        Icons.notifications,
                        Icons.arrow_forward_ios,
                      ),
                      Divider(),
                      _reportItems(
                        "Dark Mode",
                        Icons.dark_mode,
                        Icons.arrow_forward_ios,
                      ),
                      Divider(),
                      _reportItems(
                        "Privacy",
                        Icons.privacy_tip,
                        Icons.arrow_forward_ios,
                      ),
                      Divider(),
                      _reportItems(
                        "Terms & Conditions",
                        Icons.file_copy,
                        Icons.arrow_forward_ios,
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
                  title: Text(
                    "Log out",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportItems(String name, IconData icon, icon2) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: IconButton(onPressed: () {}, icon: Icon(icon2)),
    );
  }
}
