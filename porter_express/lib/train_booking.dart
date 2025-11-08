import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:porter_express/AccountScreen.dart';
import 'BookingHistoryScreen.dart';
import 'voice_agent_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'booking_screen.dart';
import '../services/api_service.dart'; // API Service ko import kar raha hoon


class TrainBookingScreen extends StatefulWidget {
  @override
  _TrainBookingScreenState createState() => _TrainBookingScreenState();
}

class _TrainBookingScreenState extends State<TrainBookingScreen> {
  int _selectedIndex = 0; // Track selected tab

  String selectedStation = "Select Station";
  DateTime selectedDate = DateTime.now();
  int passengers = 1;

  // Screens List for Bottom Navigation

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountScreen()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingHistoryScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ White Background
      appBar: AppBar(
        title: Text("Book A Porter"),
        backgroundColor: Colors.redAccent, // ✅ Theme color updated
      ),
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
                    "Welcome to PorterX!",
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("India's First Digital Porter Service App", style: TextStyle(fontSize: 16, color: Colors.white)),
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search Box in Card View
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Train / PNR / Train Name",
                        prefixIcon: Icon(Icons.search, color: Colors.redAccent),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // 📍 Destination Station Dropdown
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking Station", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        DropdownButton<String>(
                          value: selectedStation,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: [
                            "Select Station",
                            "Raipur Jn (R)",
                            "Bilaspur Jn (BSP)",
                            "Nagpur Jn (NGP)",
                            "Mumbai Cst (CST)",
                            "Delhi Jn (DLI)"
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
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // 📅 Date Picker
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date of Booking", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null && pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.redAccent),
                                SizedBox(width: 10),
                                Text("${selectedDate.toLocal()}".split(' ')[0]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // 👥 No. of Passengers
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("No. of Porters Required", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.redAccent),
                              onPressed: () {
                                if (passengers > 1) {
                                  setState(() {
                                    passengers--;
                                  });
                                }
                              },
                            ),
                            Text(passengers.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  passengers++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

// 🧠 Floating Chat Bot + Book a Porter Stack
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // 📌 Book a Porter Button (main button)
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String? userId = prefs.getString('userId');

                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("User not logged in")),
                            );
                            return;
                          }

                          if (selectedStation == "Select Station" || selectedStation.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please select a station")),
                            );
                            return;
                          }

                          var response = await ApiService.submitBooking(
                            userId: userId,
                            station: selectedStation,
                            dateOfBooking: selectedDate,
                            passengers: passengers,
                          );

                          if (response['success']) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Booking is in progress")),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookingScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Booking failed: ${response['message']}")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text(
                          "Book a Porter",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

        // 💬 Floating Chat Bot Button (beside "Book a Porter")
        Positioned(
          right: 16, // give some space from edge
          bottom: 16,
          child: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            elevation: 4,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VoiceAgentScreen()),
              );
            },
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 28),
          ),
        ),


                  ],
                ),

                SizedBox(height: 40),

// 📦 Option Buttons Section (unchanged)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildOptionButton(Icons.confirmation_number, "PNR Status"),
                        _buildOptionButton(Icons.train, "Live Train"),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),


      // 🛠️ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Handle Click
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Booking History"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Transactions"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  // 🔥 Helper Function for Small Buttons
  Widget _buildOptionButton(IconData icon, String text) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 28, color: Colors.redAccent),
          onPressed: () {},
        ),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
      ],
    );
  }
}

