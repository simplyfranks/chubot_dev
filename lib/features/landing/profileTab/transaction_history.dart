import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedTransactionType;
  String? _searchQuery;
  bool _isFilterExpanded = false;

  // Mock data for transactions
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TRX-001',
      'date': DateTime.now().subtract(Duration(days: 2)),
      'amount': 150000,
      'status': 'successful',
      'description': 'Lodges - New Rent Payment',
      'category': 'lodges',
      'subcategory': 'New Rent Payment',
      'recipient': 'Sunshine Apartments',
    },
    {
      'id': 'TRX-002',
      'date': DateTime.now().subtract(Duration(days: 5)),
      'amount': 25000,
      'status': 'failed',
      'description': 'Properties - Electronics',
      'category': 'properties',
      'subcategory': 'Electronics',
      'recipient': 'Tech Store',
    },
    {
      'id': 'TRX-003',
      'date': DateTime.now().subtract(Duration(days: 10)),
      'amount': 120000,
      'status': 'successful',
      'description': 'Lodges - Renewal',
      'category': 'lodges',
      'subcategory': 'Renewal',
      'recipient': 'Greenfield Rentals',
    },
    {
      'id': 'TRX-004',
      'date': DateTime.now().subtract(Duration(days: 15)),
      'amount': 15000,
      'status': 'successful',
      'description': 'Properties - Home Decor',
      'category': 'properties',
      'subcategory': 'Home Decor',
      'recipient': 'Home Essentials',
    },
    {
      'id': 'TRX-005',
      'date': DateTime.now().subtract(Duration(days: 20)),
      'amount': 8500,
      'status': 'successful',
      'description': 'Properties - Mattress',
      'category': 'properties',
      'subcategory': 'Mattress',
      'recipient': 'Sleep Well Co.',
    },
    {
      'id': 'TRX-006',
      'date': DateTime.now().subtract(Duration(days: 22)),
      'amount': 3000,
      'status': 'failed',
      'description': 'Properties - Chairs',
      'category': 'properties',
      'subcategory': 'Chairs',
      'recipient': 'Furniture Plus',
    },
  ];

  // Transaction types for dropdown
  final List<Map<String, String>> _transactionTypes = [
    {'label': 'All Types', 'value': 'all'},
    {'label': 'Lodges - New Rent Payment', 'value': 'lodges-new'},
    {'label': 'Lodges - Renewal', 'value': 'lodges-renewal'},
    {'label': 'Properties - Mattress', 'value': 'properties-mattress'},
    {'label': 'Properties - Storage', 'value': 'properties-storage'},
    {'label': 'Properties - Tables', 'value': 'properties-tables'},
    {'label': 'Properties - Chairs', 'value': 'properties-chairs'},
    {'label': 'Properties - Electronics', 'value': 'properties-electronics'},
    {'label': 'Properties - Home Decor', 'value': 'properties-decor'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredTransactions {
    return _transactions.where((transaction) {
      // Filter by tab (status)
      if (_tabController.index == 1 && transaction['status'] != 'successful') {
        return false;
      }
      if (_tabController.index == 2 && transaction['status'] != 'failed') {
        return false;
      }

      // Filter by date range
      if (_startDate != null &&
          transaction['date'].isBefore(
            _startDate!.subtract(Duration(hours: 24)),
          )) {
        return false;
      }
      if (_endDate != null &&
          transaction['date'].isAfter(_endDate!.add(Duration(hours: 24)))) {
        return false;
      }

      // Filter by transaction type
      if (_selectedTransactionType != null &&
          _selectedTransactionType != 'all') {
        // Parse the transaction type (format: "category-subcategory")
        final parts = _selectedTransactionType!.split('-');
        if (parts.length == 2) {
          final category = parts[0];
          final subcategory = parts[1];

          if (category == 'lodges') {
            if (transaction['category'] != 'lodges') return false;

            if (subcategory == 'new' &&
                transaction['subcategory'] != 'New Rent Payment') {
              return false;
            } else if (subcategory == 'renewal' &&
                transaction['subcategory'] != 'Renewal') {
              return false;
            }
          } else if (category == 'properties') {
            if (transaction['category'] != 'properties') return false;

            // Convert subcategory to title case for comparison
            final formattedSubcategory =
                subcategory.substring(0, 1).toUpperCase() +
                subcategory.substring(1);

            // Special case for Home Decor
            if (subcategory == 'decor' &&
                transaction['subcategory'] != 'Home Decor') {
              return false;
            } else if (subcategory != 'decor' &&
                transaction['subcategory'] != formattedSubcategory) {
              return false;
            }
          }
        }
      }

      // Filter by search query
      if (_searchQuery != null && _searchQuery!.isNotEmpty) {
        final query = _searchQuery!.toLowerCase();
        return transaction['id'].toLowerCase().contains(query) ||
            transaction['description'].toLowerCase().contains(query) ||
            transaction['recipient'].toLowerCase().contains(query);
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text(
          'Transaction History',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Successful'),
            Tab(text: 'Failed'),
          ],
          onTap: (_) {
            setState(() {}); // Refresh to apply tab filter
          },
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterSection(),
          Expanded(
            child:
                _filteredTransactions.isEmpty
                    ? _buildEmptyState()
                    : _buildTransactionList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search transactions...',
          prefixIcon: Icon(Icons.search, color: colors4Liontent.primary),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim().isEmpty ? null : value.trim();
          });
        },
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isFilterExpanded = !_isFilterExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.filter_list, color: colors4Liontent.primary),
                  SizedBox(width: 8),
                  Text(
                    'Filter Transactions',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Spacer(),
                  Icon(
                    _isFilterExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: colors4Liontent.primary,
                  ),
                ],
              ),
            ),
          ),
          if (_isFilterExpanded) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Range',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _startDate ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: colors4Liontent.primary,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              setState(() {
                                _startDate = pickedDate;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  _startDate == null
                                      ? 'Start Date'
                                      : DateFormat(
                                        'MMM d, y',
                                      ).format(_startDate!),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _endDate ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: colors4Liontent.primary,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              setState(() {
                                _endDate = pickedDate;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  _endDate == null
                                      ? 'End Date'
                                      : DateFormat(
                                        'MMM d, y',
                                      ).format(_endDate!),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Transaction Type',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedTransactionType ?? 'all',
                        items:
                            _transactionTypes.map((type) {
                              return DropdownMenuItem<String>(
                                value: type['value'],
                                child: Text(type['label']!),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTransactionType = value;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: colors4Liontent.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _startDate = null;
                            _endDate = null;
                            _selectedTransactionType = null;
                          });
                        },
                        child: Text(
                          'Clear Filters',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors4Liontent.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isFilterExpanded = false;
                          });
                        },
                        child: Text('Apply Filters'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.receipt, size: 60, color: Colors.grey[400]),
          SizedBox(height: 20),
          Text(
            'No transactions found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Adjust your filters to see more results',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return TabBarView(
      controller: _tabController,
      children: [
        // All Transactions Tab
        _buildTransactionListView(_filteredTransactions),

        // Successful Transactions Tab
        _buildTransactionListView(_filteredTransactions),

        // Failed Transactions Tab
        _buildTransactionListView(_filteredTransactions),
      ],
    );
  }

  Widget _buildTransactionListView(List<Map<String, dynamic>> transactions) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final status = transaction['status'] as String;
        final isSuccessful = status == 'successful';

        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction['id'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSuccessful
                                    ? Color(0xFFE7F5E6)
                                    : Color(0xFFFEE8E8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isSuccessful ? 'Successful' : 'Failed',
                            style: TextStyle(
                              color:
                                  isSuccessful
                                      ? Color(0xFF258F19)
                                      : Color(0xFFD32F2F),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₦${NumberFormat('#,###').format(transaction['amount'])}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: colors4Liontent.primary,
                          ),
                        ),
                        Text(
                          DateFormat('MMM d, y').format(transaction['date']),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      transaction['description'],
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Recipient: ${transaction['recipient']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              InkWell(
                onTap: () {
                  // Here you would navigate to transaction details
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Transaction details coming soon'),
                      backgroundColor: colors4Liontent.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        color: colors4Liontent.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
