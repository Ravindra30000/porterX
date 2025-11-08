import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Support & Help',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _buildEmergencyHelpline(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildSectionTitle("Quick Help Topics"),
          ),
          const SizedBox(height: 12),
          _buildQuickHelpTopics(),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _ChatBubble(
                  text: "Hello! How can I help you today?",
                  isMe: false,
                  time: "10:30 AM",
                ),
                _ChatBubble(
                  text: "I have a question about my recent payment.",
                  isMe: true,
                  time: "10:32 AM",
                ),
                _ChatBubble(
                  text: "Sure, I can help. Can you please provide your order ID?",
                  isMe: false,
                  time: "10:33 AM",
                ),
              ],
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildEmergencyHelpline() {
    return Card(
      elevation: 0,
      color: Colors.red[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(Icons.error_outline, color: Colors.red[700]),
        title: Text("Emergency Helpline", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.red[700])),
        trailing: Icon(Icons.phone, color: Colors.red[700]),
        onTap: () {},
      ),
    );
  }

  Widget _buildQuickHelpTopics() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          _QuickHelpButton(icon: Icons.payments, label: "Payments"),
          _QuickHelpButton(icon: Icons.book_online, label: "Bookings"),
          _QuickHelpButton(icon: Icons.account_circle, label: "Account"),
          _QuickHelpButton(icon: Icons.more_horiz, label: "Other"),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black54),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickHelpButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickHelpButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey[300]!),
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text, time;
  final bool isMe;
  const _ChatBubble({
    required this.text,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isMe)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: Offset(0, 2),
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.poppins(
                color: isMe ? Colors.white70 : Colors.black45,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
