import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthMain extends StatelessWidget {
  static const String id = "auth_main";
  const AuthMain({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ChatScreen();
      } else {
        return WelcomeScreen();
      }
    });
  }
}