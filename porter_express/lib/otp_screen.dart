import 'package:flutter/material.dart';
import 'package:porter_express/train_booking.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  OtpScreen({required this.mobileNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    String otp = controllers.map((e) => e.text).join();
    if (otp.length == 6) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TrainBookingScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid 6-digit OTP")),
      );
    }
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 48,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      appBar: AppBar(
        backgroundColor: Colors.red.shade500,
        elevation: 0,
        title: Text("Verify OTP"),
        centerTitle: true,
      ),
      body: Center(
    child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              "Enter the OTP sent to 🇮🇳 +91-${widget.mobileNumber}",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            SizedBox(height: 40),

            // 🔲 OTP Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _buildOtpBox(index)),
            ),

            SizedBox(height: 40),

            // ✅ Verify Button
            Center(
              child: ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade500,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Verify", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
