import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> requests = const [
    {
      'name': 'Amit Sharma',
      'phone': '+91 98765 43210',
      'pickup': 'Terminal 1, Gate 3',
      'destination': 'Parking Area B',
      'bags': 3,
      'fare': 150,
      'payment': 'Cash',
      'eta': '2 mins',
    },
    {
      'name': 'Priya Patel',
      'phone': '+91 98765 43211',
      'pickup': 'Terminal 2, Gate 5',
      'destination': 'Metro Station',
      'bags': 2,
      'fare': 120,
      'payment': 'Online',
      'eta': '5 mins',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Incoming Requests",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: requests.length,
        itemBuilder: (context, i) {
          final req = requests[i];
          return _buildRequestCard(context, req);
        },
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Map<String, dynamic> req) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader(req),
            const SizedBox(height: 12),
            _buildLocationInfo(
                icon: Icons.location_on_outlined,
                label: "Pickup",
                value: req['pickup'],
                color: Colors.green),
            const SizedBox(height: 8),
            _buildLocationInfo(
                icon: Icons.location_on,
                label: "Destination",
                value: req['destination'],
                color: Colors.red),
            const Divider(height: 24, thickness: 1, color: Color(0xFFF2F2F2)),
            _buildCardFooter(req),
            const SizedBox(height: 16),
            _buildActionButtons(context, req),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(Map<String, dynamic> req) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              req['name'],
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              req['phone'],
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            req['eta'],
            style: GoogleFonts.poppins(
              color: Colors.orange[800],
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo(
      {required IconData icon, required String label, required String value, required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 13),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardFooter(Map<String, dynamic> req) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _footerItem(Icons.work_outline, '${req['bags']} bags'),
        _footerItem(Icons.payment, req['payment']),
        Text(
          '₹${req['fare']}',
          style: GoogleFonts.poppins(
            color: Colors.green[700],
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _footerItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 18),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[800]),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, Map<String, dynamic> req) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Accepted ${req['name']}'s request")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Accept",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Rejected ${req['name']}'s request")),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Reject",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
