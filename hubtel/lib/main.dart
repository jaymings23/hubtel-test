// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentOverviewScreen(),
    );
  }
}

class PaymentOverviewScreen extends StatefulWidget {
  const PaymentOverviewScreen({super.key});

  @override
  _PaymentOverviewScreenState createState() => _PaymentOverviewScreenState();
}

class _PaymentOverviewScreenState extends State<PaymentOverviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool _isDataLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    // Simulate a loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isDataLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildTabBar(),
        body: _isDataLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildContent(),
        bottomNavigationBar: _buildBottomNavigation(),
        floatingActionButton: _buildFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: TabBar(
        controller: _controller,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        tabs: const [
          Tab(text: 'Payments'),
          Tab(text: 'Account Summary'),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        const _SearchBar(),
        const _DateLabel(date: 'June 14, 2023'),
        Expanded(child: _buildPaymentList()),
      ],
    );
  }

  Widget _buildPaymentList() {
    return ListView(
      children: const [
        _PaymentCard(
          time: '10:30AM',
          customerName: 'Jonathan Adams Walker Smith',
          phone: '055 123 9876',
          transactionAmount: 'GHS 350',
          transactionStatus: 'Completed',
          isSuccess: true,
          note: 'Paid via bank transfer',
          imageAsset: 'assets/images/bank_logo.jpeg',
        ),
        _PaymentCard(
          time: '2:15PM',
          customerName: 'XYZ Bank',
          phone: '024 987 6543',
          transactionAmount: 'GHS 700',
          transactionStatus: 'Failed',
          isSuccess: false,
          note: 'Insufficient funds',
          imageAsset: 'assets/images/xyz_logo.png',
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard, color: Colors.grey),
          activeIcon: CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFFE0F7DB),
            child: Icon(Icons.dashboard, color: Colors.black),
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mobile_friendly, color: Colors.grey),
          activeIcon: Icon(Icons.mobile_friendly, color: Colors.black),
          label: 'Transfers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long, color: Colors.grey),
          activeIcon: Icon(Icons.receipt_long, color: Colors.black),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event, color: Colors.grey),
          activeIcon: Icon(Icons.event, color: Colors.black),
          label: 'Schedules',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }

  Widget _buildFloatingButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: FloatingActionButton.extended(
        onPressed: () {},
        icon: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(Icons.add, color: Color(0xFF01A3C7)),
        ),
        label: const Text(
          'NEW TRANSFER',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF01A3C7),
      ),
    );
  }
}

// Search bar widget
class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.filter_list, color: Colors.black),
        ],
      ),
    );
  }
}

// Date label widget
class _DateLabel extends StatelessWidget {
  final String date;
  const _DateLabel({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[300],
          ),
          child: Text(
            date,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

// Payment card widget
class _PaymentCard extends StatelessWidget {
  final String time;
  final String customerName;
  final String phone;
  final String transactionAmount;
  final String transactionStatus;
  final bool isSuccess;
  final String note;
  final String imageAsset;

  const _PaymentCard({
    Key? key,
    required this.time,
    required this.customerName,
    required this.phone,
    required this.transactionAmount,
    required this.transactionStatus,
    required this.isSuccess,
    required this.note,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    avatar: Icon(
                      isSuccess ? Icons.check_circle : Icons.cancel,
                      color: isSuccess
                          ? const Color(0xFF83E070)
                          : const Color(0xFFD1302C),
                    ),
                    label: Text(
                      transactionStatus,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: isSuccess
                            ? const Color(0xFF83E070)
                            : const Color(0xFFD1302C),
                      ),
                    ),
                    backgroundColor: isSuccess
                        ? const Color(0xFFE0F7DB)
                        : const Color(0xFFFDB4B0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(phone, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Text(transactionAmount,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.comment, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(note, style: const TextStyle(color: Colors.grey)),
                  const Spacer(),
                  const Icon(Icons.star_border, color: Colors.amber),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
