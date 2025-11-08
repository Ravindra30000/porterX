import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SuccessScreen extends StatelessWidget {
  final double amount;
  final String bookingId;
  final String porterName;
  final String porterPhone;

  const SuccessScreen({
    required this.amount,
    required this.bookingId,
    required this.porterName,
    required this.porterPhone,
  });

  Future<void> saveBookingHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList("bookingHistory") ?? [];

    final now = DateTime.now();
    final booking = {
      "bookingDate": DateFormat('yyyy-MM-dd').format(now),
      "bookingTime": DateFormat('h:mm a').format(now),
      "stationName": "Raipur Jn (R)", // TODO: Pass real station name if available
      "trainNumber": "12834", // TODO: Pass real train number if available
      "totalPayment": "₹${amount.toStringAsFixed(0)}",
      "coolieName": porterName,
      "cooliePhone": porterPhone,
      "coolieBatch": "B1278" // TODO: Pass real batch ID if available
    };

    history.add(jsonEncode(booking));
    await prefs.setStringList("bookingHistory", history);
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
    DateFormat('dd MMMM yyyy').format(DateTime.now());

    // Save booking immediately when the screen builds
    saveBookingHistory();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/success.json',
                width: 150,
                height: 150,
                repeat: false,
              ),
              SizedBox(height: 20),
              Text(
                "🎉 Congratulations!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 10),
              Text(
                "Porter Booked Successfully",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _receiptRow("Booking ID:", bookingId),
                    _receiptRow("Porter Name:", porterName),
                    _receiptRow("Porter Mobile No.:", porterPhone),
                    _receiptRow("Amount Paid:",
                        "₹${amount.toStringAsFixed(2)}"),
                    _receiptRow("Date:", formattedDate),
                    _receiptRow("Payment Mode:", "UPI (Paytm)"),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/dashboard", (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Go to Home",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
