import 'dart:math';
import 'package:flutter/material.dart';

class PaymentSummaryScreen extends StatefulWidget {
  final int trolleyBags;
  final int otherBags;
  final double totalWeight;

  PaymentSummaryScreen({
    required this.trolleyBags,
    required this.otherBags,
    required this.totalWeight,
  });

  @override
  _PaymentSummaryScreenState createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  double porterCharge = 0.0;
  double distanceFee = 0.0;
  double ConvenienceFee = 0.0;
  double gst = 0.0;
  double discount = 0.0;
  double tipAmount = 0.0;

  TextEditingController couponController = TextEditingController();
  TextEditingController instructionController = TextEditingController();

  double get totalAmount =>
      porterCharge  + ConvenienceFee + gst + tipAmount - discount;

  @override
  void initState() {
    super.initState();
    calculateFare();
  }

  void calculateFare() {
    int totalBags = widget.trolleyBags + widget.otherBags;

    // ✅ Porter Fee Logic
    if (totalBags <= 4) {
      porterCharge = 150.0; // base charge for up to 4 bags
    } else {
      int extraBags = totalBags - 4;
      porterCharge = 150.0 + (extraBags * 35.0); // extra charge for bags beyond 4
    }

  // ✅ Distance Fee Logic

    // ✅ Platform Fee = 10% of (porter + distance)
    ConvenienceFee = 0.1 * (porterCharge + distanceFee);

    // ✅ GST = 18% on subtotal (porter + distance + platform)
    gst = 0.18 * (porterCharge + distanceFee + ConvenienceFee);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.pushReplacementNamed(context, "/booking"); // 👈 redirects to BookingScreen
      return false; // Prevent default pop
    },
    child: Scaffold(
    appBar: AppBar(
    title: Text("Payment Summary"),
    backgroundColor: Colors.redAccent,
    leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
    Navigator.pushReplacementNamed(context, "/booking");
    },
    ),
    ),
    body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderCard(),
            buildGlowingBox("Porter Charge", porterCharge, Colors.redAccent),
            buildGlowingBox("Distance Fee", distanceFee, Colors.orangeAccent),
            buildGlowingBox("Convenience Fee (10%)", ConvenienceFee, Colors.deepOrange),
            buildGlowingBox("GST (18%)", gst, Colors.purple),
            buildGlowingBox("Discount", -discount, Colors.green),
            buildTipDropdown(),
            
            buildInstructionField(),
            buildPayButton(),
          ],
        ),
      ),
    )
    );
  }

  Widget buildHeaderCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Payable", style: TextStyle(color: Colors.white70, fontSize: 16)),
              SizedBox(height: 4),
              Text("₹ ${totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 36),
        ],
      ),
    );
  }

  Widget buildGlowingBox(String label, double amount, Color glowColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: glowColor.withOpacity(0.3), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.12),
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("₹ ${amount.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: glowColor)),
        ],
      ),
    );
  }

  Widget buildTipDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Add Tip (Optional)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        DropdownButton<double>(
          value: tipAmount,
          underline: Container(),
          items: [0, 10, 20, 30, 50, 100].map((e) {
            return DropdownMenuItem(value: e.toDouble(), child: Text("₹ $e"));
          }).toList(),
          onChanged: (value) => setState(() => tipAmount = value ?? 0.0),
        )
      ],
    );
  }

  Widget _buildCouponInput() {
    return TextField(
      controller: couponController,
      decoration: InputDecoration(
        labelText: "Apply Coupon Code",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(Icons.check_circle, color: Colors.green),
          onPressed: () {
            if (couponController.text.trim().toLowerCase() == "save50") {
              setState(() => discount = 50.0);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Invalid Coupon")),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildInstructionField() {
    return TextField(
      controller: instructionController,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: "Add Special Instructions (Optional)",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget buildPayButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/summary",
              arguments: totalAmount,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
            shadowColor: Colors.redAccent.withOpacity(0.4),
          ),
          child: Text(
            "Proceed to Pay ₹${totalAmount.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
