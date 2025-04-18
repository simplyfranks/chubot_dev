import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:feather_icons/feather_icons.dart';

class propertiesTabContent extends StatefulWidget {
  const propertiesTabContent({super.key});

  @override
  State<propertiesTabContent> createState() => _propertiesTabContentState();
}

class _propertiesTabContentState extends State<propertiesTabContent> {
  String? selectedArea;

  String? selectedRoomType;

  RangeValues _currentRangeValues = const RangeValues(3000, 1000000);
  String getCurrentMonth = DateFormat.MMMM().format(
    DateTime.now(),
  ); // Get the current month

  final List<String> properties = [
    'Mattress',
    'Storages',
    'Tables',
    'Chairs',
    'Electronics',
    'Home Décor',
    'Cleaning Essentials',
    'Other',
  ];

  final List<String> imageProperties = [
    'image 1',
    'image 1',
    'image 1',
    'image 1',
    'image 1',
    'image 1',
    'image 1',
    'image 1',
  ];

  final List<String> conditionlvl = ['5', '4', '3', '2', '1'];

  final Map<String, String> conditionDescriptions = {
    '5': 'Perfect condition, barely used',
    '4': 'Great condition, minimal wear',
    '3': 'Good condition, normal wear',
    '2': 'Noticeable wear, still functional',
    '1': 'Significant wear or minor issues',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Main Search Card
            Card(
              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(width: 5, color: Color(0xffffaf36)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Search Fields
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          // Location Field
                          _buildSearchField(
                            bottomlength: 2.5,
                            toplength: 0,
                            icon: Icons.shopping_bag_outlined,
                            title: 'What do you want to get?',
                            value: selectedArea,
                            items: properties,
                            onChanged:
                                (value) => setState(() => selectedArea = value),
                          ),

                          // Room Type Field
                          _buildSearchField(
                            toplength: 2.5,
                            bottomlength: 2.5,
                            icon: FontAwesomeIcons.starHalfAlt,
                            title: 'Condition of the item',
                            value: selectedRoomType,
                            items: conditionlvl,
                            onChanged:
                                (value) =>
                                    setState(() => selectedRoomType = value),
                          ),

                          // Price Range Field
                          _buildPriceRangeField(),

                          // Search Button
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 2.5,
                                  color: Color(0xffffaf36),
                                ),
                              ),
                            ),
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors4Liontent.primary,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Search',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 70),

            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top deals of the week',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Save most on purchases in $getCurrentMonth',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: LodgeCard(
                      imageUrl: 'https://example.com/lodge${index + 1}.jpg',
                      name: 'Lodge ${index + 1}',
                      price: 50000 + (index * 10000),
                      rating: 4.0 + (index * 0.2),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Not sure of what to get?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Browse through the list of properties available for your comfort',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: properties.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: AreaCard(
                      propertyType: properties[index],
                      imageUrl: 'https://example.com/area${index + 1}.jpg',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required IconData icon,
    required String title,
    required String? value,
    required List<String> items,
    required double toplength,
    required double bottomlength,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: toplength, color: Color(0xffffaf36)),
          bottom: BorderSide(width: bottomlength, color: Color(0xffffaf36)),
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        height: 50,
        child: InkWell(
          onTap: () {
            if (title == 'Condition of the item') {
              showDialog(
                context: context,
                builder:
                    (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...items
                                  .map(
                                    (item) => ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(5, (index) {
                                          final starCount = int.parse(item);
                                          return Icon(
                                            Icons.star,
                                            size: 20,
                                            color:
                                                index < starCount
                                                    ? Colors.amber
                                                    : Colors.grey[300],
                                          );
                                        }),
                                      ),
                                      onTap: () {
                                        onChanged(item);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
              );
            } else {
              showDialog(
                context: context,
                builder:
                    (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ...items
                                  .map(
                                    (item) => ListTile(
                                      title: Text(item),
                                      onTap: () {
                                        onChanged(item);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon, color: colors4Liontent.primary),
                const SizedBox(width: 12),
                Expanded(
                  child:
                      value != null
                          ? title == 'Condition of the item'
                              ? SizedBox(
                                height: 20,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ...List.generate(5, (index) {
                                        final starCount = int.parse(value);
                                        return Icon(
                                          Icons.star,
                                          size: 20,
                                          color:
                                              index < starCount
                                                  ? Colors.amber
                                                  : Colors.grey[300],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              )
                              : Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              )
                          : Text(
                            title,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                ),
                if (title == 'Condition of the item')
                  IconButton(
                    icon: Icon(Icons.info_outline, size: 20),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Condition Rating Guide',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    ...items
                                        .map(
                                          (item) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            child: Row(
                                              children: [
                                                ...List.generate(5, (index) {
                                                  final starCount = int.parse(
                                                    item,
                                                  );
                                                  return Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color:
                                                        index < starCount
                                                            ? Colors.amber
                                                            : Colors.grey[300],
                                                  );
                                                }),
                                                SizedBox(width: 8),
                                                Text(
                                                  conditionDescriptions[item] ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                            ),
                      );
                    },
                  ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRangeField() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2.5, color: Color(0xffffaf36)),
          top: BorderSide(width: 2.5, color: Color(0xffffaf36)),
        ),

        // border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder:
                (context) => PriceRangeDialog(
                  initialValues: _currentRangeValues,
                  onApply: (values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                    Navigator.pop(context);
                  },
                ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.attach_money, color: colors4Liontent.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '₦${_currentRangeValues.start.round()} - ₦${_currentRangeValues.end.round()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceRangeDialog extends StatefulWidget {
  final RangeValues initialValues;
  final Function(RangeValues) onApply;

  const PriceRangeDialog({
    super.key,
    required this.initialValues,
    required this.onApply,
  });

  @override
  State<PriceRangeDialog> createState() => _PriceRangeDialogState();
}

class _PriceRangeDialogState extends State<PriceRangeDialog> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _values = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Price Range',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                RangeSlider(
                  values: _values,
                  min: 3000,
                  max: 1000000,
                  divisions: 96,
                  activeColor: colors4Liontent.primary,
                  inactiveColor: Colors.grey.withOpacity(0.2),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _values = values;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₦${_values.start.round()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₦${_values.end.round()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => widget.onApply(_values),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors4Liontent.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LodgeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int price;
  final double rating;

  const LodgeCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            // blurRadius: 8,
            // offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lodge Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Price
                Text(
                  '₦${NumberFormat('#,###').format(price)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: colors4Liontent.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 16,
                        color:
                            index < rating.floor()
                                ? Colors.amber
                                : Colors.grey[300],
                      );
                    }),
                    const SizedBox(width: 5),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AreaCard extends StatelessWidget {
  final String propertyType;
  final String imageUrl;

  const AreaCard({
    super.key,
    required this.propertyType,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            // blurRadius: 8,
            // offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Full screen image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),
          ),
          // Area name at bottom right
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                propertyType,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
