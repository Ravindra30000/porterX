import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:porter_express/payment_summary_screen.dart';
import 'package:porter_express/services/api_service.dart';
import '../services/api_service.dart';
import 'package:porter_express/select_porter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingScreen extends StatefulWidget {
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController(text: "Purnendra Dhirhi");
  final ageController = TextEditingController(text: "20");
  final mobileController = TextEditingController(text: "9876543210");
  final trainController = TextEditingController();
  final coachController = TextEditingController();
  final seatController = TextEditingController();
  final weightController = TextEditingController();


  int trolleyBags = 0;
  int otherBags = 0;
  bool isLoading = false;


  void handleSubmit() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        mobileController.text.isEmpty ||
        trainController.text.isEmpty ||
        coachController.text.isEmpty ||
        (seatController.text.isEmpty && !isGeneralTicket) ||
        weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❗ Please fill all required fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    // ✅ Get userId from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ User not logged in")),
      );
      setState(() => isLoading = false);
      return;
    }

    // ✅ Now pass userId to your API
    final result = await ApiService.submitPassengerData(
      userId: userId,
      name: nameController.text.trim(),
      age: int.tryParse(ageController.text.trim()) ?? 0,
      mobileNumber: mobileController.text.trim(),
      trainno: trainController.text.trim(),
      trainCoach: coachController.text.trim(),
      seatNumber: seatController.text.isNotEmpty ? seatController.text : "NA",
      totalBagWeight: double.tryParse(weightController.text.trim()) ?? 0,
      trolleyBags: trolleyBags,
      otherBags: otherBags,
    );

    setState(() => isLoading = false);
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Booking is in progress!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSummaryScreen(
            trolleyBags: trolleyBags,
            otherBags: otherBags,
            totalWeight: double.tryParse(weightController.text.trim()) ?? 0,
          ),
        ),
      );

    }
   else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Booking failed: ${result['message']}")),
      );
    }
  }
  String? generalTicketChoice;
  bool isGeneralTicket = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Passenger Booking Details"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            buildLabel("Passenger Name"),
            buildTextField(controller: nameController, hint: "Enter Full Name"),

            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("Age"),
                      buildTextField(
                          controller: ageController,
                          hint: "Enter Age",
                          keyboardType: TextInputType.number),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel("Mobile Number"),
                      buildTextField(
                          controller: mobileController,
                          hint: "Enter Mobile No.",
                          keyboardType: TextInputType.phone),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),
            // General Ticket Selection
            buildLabel("Are you travelling in General Ticket?"),
            DropdownButtonFormField<String>(
              value: generalTicketChoice,
              hint: Text("Select Yes or No"),
              onChanged: (value) {
                setState(() {
                  generalTicketChoice = value;
                  isGeneralTicket = value == "Yes";
                  if (isGeneralTicket) {
                    coachController.text = "GS";
                    seatController.text = "NA"; // ✅ Fix added
                  } else {
                    coachController.clear();
                    seatController.clear();
                  }
                });
              },
              items: ['Yes', 'No'].map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),


            AbsorbPointer(
              absorbing: generalTicketChoice == null,
              child: Opacity(
                opacity: generalTicketChoice == null ? 0.5 : 1.0,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      children: [
                        // Train No
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildLabel("Train No."),
                              buildTextField(
                                controller: trainController,
                                hint: "Ex: 021458",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),

                        // Coach
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildLabel("Train Coach"),
                              buildTextField(
                                controller: coachController,
                                hint: isGeneralTicket ? "GS" : "Ex: B2, S3",
                                keyboardType: TextInputType.text,
                                enabled: !isGeneralTicket,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),

                        // Seat No
                        // Seat Number (Always shown, disabled if general ticket)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildLabel("Seat No"),
                              buildTextField(
                                controller: seatController,
                                hint: isGeneralTicket ? "NA" : "Ex: 53, 78",
                                enabled: !isGeneralTicket, // ❌ Can't edit if General
                              ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),


            SizedBox(height: 15),
            buildLabel("Total Bag Weight (kg) - Max 40kg"),
            buildTextField(
                controller: weightController,
                hint: "Enter Weight",
                keyboardType: TextInputType.number),

            SizedBox(height: 20),
            buildLabel("Number of Bags- Max 4 Bags Per Porter"),
            BagSelectorCard(
              title: "Trolley Bags",
              count: trolleyBags,
              onIncrement: () => setState(() => trolleyBags++),
              onDecrement: () =>
                  setState(() => trolleyBags = trolleyBags > 0 ? trolleyBags - 1 : 0),
            ),
            SizedBox(height: 12),
            BagSelectorCard(
              title: "Extra Bags",
              count: otherBags,
              onIncrement: () => setState(() => otherBags++),
              onDecrement: () =>
                  setState(() => otherBags = otherBags > 0 ? otherBags - 1 : 0),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  if (generalTicketChoice == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Selection Required"),
                        content: Text("Please select whether you are travelling in General Ticket."),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                    return; // Stop further execution
                  }

                  // If general ticket is selected, proceed with submission
                  handleSubmit();
                },
                child: Text(
                  "Proceed to Book Coolie",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

              ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true, // add this line
  }) {
    return TextField(
      controller: controller,
      enabled: enabled, // use it here
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
    );
  }
}

class BagSelectorCard extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const BagSelectorCard({
    super.key,
    required this.title,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset('assets/subtract.svg', width: 24, height: 24),
                onPressed: onDecrement,
              ),
              Text('$count', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: SvgPicture.asset('assets/add.svg', width: 30, height: 30),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
