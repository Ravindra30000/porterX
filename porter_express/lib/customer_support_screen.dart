import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatefulWidget {
  @override
  _CustomerSupportScreenState createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  String selectedCategory = 'General Inquiry';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final List<String> supportCategories = [
    'General Inquiry',
    'Booking Issue',
    'Payment Issue',
    'Coolie Not Assigned',
    'Coolie Misbehaved',
    'Refund Request',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Support"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.phone_forwarded),
            onPressed: () {
              // maybe show contact options here
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Request a Callback", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Your Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),

            SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: supportCategories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              decoration: InputDecoration(
                labelText: "Select Issue Category",
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Describe your issue",
                alignLabelWithHint: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),

            SizedBox(height: 25),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add backend logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Callback Request Submitted"))
                  );
                },
                icon: Icon(Icons.call),
                label: Text("Request Callback"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
