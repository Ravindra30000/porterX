import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Imagegra
          Positioned.fill(
            child: Image.asset(
              'assets/splash_image.png', // Apna image yaha set karo
              fit: BoxFit.cover, // Screen fill karne ke liye
            ),
          ),

          // Dark Overlay for Better Visibility
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(.15), // Black transparent overlay
            ),
          ),

          // Get Started Button (Image ke andar)
          Positioned(
            bottom: 100, // Neeche position karne ke liye
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent.withOpacity(0.9),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
