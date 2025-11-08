import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart'; // import your login screen file

void main() {
  runApp(const PorterPartnerApp());
}

class PorterPartnerApp extends StatelessWidget {
  const PorterPartnerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PorterX Partner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
