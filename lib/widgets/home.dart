import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/map_page.dart';

import 'package:flutter_application_1/widgets/profile.dart';
import 'package:flutter_application_1/widgets/sign_in_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return GoogleMapScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something Wrong'),
            );
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
