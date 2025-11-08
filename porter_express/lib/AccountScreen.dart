import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  final String mobileNumber = "+91 98765 43210";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          "My Account",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              // Add Help Action
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // 🔹 Mobile Number
          Text(
            "Logged in as",
            style: GoogleFonts.poppins(color: Colors.grey[600]),
          ),
          SizedBox(height: 5),
          Text(
            mobileNumber,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),

          // 🔸 My Account
          ExpansionTile(
            leading: Icon(Icons.person_outline, color: Colors.redAccent),
            title: Text("My Account", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            children: [
              ListTile(
                title: Text("Favourite Journey", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
              ListTile(
                title: Text("Settings", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
            ],
          ),

          // 🔸 Payment & Refund
          ExpansionTile(
            leading: Icon(Icons.payment_outlined, color: Colors.redAccent),
            title: Text("Payment & Refund", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            children: [
              ListTile(
                title: Text("Refund Status", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
              ListTile(
                title: Text("Payment Modes", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
              ListTile(
                title: Text("Help & Support", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
            ],
          ),

          // 🔸 Previous Journeys
          ExpansionTile(
            leading: Icon(Icons.train_outlined, color: Colors.redAccent),
            title: Text("Previous Journeys", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            children: [
              ListTile(
                title: Text("Favourite Journeys", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
              ListTile(
                title: Text("Last Trip", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
            ],
          ),

          // 🔸 Refer & Earn
          ExpansionTile(
            leading: Icon(Icons.card_giftcard_outlined, color: Colors.redAccent),
            title: Text("Refer & Earn Program", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            children: [
              ListTile(
                title: Text("Refer a Friend", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
              ListTile(
                title: Text("Earn Money", style: GoogleFonts.poppins()),
                onTap: () {},
              ),
            ],
          ),

          // 🔸 Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text("Logout", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            onTap: () {
              // Handle logout logic
            },
          ),

          SizedBox(height: 40),

          // 🔻 App Version
          Center(
            child: Text(
              "Porter Express v1.0.0",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
