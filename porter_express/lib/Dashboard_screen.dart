import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedStation = "Select a Station"; // Default station text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Railway Porter Service"),
        backgroundColor: Colors.redAccent,
      ),

      // Side Menu Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome!",
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Porter Service App", style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.red),
              title: Text("About Us"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.red),
              title: Text("Contact Us"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.red),
              title: Text("Join Us"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.report, color: Colors.red),
              title: Text("Complaint"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.feedback, color: Colors.red),
              title: Text("Feedback"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.comment, color: Colors.red),
              title: Text("Suggestion"),
              onTap: () {},
            ),
          ],
        ),
      ),

      // Main Dashboard Body
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Your Destination Station",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Dropdown for Railway Stations
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red),
              ),
              child: DropdownButton<String>(
                value: selectedStation,
                isExpanded: true,
                underline: SizedBox(),
                items: [
                  "Select a Station",
                  "Raipur Junction",
                  "Bilaspur Junction",
                  "Nagpur Station",
                  "Delhi Junction",
                  "Mumbai Central"
                ].map((String station) {
                  return DropdownMenuItem<String>(
                    value: station,
                    child: Text(station),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedStation = newValue!;
                  });
                },
              ),
            ),

            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Booking Process Start Karne Ka Logic Yaha Aayega
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Proceed to Booking", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
