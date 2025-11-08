import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class SavingScreen extends StatelessWidget {
  const SavingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Savings & Investments',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTotalSavingsCard(),
          const SizedBox(height: 24),
          _buildSectionTitle("Investment Distribution"),
          const SizedBox(height: 12),
          _buildDistributionChart(),
          const SizedBox(height: 24),
          _buildSectionTitle("Active Schemes"),
          const SizedBox(height: 12),
          _buildSchemeCard(
            title: "Atal Pension Yojana (APY)",
            subtitle: "Fixed monthly pension after 60.",
            amount: "₹2,000/mo",
            color: Colors.blue,
          ),
          _buildSchemeCard(
            title: "National Pension Scheme (NPS)",
            subtitle: "Long-term retirement savings.",
            amount: "₹1,500/mo",
            color: Colors.green,
          ),
          _buildSchemeCard(
            title: "Post Office Savings",
            subtitle: "Guaranteed returns with security.",
            amount: "₹1,000/mo",
            color: Colors.orange,
          ),
          _buildSchemeCard(
            title: "PorterX Future Fund",
            subtitle: "Emergency & welfare fund.",
            amount: "₹1,500/mo",
            color: Colors.purple,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle("Insurance Coverage"),
          const SizedBox(height: 12),
          _buildInsuranceCard("Term Life Insurance (₹3L)", true),
          _buildInsuranceCard("Accidental Cover (₹2L)", true),
          _buildInsuranceCard("Medical Health Plan", false),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
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

  Widget _buildTotalSavingsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Investments',
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '₹78,500',
            style: GoogleFonts.poppins(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Profit',
                    style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text('₹1,250', style: GoogleFonts.poppins(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("View Details", style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(color: Colors.blue, value: 35, title: '35%', radius: 45, titleStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            PieChartSectionData(color: Colors.green, value: 25, title: '25%', radius: 45, titleStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            PieChartSectionData(color: Colors.orange, value: 20, title: '20%', radius: 45, titleStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            PieChartSectionData(color: Colors.purple, value: 20, title: '20%', radius: 45, titleStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildSchemeCard({required String title, required String subtitle, required String amount, required Color color}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(Icons.account_balance, color: color, size: 24),
        ),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(subtitle, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
        trailing: Text(amount, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: color)),
      ),
    );
  }

  Widget _buildInsuranceCard(String title, bool isActive) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(Icons.shield_outlined, color: isActive ? Colors.green : Colors.grey),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15)),
        trailing: Text(
          isActive ? "Active" : "Inactive",
          style: GoogleFonts.poppins(
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
