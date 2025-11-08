import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Wallet',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildSectionTitle("Quick Withdraw"),
            const SizedBox(height: 12),
            _buildWithdrawCard(),
            const SizedBox(height: 24),
            _buildSectionTitle("Earnings Overview"),
            const SizedBox(height: 12),
            _buildEarningsChart(),
            const SizedBox(height: 24),
            _buildSectionTitle("Bonus & Referrals"),
            const SizedBox(height: 12),
            _buildBonusCard(),
            const SizedBox(height: 12),
            _buildReferralCard(),
            const SizedBox(height: 24),
            _buildSectionTitle("Withdrawal History"),
            const SizedBox(height: 12),
            _buildTransactionHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
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

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '₹12,450',
            style: GoogleFonts.poppins(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceStat("Today", "₹1,240"),
              _buildBalanceStat("This Week", "₹8,900"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceStat(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(amount,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildWithdrawCard() {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Withdraw Funds', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter amount",
                  hintStyle: GoogleFonts.poppins(),
                  filled: true,
                  fillColor: Color(0xFFF9F9F9),
                  prefixIcon: Icon(Icons.currency_rupee, size: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.account_balance_wallet_outlined, size: 18),
                      label: const Text('UPI'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.account_balance, size: 18),
                      label: const Text('Bank'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ]));
  }

  Widget _buildEarningsChart() {
    return DefaultTabController(
      length: 3,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              indicator: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              tabs: [
                Tab(child: Text('Daily', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                Tab(child: Text('Weekly', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                Tab(child: Text('Monthly', style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
              ],
            ),
            SizedBox(
              height: 200,
              child: TabBarView(
                children: [
                  _BarChart(data: [900, 1200, 950, 1400, 1600, 1800, 1300], labels: ["M", "T", "W", "T", "F", "S", "S"]),
                  _BarChart(data: [5500, 5700, 6000, 5200], labels: ["W1", "W2", "W3", "W4"]),
                  _BarChart(data: [15000, 12500, 18000, 16000], labels: ["Jul", "Aug", "Sep", "Oct"]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBonusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daily Bonus Progress", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.blue[800])),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.8,
            color: Colors.blue[800],
            backgroundColor: Colors.blue[100],
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          Text("Complete 1 more trip to earn a ₹200 bonus!", style: GoogleFonts.poppins(color: Colors.blue[700])),
        ],
      )
    );
  }

  Widget _buildReferralCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Referral Commission", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.green[800])),
              const SizedBox(height: 4),
              Text("2 active referrals", style: GoogleFonts.poppins(color: Colors.green[700])),
            ],
          ),
          Text("₹500", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[800]))
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      children: const [
        _WithdrawalTile(amount: '₹5,000', date: '20 Oct 2024', status: 'Completed', method: 'UPI'),
        _WithdrawalTile(amount: '₹3,500', date: '15 Oct 2024', status: 'Completed', method: 'Bank Transfer'),
        _WithdrawalTile(amount: '₹4,200', date: '10 Oct 2024', status: 'Completed', method: 'UPI'),
      ],
    );
  }
}

class _WithdrawalTile extends StatelessWidget {
  final String amount, date, status, method;
  const _WithdrawalTile({
    required this.amount,
    required this.date,
    required this.status,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.withOpacity(0.1),
            child: const Icon(Icons.arrow_upward, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(amount, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 2),
                Text(date, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
          Text(method, style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 13)),
        ],
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<int> data;
  final List<String> labels;
  const _BarChart({required this.data, required this.labels});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(
          data.length,
              (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: data[index].toDouble(),
                color: Colors.black,
                width: 16,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, _) {
                if (value.toInt() >= labels.length) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(labels[value.toInt()], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
