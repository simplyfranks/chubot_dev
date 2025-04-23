import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/features/landing/bookedPage.dart';
import 'package:liontent/features/landing/profileTab/profilePage.dart';
import 'package:liontent/features/landing/savedPage.dart';
import 'package:liontent/features/landing/searchtabs/searchTab.dart';

class landingPageSearch extends StatefulWidget {
  const landingPageSearch({super.key});

  @override
  State<landingPageSearch> createState() => _landingPageSearchState();
}

class _landingPageSearchState extends State<landingPageSearch> {
  int _currentIndex = 0; // Tracks the selected tab index

  // List of pages for each tab in the BottomNavigationBar
  final List<Widget> _pages = [
    searchTab(),
    usersSave(), // Saved tab placeholder
    usersBooked(), // Bookings tab placeholder
    usersProfile(), // My Account tab placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _pages[_currentIndex], // Displays the selected page based on the index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlights the selected tab
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Updates the selected tab index
          });
        },
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        selectedItemColor:
            colors4Liontent.primary, // Highlight color for selected tab
        unselectedItemColor: const Color.fromRGBO(
          158,
          158,
          158,
          1,
        ), // Color for unselected tabs
        items: [
          // BottomNavigationBarItem for the "Searches" tab
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Magnifier icon
            label: 'Searches',
          ),
          // BottomNavigationBarItem for the "Saved" tab
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), // Heart icon
            label: 'Saved',
          ),
          // BottomNavigationBarItem for the "Bookings" tab
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online), // Bookings icon
            label: 'Bookings',
          ),
          // BottomNavigationBarItem for the "My Account" tab
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12, // Circular profile picture holder
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
            label: 'My Account',
          ),
        ],
      ),
    );
  }
}
