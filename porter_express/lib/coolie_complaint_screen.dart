import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CoolieComplaintScreen extends StatefulWidget {
  const CoolieComplaintScreen({Key? key}) : super(key: key);

  @override
  _CoolieComplaintScreenState createState() => _CoolieComplaintScreenState();
}

class _CoolieComplaintScreenState extends State<CoolieComplaintScreen> {
  String? selectedCategory;
  String? selectedSubCategory;
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  final picker = ImagePicker();

  final Map<String, List<String>> complaintData = {
    'Behavior Issue': ['Rude Behavior', 'Misconduct', 'Unprofessional'],
    'Service Issue': ['Late Arrival', 'Did Not Show Up', 'Overcharging'],
    'Other': ['Lost Item', 'Fraud', 'Others'],
  };

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Raise a Complaint"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Help action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Complaint Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  hint: const Text("Select Category"),
                  value: selectedCategory,
                  items: complaintData.keys
                      .map((cat) => DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                      selectedSubCategory = null;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (selectedCategory != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sub Category",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        hint: const Text("Select Subcategory"),
                        value: selectedSubCategory,
                        items: complaintData[selectedCategory]!
                            .map((sub) => DropdownMenuItem(
                          value: sub,
                          child: Text(sub),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSubCategory = value;
                          });
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Write about the issue in detail...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Attach Image (if any)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: pickImage,
                      icon: Icon(Icons.upload_file),
                      label: Text("Upload"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (_selectedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _selectedImage!,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Submit logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Complaint Submitted")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Submit Complaint",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
