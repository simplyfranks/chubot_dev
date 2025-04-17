import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';

void main() {
  runApp(const LiontentApp());
}

// Main entry point of the app
class LiontentApp extends StatelessWidget {
  const LiontentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: MainPage(), // Sets the home screen to the MainPage
    );
  }
}

// MainPage widget that contains the BottomNavigationBar
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Tracks the selected tab index

  // List of pages for each tab in the BottomNavigationBar
  final List<Widget> _pages = [
    const SearchesPage(), // Searches tab
    const PlaceholderPage(title: 'Saved'), // Saved tab placeholder
    const PlaceholderPage(title: 'Bookings'), // Bookings tab placeholder
    const PlaceholderPage(title: 'My Account'), // My Account tab placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Displays the currently selected page
      body: _pages[_currentIndex],

      // BottomNavigationBar for navigating between tabs
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
        unselectedItemColor: Colors.grey, // Color for unselected tabs
        items: const [
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

// Page for the "Searches" tab
class SearchesPage extends StatefulWidget {
  const SearchesPage({super.key});

  @override
  _SearchesPageState createState() => _SearchesPageState();
}

class _SearchesPageState extends State<SearchesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controller for managing tabs

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 3 tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the TabController to free up resources
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom AppBar with Tabs
        Column(
          children: [
            // Custom AppBar
            Container(
              height: 70, // Height of the app bar
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ), // Padding for spacing
              decoration: BoxDecoration(
                color:
                    colors4Liontent.primary, // Background color of the app bar
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 1, // Spread radius of the shadow
                    blurRadius: 5, // Blur radius of the shadow
                    offset: const Offset(0, 3), // Position of the shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween, // Space between title and icons
                children: [
                  // Centered Title
                  Expanded(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 25, // Font size for the title
                            fontWeight: FontWeight.bold, // Bold font weight
                            color: Colors.white, // Text color
                          ),
                          children: [
                            const TextSpan(
                              text: 'Lion', // First part of the title
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: 'tent', // Second part of the title
                              style: TextStyle(
                                foreground:
                                    Paint()
                                      ..style =
                                          PaintingStyle
                                              .stroke // Stroke style
                                      ..strokeWidth =
                                          0.6 // Stroke width
                                      ..color = Colors.white, // Stroke color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Icons on the right
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chat_bubble_outline, // Chat icon
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Action for chat icon
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications, // Notifications icon
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Action for notifications icon
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              color: colors4Liontent.primary, // Background color for the tabs
              child: TabBar(
                controller: _tabController, // Controller for the tabs
                indicatorColor:
                    Colors.white70, // Color of the selected tab indicator
                indicatorWeight: 4.0, // Thickness of the indicator
                labelColor: Colors.white, // Color of the selected tab text
                unselectedLabelColor:
                    Colors.white60, // Color of unselected tab text
                tabs: const [
                  Tab(icon: Icon(Icons.hotel), text: 'Lodges'), // Lodges tab
                  Tab(
                    icon: Icon(Icons.home),
                    text: 'Properties',
                  ), // Properties tab
                  Tab(icon: Icon(Icons.local_taxi), text: 'Taxi'), // Taxi tab
                ],
              ),
            ),
          ],
        ),

        // TabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController, // Controller for the TabBarView
            children: [
              Center(child: Text('Lodges Content')), // Content for Lodges tab
              Center(
                child: Text('Properties Content'),
              ), // Content for Properties tab
              Center(child: Text('Taxi Content')), // Content for Taxi tab
            ],
          ),
        ),
      ],
    );
  }
}

// Placeholder page for other tabs
class PlaceholderPage extends StatelessWidget {
  final String title; // Title of the placeholder page

  const PlaceholderPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title Page', // Displays the title of the page
        style: const TextStyle(fontSize: 24), // Font size for the text
      ),
    );
  }
}
