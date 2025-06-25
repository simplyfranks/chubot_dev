import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService>
    with SingleTickerProviderStateMixin {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();

  String? _selectedIssueType;
  bool _isSubmitting = false;
  bool _isSuccessful = false;
  final bool _showFaqAnswer = false;
  int _expandedFaqIndex = -1;
  bool _hasAttachment = false;
  late TabController _tabController;

  // List of support issue types
  final List<String> _issueTypes = [
    'Account Access',
    'Payment Issues',
    'Booking Problems',
    'Lodge Complaints',
    'Property Inquiries',
    'App Functionality',
    'Security Concerns',
    'Other',
  ];

  // List of FAQ items
  final List<Map<String, String>> _faqItems = [
    {
      'question': 'How do I book a lodge?',
      'answer':
          'To book a lodge, navigate to the "Search" tab, select "Lodges", browse the available options, and tap on one to view details. From there, you can check availability and complete the booking process.',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer':
          'We accept various payment methods including credit/debit cards and bank transfers. You can manage your payment methods in the "Profile" tab under "Saved Payment Methods".',
    },
    {
      'question': 'How can I cancel my booking?',
      'answer':
          'To cancel a booking, go to your bookings in the profile section, select the booking you wish to cancel, and follow the cancellation process. Please note that cancellation policies vary depending on the property.',
    },
    {
      'question': 'Is my personal information secure?',
      'answer':
          'Yes, we use industry-standard encryption to protect your data. We never share your personal information with third parties without your consent. You can review our privacy policy for more details.',
    },
    {
      'question': 'How do I report an issue with a property?',
      'answer':
          'You can report property issues through this customer service page by selecting "Lodge Complaints" or "Property Inquiries" from the issue type dropdown and providing details about your experience.',
    },
  ];

  // Mock data for support tickets
  final List<Map<String, dynamic>> _supportTickets = [
    {
      'id': 'TKT-001',
      'subject': 'Payment not processed',
      'date': DateTime.now().subtract(Duration(days: 2)),
      'status': 'open',
      'lastUpdate': 'Waiting for agent response',
    },
    {
      'id': 'TKT-002',
      'subject': 'Unable to book Sunset Lodge',
      'date': DateTime.now().subtract(Duration(days: 7)),
      'status': 'closed',
      'lastUpdate': 'Issue resolved',
    },
    {
      'id': 'TKT-003',
      'subject': 'Room condition complaint',
      'date': DateTime.now().subtract(Duration(days: 14)),
      'status': 'in-progress',
      'lastUpdate': 'Under investigation',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _subjectFocusNode.dispose();
    _messageFocusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validate form
    if (_selectedIssueType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an issue type'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_subjectController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a subject'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _subjectFocusNode.requestFocus();
      return;
    }

    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your message'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _messageFocusNode.requestFocus();
      return;
    }

    // Show loading
    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call with a delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
        _isSuccessful = true;
      });

      // Reset form
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isSuccessful = false;
          _selectedIssueType = null;
          _subjectController.clear();
          _messageController.clear();
          _hasAttachment = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text('Customer Support', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [Tab(text: 'Contact Us'), Tab(text: 'My Tickets')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Contact Us Tab
          SingleChildScrollView(
            child: Column(
              children: [
                _buildContactOptions(),
                _buildFaqSection(),
                _buildSupportForm(),
              ],
            ),
          ),

          // My Tickets Tab
          _buildTicketsSection(),
        ],
      ),
    );
  }

  Widget _buildTicketsSection() {
    return _supportTickets.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.ticketOutline, size: 60, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text(
                'No Support Tickets',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Any support requests you submit will appear here',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors4Liontent.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  _tabController.animateTo(0); // Switch to Contact tab
                },
                child: Text('Contact Support'),
              ),
            ],
          ),
        )
        : ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _supportTickets.length,
          itemBuilder: (context, index) {
            final ticket = _supportTickets[index];
            final status = ticket['status'] as String;

            Color statusColor;
            String statusText;

            switch (status) {
              case 'open':
                statusColor = Colors.blue;
                statusText = 'Open';
                break;
              case 'in-progress':
                statusColor = Colors.orange;
                statusText = 'In Progress';
                break;
              case 'closed':
                statusColor = Colors.grey;
                statusText = 'Closed';
                break;
              default:
                statusColor = Colors.grey;
                statusText = 'Unknown';
            }

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
              child: InkWell(
                onTap: () {
                  // TODO: Navigate to ticket details
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ticket details coming soon'),
                      backgroundColor: colors4Liontent.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
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
                                ticket['id'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  statusText,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            ticket['subject'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Last update: ${ticket['lastUpdate']}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                _formatDate(ticket['date']),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 16,
                            color: colors4Liontent.primary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'View Details',
                            style: TextStyle(
                              color: colors4Liontent.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Widget _buildContactOptions() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors4Liontent.primary,
            ),
          ),
          SizedBox(height: 16),
          _buildContactItem(
            icon: Icons.phone,
            title: 'Phone Support',
            subtitle: '+234 801 234 5678',
            onTap: () {},
          ),
          Divider(height: 24),
          _buildContactItem(
            icon: Icons.email_outlined,
            title: 'Email Support',
            subtitle: 'support@liontent.com',
            onTap: () {},
          ),
          Divider(height: 24),
          _buildContactItem(
            icon: FontAwesomeIcons.whatsapp,
            title: 'WhatsApp Support',
            subtitle: '+234 801 234 5678',
            onTap: () {},
          ),
          Divider(height: 24),
          _buildContactItem(
            icon: Icons.chat_bubble_outline,
            title: 'Live Chat',
            subtitle: 'Available 9am - 5pm on weekdays',
            onTap: () {},
          ),
          Divider(height: 24),
          _buildContactItem(
            icon: MdiIcons.mapMarkerOutline,
            title: 'Visit Our Office',
            subtitle: 'Lagos, Nigeria',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors4Liontent.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: colors4Liontent.primary, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: colors4Liontent.primary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors4Liontent.primary,
            ),
          ),
          SizedBox(height: 16),
          ...List.generate(_faqItems.length, (index) {
            return Column(
              children: [
                _buildFaqItem(
                  question: _faqItems[index]['question']!,
                  answer: _faqItems[index]['answer']!,
                  isExpanded: _expandedFaqIndex == index,
                  onTap: () {
                    setState(() {
                      if (_expandedFaqIndex == index) {
                        _expandedFaqIndex = -1;
                      } else {
                        _expandedFaqIndex = index;
                      }
                    });
                  },
                ),
                if (index < _faqItems.length - 1) Divider(height: 16),
              ],
            );
          }),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navigate to full FAQ page
              },
              child: Text(
                'View All FAQs',
                style: TextStyle(
                  color: colors4Liontent.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({
    required String question,
    required String answer,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  color: colors4Liontent.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              answer,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ),
      ],
    );
  }

  Widget _buildSupportForm() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Us a Message',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colors4Liontent.primary,
            ),
          ),
          SizedBox(height: 16),

          // Success message
          if (_isSuccessful)
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Color(0xFFE7F5E6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF258F19)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your message has been sent successfully. We will get back to you shortly.',
                      style: TextStyle(color: Color(0xFF258F19)),
                    ),
                  ),
                ],
              ),
            ),

          // Issue Type Dropdown
          Text(
            'Issue Type',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select an issue type'),
                value: _selectedIssueType,
                items:
                    _issueTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIssueType = value;
                  });
                },
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: colors4Liontent.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Subject field
          Text(
            'Subject',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _subjectController,
            focusNode: _subjectFocusNode,
            decoration: InputDecoration(
              hintText: 'Enter the subject of your message',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colors4Liontent.primary,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            cursorColor: colors4Liontent.primary,
          ),
          SizedBox(height: 16),

          // Message field
          Text(
            'Message',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _messageController,
            focusNode: _messageFocusNode,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Describe your issue in detail',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colors4Liontent.primary,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
              contentPadding: EdgeInsets.all(16),
            ),
            cursorColor: colors4Liontent.primary,
          ),
          SizedBox(height: 16),

          // Attachment option
          InkWell(
            onTap: () {
              setState(() {
                _hasAttachment = !_hasAttachment;
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      _hasAttachment
                          ? colors4Liontent.primary
                          : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(8),
                color:
                    _hasAttachment
                        ? colors4Liontent.primary.withOpacity(0.05)
                        : Colors.transparent,
              ),
              child: Row(
                children: [
                  Icon(
                    _hasAttachment ? Icons.check_circle : Icons.attach_file,
                    color: colors4Liontent.primary,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    _hasAttachment
                        ? '1 file attached'
                        : 'Add attachment (photos, documents)',
                    style: TextStyle(
                      color:
                          _hasAttachment
                              ? colors4Liontent.primary
                              : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Submit button
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
              onPressed: _isSubmitting ? null : _submitForm,
              child:
                  _isSubmitting
                      ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Text('Submit', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
