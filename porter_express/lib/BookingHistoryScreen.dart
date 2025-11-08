import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:porter_express/coolie_complaint_screen.dart';
import 'package:porter_express/customer_support_screen.dart';

import 'TrackporterScreen.dart';

class BookingHistoryScreen extends StatefulWidget {
  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  List<Map<String, dynamic>> bookingHistory = [];

  @override
  void initState() {
    super.initState();
    loadBookingHistory();
  }

  Future<void> loadBookingHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList("bookingHistory") ?? [];
    setState(() {
      bookingHistory =
          history.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking History"),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: bookingHistory.isEmpty
            ? Center(child: Text("No booking history available"))
            : ListView.builder(
          itemCount: bookingHistory.length,
          itemBuilder: (context, index) {
            final booking = bookingHistory[index];

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text("📅 ${booking["bookingDate"]}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text("⏰ ${booking["bookingTime"]}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text("🚉 ${booking["stationName"]}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    Text("🚆 Train No: ${booking["trainNumber"]}",
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey[700])),
                    SizedBox(height: 8),
                    Text(
                        "💰 Total Payment: ${booking["totalPayment"]}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                    Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                        height: 20),
                    Text("🏋️ Coolie Name: ${booking["coolieName"]}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("📞 Coolie Phone: ${booking["cooliePhone"]}",
                        style: TextStyle(fontSize: 16)),
                    Text("🆔 Coolie Batch: ${booking["coolieBatch"]}",
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey[700])),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoolieComplaintScreen()),
                            );
                          },
                          icon: Icon(Icons.report_problem, color: Colors.white),
                          label: Text("Raise Complaint"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerSupportScreen()),
                            );
                          },
                          icon: Icon(Icons.phone, color: Colors.white),
                          label: Text("Ask Call Back"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12), // spacing between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrackPorterScreen()),
                            );
                          },
                          icon: Icon(Icons.location_on, color: Colors.white),
                          label: Text("Track Your Porter"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
