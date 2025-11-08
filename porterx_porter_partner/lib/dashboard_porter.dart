import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/orders_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/saving_screen.dart';

class DashboardPorter extends StatefulWidget {
  @override
  _DashboardPorterState createState() => _DashboardPorterState();
}

class _DashboardPorterState extends State<DashboardPorter> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardHome(),
    OrdersScreen(),
    WalletScreen(),
    ChatScreen(),
    ProfileScreen(),
    SavingScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        unselectedLabelStyle: GoogleFonts.poppins(),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.savings_outlined), label: "Savings"),
        ],
      ),
    );
  }
}

class DashboardHome extends StatefulWidget {
  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOnlineCard(),
            const SizedBox(height: 24),
            _buildSectionTitle("Today's Stats"),
            const SizedBox(height: 12),
            _buildStatGrid(),
            const SizedBox(height: 24),
            _buildSectionTitle("Quick Actions"),
            const SizedBox(height: 12),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildSectionTitle("Recent Activity"),
            const SizedBox(height: 12),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back,",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
          ),
          Text(
            "Rajesh Kumar",
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar_placeholder.png"),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildOnlineCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isOnline ? "You are Online" : "You are Offline",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: isOnline ? Colors.green[700] : Colors.red[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isOnline ? "Ready to accept bookings" : "Toggle to go online",
                style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          Switch(
            value: isOnline,
            onChanged: (val) => setState(() => isOnline = val),
            activeTrackColor: Colors.green[100],
            activeColor: Colors.green[700],
          ),
        ],
      ),
    );
  }

  Widget _buildStatGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _statCard("₹1,240", "Today's Earnings", Icons.account_balance_wallet, Colors.blue),
        _statCard("8", "Trips Completed", Icons.check_circle, Colors.green),
        _statCard("6.5 Hrs", "Hours Online", Icons.timer, Colors.orange),
        _statCard("4.8", "Rating", Icons.star, Colors.purple),
      ],
    );
  }

  Widget _statCard(String stat, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const Spacer(),
          Text(stat, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20)),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[800])),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      children: [
        _quickActionTile(
          "Daily Bonus Progress",
          "4 of 5 trips completed",
          "80%",
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _quickActionTile(
          "Referral Commission",
          "2 active referrals",
          "₹500",
          Colors.green,
        ),
      ],
    );
  }

  Widget _quickActionTile(String title, String subtitle, String trailing, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15)),
              const SizedBox(height: 2),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600])),
            ]),
          ),
          Text(trailing, style: GoogleFonts.poppins(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      children: [
        _recentActivityTile("Trip to Terminal 2", "2 hours ago", "+₹180"),
        _recentActivityTile("Trip to City Center", "4 hours ago", "+₹220"),
        _recentActivityTile("Trip to Station Gate", "Yesterday", "+₹150"),
      ],
    );
  }

  Widget _recentActivityTile(String title, String subtitle, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Row(
        children: [
          const Icon(Icons.directions_car, color: Colors.blueAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
            ]),
          ),
          Text(amount, style: GoogleFonts.poppins(color: Colors.green[700], fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}
