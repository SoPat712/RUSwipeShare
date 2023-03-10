import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = "pk_test_51MfY7PFVdcWv896FKvDhgKabYeDq4AnoFcWxCAg4hquj6TBAsN0kznXPVyKA7M1pMq5PsieGQwsx6QY5ld5ZQzJ500rVCMPPXp";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color.fromARGB(255, 40, 40, 40),
          filled: true,
          outlineBorder: BorderSide(
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 205, 0, 48),
          ),
          focusColor: Colors.white,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 205, 0, 48),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(),
        fixTextFieldOutlineLabel: true,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(24),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 205, 0, 48)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        primarySwatch: CustomMaterialColor(205, 0, 48).mdColor,
        scaffoldBackgroundColor: Colors.black87,
        fontFamily: GoogleFonts.figtree().fontFamily,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: CustomMaterialColor(240, 240, 240).mdColor,
              displayColor: CustomMaterialColor(240, 240, 240).mdColor,
            ),
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(color: CustomMaterialColor(240, 240, 240).mdColor)))),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStatePropertyAll(CustomMaterialColor(240, 240, 240).mdColor),
          checkColor: MaterialStatePropertyAll(Colors.black),
        ),
      ),
      home: const AuthGate(),
    );
  }
}

class CustomMaterialColor {
  final int r;
  final int g;
  final int b;

  CustomMaterialColor(this.r, this.g, this.b);

  MaterialColor get mdColor {
    Map<int, Color> color = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
    return MaterialColor(Color.fromRGBO(r, g, b, 1).value, color);
  }
}
