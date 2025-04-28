import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _bookingUpdates = true;
  bool _promotionalMessages = false;
  bool _priceAlerts = true;
  bool _securityAlerts = true;
  bool _newsletter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text(
          'Notification Settings',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNotificationTypesSection(),
            _buildNotificationCategoriesSection(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTypesSection() {
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
          Text(
            'Notification Channels',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildNotificationTypeSwitch(
            title: 'Push Notifications',
            subtitle: 'Receive instant updates on your device',
            value: _pushNotifications,
            onChanged: (value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
          Divider(height: 24),
          _buildNotificationTypeSwitch(
            title: 'Email Notifications',
            subtitle: 'Get updates in your email inbox',
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          Divider(height: 24),
          _buildNotificationTypeSwitch(
            title: 'SMS Notifications',
            subtitle: 'Receive text message updates',
            value: _smsNotifications,
            onChanged: (value) {
              setState(() {
                _smsNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCategoriesSection() {
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
          Text(
            'Notification Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildNotificationCategorySwitch(
            title: 'Booking Updates',
            subtitle: 'Updates about your bookings and reservations',
            value: _bookingUpdates,
            onChanged: (value) {
              setState(() {
                _bookingUpdates = value;
              });
            },
          ),
          Divider(height: 24),
          _buildNotificationCategorySwitch(
            title: 'Promotional Messages',
            subtitle: 'Special offers and deals',
            value: _promotionalMessages,
            onChanged: (value) {
              setState(() {
                _promotionalMessages = value;
              });
            },
          ),
          Divider(height: 24),
          _buildNotificationCategorySwitch(
            title: 'Price Alerts',
            subtitle: 'Notifications about price changes for your wishlist',
            value: _priceAlerts,
            onChanged: (value) {
              setState(() {
                _priceAlerts = value;
              });
            },
          ),
          Divider(height: 24),
          _buildNotificationCategorySwitch(
            title: 'Security Alerts',
            subtitle: 'Important security and account updates',
            value: _securityAlerts,
            onChanged: (value) {
              setState(() {
                _securityAlerts = value;
              });
            },
          ),
          Divider(height: 24),
          _buildNotificationCategorySwitch(
            title: 'Newsletter',
            subtitle: 'Weekly updates and tips',
            value: _newsletter,
            onChanged: (value) {
              setState(() {
                _newsletter = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTypeSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: colors4Liontent.primary,
        ),
      ],
    );
  }

  Widget _buildNotificationCategorySwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: colors4Liontent.primary,
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      margin: EdgeInsets.all(16),
      child: lengthButton1Light(
        navigateTo: () {},
        widgetchoice: Text(
          'Save Changes',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
