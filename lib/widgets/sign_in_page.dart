import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image.asset(
                    "images/driver2.jpg",
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Driver Application",
              style: TextStyle(
                  color: Color.fromRGBO(236, 179, 101, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 160, left: 50, right: 50),
              child: ElevatedButton.icon(
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Color.fromRGBO(4, 28, 50, 1),
                  size: 30,
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white,
                    minimumSize: const Size(70, 40)),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                // ignore: prefer_const_constructors
                label: Text(
                  "Login with google",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(4, 28, 50, 1)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
