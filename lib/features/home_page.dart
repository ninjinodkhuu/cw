import 'package:cw/features/CalenderScreen.dart';
//import 'Data/Task.dart';
import 'package:cw/features/Expense_tracking.dart';
import 'package:cw/features/Gamification.dart';
import 'package:cw/features/home_screen.dart';
import 'package:cw/features/shopping_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
//import 'SquareCard.dart';
//import 'SquareCard2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ProfileScreen()), // Navigate to ProfileScreen
              );
            },
          ),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: ' '),
            BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.apple), label: ''),
          ],
          currentIndex: _selectedIndex, // Highlight the selected item
          onTap: _onItemTapped, // Call _onItemTapped when an item is tapped
          backgroundColor: Colors.blue[50],
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomeScreen(), // Your current home page
          const CalendarScreen(), // Placeholder for Calendar screen
          const ExpenseTracking(), // Placeholder for Notifications screen
          const Gamification(),
          const ShoppingList(),
          // Placeholder for Search screen
        ],
      ),
    );
  }
}
