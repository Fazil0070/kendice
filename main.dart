import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kendice/controllers/screens/profile/profile_screen.dart';
import 'package:kendice/controllers/screens/profile/my_profile.dart';
import 'package:kendice/controllers/screens/profile/terms.dart';
import 'package:kendice/controllers/screens/profile/privacy.dart';
import 'package:kendice/firebase_options.dart';
import 'package:kendice/loginstudent.dart';
import 'package:kendice/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(const Loca());
}

class Loca extends StatelessWidget {
  const Loca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      title: "location",
      initialRoute: '/',
      routes: {
        '/': (context) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.hasData) {
                  return const ProfileScreen();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Login();
                }
              },
            ),
        '/profile': (context) => const ProfileScreen(),
        '/my_profile': (context) =>
            const MyProfileScreen(), // Changed route to '/my_profile'
        '/terms': (context) => TermsScreen(),
        '/privacy': (context) => PrivacyScreen(),
      },
    );
  }
}
