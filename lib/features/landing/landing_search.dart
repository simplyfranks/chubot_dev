import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/features/landing/bookedPage.dart';
import 'package:liontent/features/landing/profileTab/profilePage.dart';
import 'package:liontent/features/landing/savedPage.dart';
import 'package:liontent/features/landing/searchtabs/searchTab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:async';

class landingPageSearch extends StatefulWidget {
  const landingPageSearch({super.key});

  @override
  State<landingPageSearch> createState() => _landingPageSearchState();
}

class _landingPageSearchState extends State<landingPageSearch> {
  int _currentIndex = 0; // Tracks the selected tab index
  File? _profileImage;
  String _userName = "U";

  @override
  void initState() {
    super.initState();
    _loadProfileImage();

    // Set up a periodic refresh of the profile image every minute
    // This ensures the navigation bar and profile page stay in sync
    Timer.periodic(Duration(minutes: 1), (_) {
      if (mounted) {
        _loadProfileImage();
      }
    });
  }

  // Load profile image
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();

    // Get profile image path
    final imagePath = prefs.getString('profileImagePath');

    setState(() {
      // Get user name for fallback
      _userName = prefs.getString('firstName') ?? "U";

      // Set profile image if available
      if (imagePath != null) {
        final imageFile = File(imagePath);
        if (imageFile.existsSync()) {
          _profileImage = imageFile;
        }
      }
    });
  }

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
          // If user is navigating to profile tab (index 3), refresh profile data
          if (index == 3) {
            _loadProfileImage();
          }

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
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  _profileImage != null ? FileImage(_profileImage!) : null,
              child:
                  _profileImage == null
                      ? Text(
                        _userName.isNotEmpty ? _userName[0].toUpperCase() : "U",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colors4Liontent.primary,
                        ),
                      )
                      : null,
            ),
            label: 'My Account',
          ),
        ],
      ),
    );
  }
}
