import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';

class DisputeResolution extends StatefulWidget {
  const DisputeResolution({super.key});

  @override
  State<DisputeResolution> createState() => _DisputeResolutionState();
}

class _DisputeResolutionState extends State<DisputeResolution>
    with SingleTickerProviderStateMixin {
  final TextEditingController _bookingIdController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _bookingIdFocusNode = FocusNode();
  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  String? _selectedDisputeType;
  String? _selectedPriority;
  bool _isSubmitting = false;
  bool _isSuccessful = false;
  bool _hasAttachment = false;
  late TabController _tabController;

  final List<String> _disputeTypes = [
    'Booking Cancellation Dispute',
    'Payment Refund Issue',
    'Service Quality Complaint',
    'Property Condition Issue',
    'Pricing Discrepancy',
    'Unauthorized Charges',
    'Booking Modification Problem',
    'Lost Property',
    'Safety & Security Concern',
    'Other',
  ];

  final List<String> _priorities = ['Normal', 'High', 'Urgent'];

  // Mock data for disputes
  final List<Map<String, dynamic>> _disputes = [
    {
      'id': 'DSP-001',
      'subject': 'Refund for cancelled booking',
      'date': DateTime.now().subtract(Duration(days: 5)),
      'status': 'in review',
      'priority': 'High',
      'lastUpdate': 'Under investigation by finance team',
    },
    {
      'id': 'DSP-002',
      'subject': 'Double charge for room #1204',
      'date': DateTime.now().subtract(Duration(days: 15)),
      'status': 'resolved',
      'priority': 'Normal',
      'lastUpdate': 'Refund processed on June 10',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _bookingIdController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    _bookingIdFocusNode.dispose();
    _subjectFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _submitDispute() {
    // Validate form
    if (_selectedDisputeType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a dispute type'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_selectedPriority == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a priority level'),
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

    if (_descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide a detailed description'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _descriptionFocusNode.requestFocus();
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
          _selectedDisputeType = null;
          _selectedPriority = null;
          _bookingIdController.clear();
          _subjectController.clear();
          _descriptionController.clear();
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
        title: Text(
          'Dispute Resolution',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [Tab(text: 'File a Dispute'), Tab(text: 'My Disputes')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // File a Dispute Tab
          SingleChildScrollView(
            child: Column(children: [_buildDisputeInfo(), _buildDisputeForm()]),
          ),

          // My Disputes Tab
          _buildDisputesHistorySection(),
        ],
      ),
    );
  }

  Widget _buildDisputeInfo() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: colors4Liontent.primary),
              SizedBox(width: 8),
              Text(
                'About Dispute Resolution',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Our dispute resolution service helps resolve issues related to bookings, payments, and service quality. Please provide detailed information to help us investigate your case effectively.',
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: colors4Liontent.primaryLight,
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Response Time: 24-48 hours for normal priority, within 12 hours for urgent cases.',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.contact_support_outlined,
                color: colors4Liontent.primaryLight,
                size: 18,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'For immediate assistance with urgent matters, please contact our support team.',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisputeForm() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child:
          _isSuccessful
              ? _buildSuccessMessage()
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'File a New Dispute',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Dispute Type Dropdown
                  Text(
                    'Dispute Type*',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedDisputeType,
                        hint: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Select dispute type',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        borderRadius: BorderRadius.circular(8),
                        items:
                            _disputeTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDisputeType = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Priority Dropdown
                  Text(
                    'Priority Level*',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedPriority,
                        hint: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Select priority',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        borderRadius: BorderRadius.circular(8),
                        items:
                            _priorities.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color:
                                          value == 'Normal'
                                              ? Colors.green
                                              : value == 'High'
                                              ? Colors.orange
                                              : Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text(value),
                                  ],
                                ),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPriority = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Booking ID field
                  Text(
                    'Booking ID (if applicable)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _bookingIdController,
                    focusNode: _bookingIdFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter booking ID',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: colors4Liontent.primary),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Subject field
                  Text(
                    'Subject*',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _subjectController,
                    focusNode: _subjectFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Brief description of the issue',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: colors4Liontent.primary),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Description field
                  Text(
                    'Detailed Description*',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    focusNode: _descriptionFocusNode,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          'Provide detailed information about your dispute...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: colors4Liontent.primary),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Attachment option
                  InkWell(
                    onTap: () {
                      setState(() {
                        _hasAttachment = !_hasAttachment;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          _hasAttachment
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: colors4Liontent.primary,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Add Supporting Documents',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),

                  if (_hasAttachment)
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.upload_file,
                            color: colors4Liontent.primary,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Tap to upload photos, receipts, or other documents',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 24),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitDispute,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors4Liontent.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          _isSubmitting
                              ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Text(
                                'Submit Dispute',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Disclaimer text
                  Text(
                    'By submitting this form, you confirm that all the information provided is accurate and truthful.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colors4Liontent.primaryLight.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 48,
              color: colors4Liontent.primary,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Dispute Submitted Successfully',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Your dispute has been received and will be reviewed by our team.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'You will be notified of any updates via email and the app.',
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDisputesHistorySection() {
    return _disputes.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.scaleBalance, size: 60, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text(
                'No Disputes Filed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Any disputes you file will appear here',
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
                  _tabController.animateTo(0); // Switch to File a Dispute tab
                },
                child: Text('File a Dispute'),
              ),
            ],
          ),
        )
        : ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _disputes.length,
          itemBuilder: (context, index) {
            final dispute = _disputes[index];
            final bool isResolved = dispute['status'] == 'resolved';
            final Color statusColor =
                isResolved
                    ? Colors.green
                    : dispute['status'] == 'in review'
                    ? Colors.orange
                    : Colors.blue;

            return Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    dispute['id'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: statusColor.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    dispute['status'].toString().toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    dispute['priority'] == 'Normal'
                                        ? Colors.green.withOpacity(0.1)
                                        : dispute['priority'] == 'High'
                                        ? Colors.orange.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color:
                                        dispute['priority'] == 'Normal'
                                            ? Colors.green
                                            : dispute['priority'] == 'High'
                                            ? Colors.orange
                                            : Colors.red,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    dispute['priority'],
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          dispute['priority'] == 'Normal'
                                              ? Colors.green
                                              : dispute['priority'] == 'High'
                                              ? Colors.orange
                                              : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          dispute['subject'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${dispute['date'].day}/${dispute['date'].month}/${dispute['date'].year}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isResolved ? Icons.check_circle : Icons.update,
                                size: 18,
                                color: statusColor,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  dispute['lastUpdate'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.visibility, size: 16),
                          label: Text('View Details'),
                          style: TextButton.styleFrom(
                            foregroundColor: colors4Liontent.primary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        if (!isResolved)
                          OutlinedButton(
                            onPressed: () {},
                            child: Text('Update'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colors4Liontent.primary,
                              side: BorderSide(color: colors4Liontent.primary),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
