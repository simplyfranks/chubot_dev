import 'package:flutter/material.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/features/landing/searchtabs/lodges.dart';
import 'package:liontent/features/landing/searchtabs/properties.dart';
import 'package:liontent/features/landing/searchtabs/taxi.dart';

class searchTab extends StatefulWidget {
  const searchTab({super.key});

  @override
  State<searchTab> createState() => _searchTabState();
}

class _searchTabState extends State<searchTab>
    with SingleTickerProviderStateMixin {
  late TabController _searchTabController; // Controller for the TabBar

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 3 tabs
    _searchTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the TabController to free up resources
    _searchTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          searchAppBar(searchcontroller4bar: _searchTabController),
          Expanded(
            child: TabBarView(
              controller: _searchTabController, // Controller for the TabBarView
              children: [
                lodgesTabContent(), // Content for Lodges tab
                propertiesTabContent(), // Content for Properties tab
                taxiTabContent(), // Content for Taxi tab
              ],
            ),
          ),
        ],
      ),
    );
  }
}
