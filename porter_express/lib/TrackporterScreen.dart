import 'package:flutter/material.dart';

class TrackPorterScreen extends StatelessWidget {
  const TrackPorterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Your Porter"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Fake Map Box
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(
                child: Text(
                  "Map Interface Placeholder",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            ),
          ),
          // Status Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Porter Status: On the way",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("ETA: 5 minutes"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
