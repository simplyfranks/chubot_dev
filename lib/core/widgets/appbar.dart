import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:liontent/core/constants/colors.dart';

PreferredSize customAppBar1({required VoidCallback closeOpera}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: Container(
      decoration: BoxDecoration(
        color: colors4Liontent.primary,
        /*border: Border(bottom: BorderSide(color: Colors.black, width: 0.5), ),*/ boxShadow:
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: closeOpera,
            icon: const Icon(Icons.close, color: Colors.white, size: 25),
          ),
          Expanded(child: SizedBox(), flex: 2),
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(text: 'Lion', style: TextStyle(color: Colors.white)),

                  TextSpan(
                    text: 'tent',
                    style: TextStyle(
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 0.6
                            ..color = Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: SizedBox(), flex: 3),
        ],
      ),
    ),
  );
}

class searchAppBar extends StatefulWidget {
  final TabController searchcontroller4bar;
  const searchAppBar({super.key, required this.searchcontroller4bar});

  @override
  State<searchAppBar> createState() => _searchAppBarState();
}

class _searchAppBarState extends State<searchAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 0, top: 16),
        decoration: BoxDecoration(
          color: colors4Liontent.primary, // Background color of the app bar
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 1, // Spread radius of the shadow
              blurRadius: 5, // Blur radius of the shadow
              offset: const Offset(0, 3), // Position of the shadow
            ),
          ],
        ),
        child: Column(
          children: [
            _appBarTitle(),
            TabBar(
              controller:
                  widget.searchcontroller4bar, // Controller for the TabBar
              indicatorColor:
                  Colors.white70, // Color of the selected tab indicator
              indicatorWeight: 4.0, // Thickness of the indicator
              labelColor: Colors.white, // Color of the selected tab text
              unselectedLabelColor:
                  Colors.white60, // Color of unselected tab text
              tabs: const [
                Tab(
                  icon: Icon(FeatherIcons.home),
                  text: 'Lodges',
                ), // Lodges tab
                Tab(
                  icon: Icon(FontAwesomeIcons.couch),
                  text: 'Properties',
                ), // Properties tab
                Tab(
                  icon: Icon(FontAwesomeIcons.carSide),
                  text: 'SwiftRide',
                ), // Taxi tab
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appBarTitle() {
  return Row(
    spacing: 0,
    mainAxisAlignment: MainAxisAlignment.end, // Space between title and icons
    children: [
      // Centered Title
      Expanded(
        child: Row(
          children: [
            Expanded(flex: 9, child: SizedBox()),
            Expanded(
              flex: 12,
              child: Align(
                alignment: Alignment.centerLeft,
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
          ],
        ),
      ),
      // Icons on the right
      Align(
        alignment: Alignment.centerRight,
        child: Row(
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
      ),
    ],
  );
}

PreferredSize customAppBar2({required String bartitle}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: Container(
      padding: EdgeInsets.only(left: 20, right: 15),
      decoration: BoxDecoration(
        color: colors4Liontent.primary,
        /*border: Border(bottom: BorderSide(color: Colors.black, width: 0.5), ),*/ boxShadow:
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bartitle,
            style: TextStyle(
              color: colors4Liontent.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 70),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add, size: 30, color: colors4Liontent.secondary),
          ),
        ],
      ),
    ),
  );
}
