import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'home.dart';

class AuthGate extends StatelessWidget {
 const AuthGate({super.key});

 @override
 Widget build(BuildContext context) {
    AssetImage ruExpressAsset = const AssetImage('assets/ruexpress.png');
    Image image = Image(image: ruExpressAsset, width: 400, height: 400);
   return StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
       if (!snapshot.hasData) {
         return SignInScreen(
          showAuthActionSwitch: false,
           providerConfigs: const [
             GoogleProviderConfiguration(
              clientId: "291581242565-mjeocm5vqg9pntpnv5uk4o4mfoa0k5e6.apps.googleusercontent.com",
            )
           ],
           
           subtitleBuilder: (context, action) {
             return const Padding(
               padding: EdgeInsets.symmetric(vertical: 8.0),
               child: Text('Welcome to RUSwipeShare, please sign in with your RUID Gmail account!')
             );
           },
           footerBuilder: (context, action) {
             return const Padding(
               padding: EdgeInsets.only(top: 16),
               child: Text(
                 'By signing in, you agree to our terms and conditions.',
                 style: TextStyle(color: Colors.grey),
               ),
             );
           },
         );
       }

       return const HomeScreen();
     },
   );
 }
}