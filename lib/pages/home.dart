import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text("Sign Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
