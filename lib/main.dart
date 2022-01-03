import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:flutter_application_1/provider/location_provider.dart';
import 'package:flutter_application_1/widgets/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Main Page';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: ChangeNotifierProvider<LocationProvider>(
          create: (context) {
            return LocationProvider();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            home: HomePage(),
          ),
        ),
      );
}
