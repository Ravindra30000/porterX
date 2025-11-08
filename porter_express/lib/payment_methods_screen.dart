import 'package:flutter/material.dart';
import 'success_screen.dart'; // Make sure this import is correct

class PaymentMethodsScreen extends StatelessWidget {
  final double amount;

  const PaymentMethodsScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Payment Method"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text("Payable Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                trailing: Text("₹ ${amount.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
            Text("Select Payment Option", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            _paymentOption("Razorpay", Icons.account_balance_wallet),
            _paymentOption("Paytm", Icons.payment),
            _paymentOption("UPI", Icons.qr_code_scanner),
            _paymentOption("Credit / Debit Card", Icons.credit_card),
            _paymentOption("Net Banking", Icons.language),
            Spacer(),

            // ✅ Complete Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SuccessScreen(
                        amount: amount,
                        bookingId: "#PORT${DateTime.now().millisecondsSinceEpoch % 1000000}",
                        porterName: "Rajesh Kumar",
                        porterPhone: "9876543210",
                      ),
                    ),
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Complete Payment & Book",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Payment Option Widget
  Widget _paymentOption(String title, IconData icon) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.redAccent),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {

        },
      ),
    );
  }
}
