import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'dashboard_screen.dart';
import 'train_booking.dart';
import 'booking_screen.dart';
import 'payment_summary_screen.dart';
import 'payment_methods_screen.dart';
import 'success_screen.dart';
import 'login_screen.dart';
import 'select_porter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Porter Express',
      theme: ThemeData(
        primarySwatch: Colors.red, // Swiggy/Zomato-like red theme
        fontFamily: 'Poppins',     // Optional custom font
      ),
      initialRoute: "/", // Splash screen at launch
      routes: {
        "/": (context) => SplashScreen(),
        "/dashboard": (context) => TrainBookingScreen(),
        "/booking": (context) => BookingScreen(),
        "/login": (context) => LoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/summary') {
          final amount = settings.arguments as double;
          return MaterialPageRoute(
            builder: (context) => PaymentMethodsScreen(amount: amount),
          );
        }
        return null;
      },
    );
  }
}