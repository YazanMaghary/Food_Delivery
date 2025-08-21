import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSceen extends ConsumerWidget {
  const HomeSceen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: const Text("SignOut"),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
          },
        ),
      ),
    );
  }
}
