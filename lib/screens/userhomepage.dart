// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   final String role;

//   const HomePage({super.key, required this.role});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Role: $role')),
//       body: Center(
//         child: Text(
//           'Welcome $role',
//           style: const TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String role;

  const HomePage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Role: $role")),
      body: Center(
        child: Text("Welcome $role", style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
