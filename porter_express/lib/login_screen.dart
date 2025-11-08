import 'package:flutter/material.dart';
import 'package:porter_express/services/api_service.dart';
import 'otp_screen.dart';



class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}


class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController mobileController = TextEditingController();
  String selectedCountryCode = '+91';
  String selectedFlag = '🇮🇳';

  final List<Map<String, String>> countries = [
    {'code': '+91', 'flag': '🇮🇳'},
    {'code': '+93', 'flag': '🇦🇫'},
    {'code': '+94', 'flag': '🇱🇰'},
    {'code': '+95', 'flag': '🇲🇲'},
    {'code': '+97', 'flag': '🌍'},
    {'code': '+1', 'flag': '🇺🇸'},
  ];

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: countries.map((country) {
            return ListTile(
              leading: Text(country['flag']!, style: TextStyle(fontSize: 24)),
              title: Text("${country['code']}"),
              onTap: () {
                setState(() {
                  selectedCountryCode = country['code']!;
                  selectedFlag = country['flag']!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.red.shade700,
      body: Center(
        child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Login to continue booking",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40),

            Text("Mobile Number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),

            Row(
              children: [
                InkWell(
                  onTap: _showCountryPicker,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      children: [
                        Text(selectedFlag, style: TextStyle(fontSize: 20)),
                        SizedBox(width: 4),
                        Text(
                          selectedCountryCode,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: "Enter your mobile number",
                      counterText: "",
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String mobile = mobileController.text.trim();

                  if (mobile.isNotEmpty && mobile.length == 10) {
                    var result = await ApiService.loginWithMobile(mobile);

                    if (result['success']) {
                      // Navigate to OTP screen or next step
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(mobileNumber: mobile),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result['message'] ?? "Login failed")),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Enter valid 10-digit mobile number")),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade500,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      )
    );

  }
}
