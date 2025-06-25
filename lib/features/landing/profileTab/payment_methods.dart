import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isAddingNew = false;

  // Mock data for cards and accounts
  final List<Map<String, dynamic>> _cards = [
    {
      'type': 'Visa',
      'number': '**** **** **** 4321',
      'expiry': '05/26',
      'isDefault': true,
    },
    {
      'type': 'Mastercard',
      'number': '**** **** **** 8765',
      'expiry': '11/24',
      'isDefault': false,
    },
  ];

  final List<Map<String, dynamic>> _accounts = [
    {'bank': 'First Bank', 'accountNumber': '**** 5678', 'isDefault': true},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text('Payment Methods', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.credit_card), text: 'Cards'),
            Tab(icon: Icon(FontAwesomeIcons.buildingColumns), text: 'Accounts'),
          ],
        ),
      ),
      body: _isAddingNew ? _buildAddNewForm() : _buildTabContent(),
      floatingActionButton:
          !_isAddingNew
              ? FloatingActionButton(
                backgroundColor: colors4Liontent.primary,
                child: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isAddingNew = true;
                  });
                },
              )
              : null,
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        // Cards Tab
        _cards.isEmpty
            ? _buildEmptyState('No saved cards', Icons.credit_card)
            : _buildCardsList(),

        // Accounts Tab
        _accounts.isEmpty
            ? _buildEmptyState(
              'No saved accounts',
              FontAwesomeIcons.buildingColumns,
            )
            : _buildAccountsList(),
      ],
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.grey[400]),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors4Liontent.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              setState(() {
                _isAddingNew = true;
              });
            },
            child: Text('Add New'),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _cards.length + 1,
      itemBuilder: (context, index) {
        if (index == _cards.length) {
          // Add a little space at the bottom
          return SizedBox(height: 80);
        }

        final card = _cards[index];
        return _buildPaymentMethodCard(
          icon:
              card['type'] == 'Visa'
                  ? FontAwesomeIcons.ccVisa
                  : card['type'] == 'Mastercard'
                  ? FontAwesomeIcons.ccMastercard
                  : FontAwesomeIcons.creditCard,
          title: card['type'],
          subtitle: '${card['number']} • Expires ${card['expiry']}',
          isDefault: card['isDefault'],
          onSetDefault: () {
            setState(() {
              for (var c in _cards) {
                c['isDefault'] = false;
              }
              _cards[index]['isDefault'] = true;
            });
          },
          onEdit: () {
            _showEditCardDialog(index);
          },
          onDelete: () {
            _showDeleteConfirmationDialog('card', () {
              setState(() {
                _cards.removeAt(index);
              });
            });
          },
        );
      },
    );
  }

  Widget _buildAccountsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _accounts.length + 1,
      itemBuilder: (context, index) {
        if (index == _accounts.length) {
          // Add a little space at the bottom
          return SizedBox(height: 80);
        }

        final account = _accounts[index];
        return _buildPaymentMethodCard(
          icon: FontAwesomeIcons.buildingColumns,
          title: account['bank'],
          subtitle: 'Account ${account['accountNumber']}',
          isDefault: account['isDefault'],
          onSetDefault: () {
            setState(() {
              for (var a in _accounts) {
                a['isDefault'] = false;
              }
              _accounts[index]['isDefault'] = true;
            });
          },
          onEdit: () {
            _showEditAccountDialog(index);
          },
          onDelete: () {
            _showDeleteConfirmationDialog('account', () {
              setState(() {
                _accounts.removeAt(index);
              });
            });
          },
        );
      },
    );
  }

  Widget _buildPaymentMethodCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDefault,
    required VoidCallback onSetDefault,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
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
          ListTile(
            leading: Icon(icon, color: colors4Liontent.primary, size: 28),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(subtitle),
            trailing:
                isDefault
                    ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors4Liontent.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Default',
                        style: TextStyle(
                          color: colors4Liontent.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    : null,
          ),
          Divider(height: 0),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: isDefault ? null : onSetDefault,
                  child: Text(
                    'Set Default',
                    style: TextStyle(
                      color: isDefault ? Colors.grey : colors4Liontent.primary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: onEdit,
                  child: Text(
                    'Edit',
                    style: TextStyle(color: colors4Liontent.primary),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: onDelete,
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewForm() {
    final isCardTab = _tabController.index == 0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isAddingNew = false;
                  });
                },
              ),
              Text(
                'Add New ${isCardTab ? 'Card' : 'Account'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 24),

          if (isCardTab) ...[
            // Card form fields
            TextField(
              decoration: InputDecoration(
                labelText: 'Cardholder Name',
                labelStyle: TextStyle(color: colors4Liontent.primary),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors4Liontent.primary,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              cursorColor: colors4Liontent.primary,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                labelStyle: TextStyle(color: colors4Liontent.primary),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors4Liontent.primary,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              keyboardType: TextInputType.number,
              cursorColor: colors4Liontent.primary,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                      labelStyle: TextStyle(color: colors4Liontent.primary),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colors4Liontent.primary,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    cursorColor: colors4Liontent.primary,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      labelStyle: TextStyle(color: colors4Liontent.primary),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colors4Liontent.primary,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    cursorColor: colors4Liontent.primary,
                  ),
                ),
              ],
            ),
          ] else ...[
            // Account form fields
            TextField(
              decoration: InputDecoration(
                labelText: 'Bank Name',
                labelStyle: TextStyle(color: colors4Liontent.primary),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors4Liontent.primary,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              cursorColor: colors4Liontent.primary,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Account Number',
                labelStyle: TextStyle(color: colors4Liontent.primary),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors4Liontent.primary,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              keyboardType: TextInputType.number,
              cursorColor: colors4Liontent.primary,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Account Name',
                labelStyle: TextStyle(color: colors4Liontent.primary),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors4Liontent.primary,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              cursorColor: colors4Liontent.primary,
            ),
          ],

          SizedBox(height: 32),
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (val) {},
                activeColor: colors4Liontent.primary,
              ),
              Text('Set as default payment method'),
            ],
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors4Liontent.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  if (isCardTab) {
                    _cards.add({
                      'type': 'Visa',
                      'number': '**** **** **** 1234',
                      'expiry': '12/28',
                      'isDefault': _cards.isEmpty,
                    });
                  } else {
                    _accounts.add({
                      'bank': 'New Bank',
                      'accountNumber': '**** 1234',
                      'isDefault': _accounts.isEmpty,
                    });
                  }
                  _isAddingNew = false;
                });
              },
              child: Text(
                'Save Payment Method',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditCardDialog(int index) {
    final card = _cards[index];
    String cardType = card['type'];
    String cardNumber = card['number'].toString().replaceAll('*', '');
    String expiryDate = card['expiry'];
    bool isDefault = card['isDefault'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Card'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: cardType,
                  decoration: InputDecoration(
                    labelText: 'Card Type',
                    labelStyle: TextStyle(color: colors4Liontent.primary),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colors4Liontent.primary,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(value: 'Visa', child: Text('Visa')),
                    DropdownMenuItem(
                      value: 'Mastercard',
                      child: Text('Mastercard'),
                    ),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    cardType = value!;
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Card Number (Last 4 digits)',
                    labelStyle: TextStyle(color: colors4Liontent.primary),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colors4Liontent.primary,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: colors4Liontent.primary,
                  onChanged: (value) {
                    if (value.length <= 4) {
                      cardNumber = value;
                    }
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                    labelStyle: TextStyle(color: colors4Liontent.primary),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colors4Liontent.primary,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  cursorColor: colors4Liontent.primary,
                  controller: TextEditingController(text: expiryDate),
                  onChanged: (value) {
                    expiryDate = value;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: isDefault,
                      onChanged: (value) {
                        isDefault = value!;
                      },
                      activeColor: colors4Liontent.primary,
                    ),
                    Text('Set as default payment method'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _cards[index] = {
                    'type': cardType,
                    'number':
                        '**** **** **** ${cardNumber.length <= 4 ? cardNumber : cardNumber.substring(cardNumber.length - 4)}',
                    'expiry': expiryDate,
                    'isDefault': isDefault,
                  };

                  // If this card is set as default, update others
                  if (isDefault) {
                    for (int i = 0; i < _cards.length; i++) {
                      if (i != index) {
                        _cards[i]['isDefault'] = false;
                      }
                    }
                  }
                });
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: colors4Liontent.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditAccountDialog(int index) {
    final account = _accounts[index];
    String bankName = account['bank'];
    String accountNumber = account['accountNumber'].toString().replaceAll(
      '*',
      '',
    );
    bool isDefault = account['isDefault'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Account'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Bank Name',
                    labelStyle: TextStyle(color: colors4Liontent.primary),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colors4Liontent.primary,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  cursorColor: colors4Liontent.primary,
                  controller: TextEditingController(text: bankName),
                  onChanged: (value) {
                    bankName = value;
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Account Number (Last 4 digits)',
                    labelStyle: TextStyle(color: colors4Liontent.primary),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colors4Liontent.primary,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: colors4Liontent.primary,
                  onChanged: (value) {
                    if (value.length <= 4) {
                      accountNumber = value;
                    }
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: isDefault,
                      onChanged: (value) {
                        isDefault = value!;
                      },
                      activeColor: colors4Liontent.primary,
                    ),
                    Text('Set as default payment method'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _accounts[index] = {
                    'bank': bankName,
                    'accountNumber':
                        '**** ${accountNumber.length <= 4 ? accountNumber : accountNumber.substring(accountNumber.length - 4)}',
                    'isDefault': isDefault,
                  };

                  // If this account is set as default, update others
                  if (isDefault) {
                    for (int i = 0; i < _accounts.length; i++) {
                      if (i != index) {
                        _accounts[i]['isDefault'] = false;
                      }
                    }
                  }
                });
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: colors4Liontent.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String itemType, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete $itemType?'),
          content: Text('Are you sure you want to delete this $itemType?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
