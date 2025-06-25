import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LodgeDetailsPage extends StatelessWidget {
  final String lodgeName;
  final String leadingImgUrl;
  // final String imageUrl;
  // final double price;
  // final double rating;
  // final List<String> amenities;
  // final String description;
  // final String lodgeAddress;
  // final String proximity;
  // final List<String> detailPics;
  const LodgeDetailsPage({
    super.key,
    required this.lodgeName,
    required this.leadingImgUrl,
    // required this.imageUrl,
    // required this.amenities,
    // required this.description,
    // required this.detailPics,
    // required this.lodgeAddress,
    // required this.price,
    // required this.proximity,
    // required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lodgeName),
                    Row(
                      children: [
                        Text('Room type: '),
                        Text(
                          'Single Room',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Rating: '),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                        Icon(Icons.star_rate),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,

                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,

                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(color: Colors.blue),
                                ),
                              ),
                              SizedBox(width: 2),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(color: Colors.blue),
                                ),
                              ),
                              SizedBox(width: 2),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Property Highlight'),
                            Row(
                              children: [
                                Icon(MdiIcons.gate),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Proximity to School Gate',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Less than 5 mins walk'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(MdiIcons.shower),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shower and inhouse water availability',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(MdiIcons.balcony),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Private Personal balcony',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tenants Reviews'),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colors4Liontent.primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(
                                  '10.0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontSize: 20,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Excellent',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Out of 200 reveiews',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cleanliness'),
                        Container(height: 10, color: Colors.blue),
                        Text('Cleanliness'),
                        Container(height: 10, color: Colors.blue),
                        Text('Cleanliness'),
                        Container(height: 10, color: Colors.blue),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_upward, size: 12),
                            Text(
                              'high score rating',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Show more', style: TextStyle(fontSize: 10)),
                              Icon(MdiIcons.arrowUpDown, size: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),

                    Text(
                      'Tenants who stay/stayed here commented',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Divider(),
                    SizedBox(height: 10),
                    Divider(),

                    Text(
                      'Lodge Address',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 10),
                        Text(
                          '123 Liontent Street, Liontent City',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price for a year'),
                              Text(
                                '₦100,000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Includes taxes and agent fees'),
                            ],
                          ),
                          Icon(Icons.chevron_right, size: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),

                    Text(
                      'Lodge Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: Text('Show more', style: TextStyle(fontSize: 10)),
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lodge Policies',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('Lodge gate opening time: 6:00 AM'),
                        Text('Lodge gate closing time: 10:00 PM'),
                        Text('Maximum number of residents: 3'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                right: 3,
                bottom: 5,
                left: 3,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors4Liontent.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: Center(
                  child: Text(
                    'Rent a Room',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
