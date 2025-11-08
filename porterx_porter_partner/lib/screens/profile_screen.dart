import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24),
          _buildProgressCard(),
          const SizedBox(height: 24),
          _buildSectionTitle("Verification Checklist"),
          const SizedBox(height: 12),
          _buildVerificationTile("Aadhar Card", "Front and back uploaded", true),
          _buildVerificationTile("Photo ID", "Govt. issued ID uploaded", true),
          _buildVerificationTile("Police Verification", "Certificate uploaded", true),
          _buildVerificationTile("Live Selfie", "Pending selfie capture", false, action: "Capture Now"),
          _buildVerificationTile("Physical Verification", "Scheduled for 28 Oct, 2 PM", false, isScheduled: true),
          _buildVerificationTile("Uniform & ID Card", "Collect after verification", false),
          const SizedBox(height: 24),
          _buildSectionTitle("Account Settings"),
          const SizedBox(height: 12),
          _buildProfileOption(Icons.person_outline, "Edit Profile", () {}),
          _buildProfileOption(Icons.lock_outline, "Change Password", () {}),
          _buildProfileOption(Icons.notifications_none, "Notifications", () {}),
          _buildProfileOption(Icons.language, "Language", () {}),
          _buildProfileOption(Icons.logout, "Logout", () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
            );
          }, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage("assets/images/avatar_placeholder.png"),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rajesh Kumar",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "ID: PRT12345",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Verification Progress', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            color: Colors.black,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Text("3 of 6 steps completed", style: GoogleFonts.poppins(color: Colors.grey[700], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildVerificationTile(String title, String subtitle, bool isVerified, {String? action, bool isScheduled = false}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          isVerified ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isVerified ? Colors.green : (isScheduled ? Colors.orange : Colors.grey),
          size: 28,
        ),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15)),
        subtitle: Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
        trailing: action != null
            ? ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(action, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13)),
              )
            : null,
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.grey[700]),
        title: Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: color)),
        trailing: color == null ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey) : null,
        onTap: onTap,
      ),
    );
  }
}
