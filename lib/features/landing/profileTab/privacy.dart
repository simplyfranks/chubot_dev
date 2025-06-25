import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  Future<void> _generateAndSharePDF() async {
    try {
      // Get the PDF file from assets
      final ByteData data = await rootBundle.load(
        'assets/docs/privacy_policy.pdf',
      );
      final bytes = data.buffer.asUint8List();

      // Save the PDF to a temporary file
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/privacy_policy.pdf');
      await file.writeAsBytes(bytes);

      // Share the PDF
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'LionTent Privacy Policy');
    } catch (e) {
      print('Error sharing PDF: $e');
      // You might want to show a snackbar or dialog here to inform the user about the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text('Privacy Policy', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildLastUpdatedSection(),
            _buildTableOfContents(),
            _buildPolicySections(),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors4Liontent.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Column(
        children: [
          Icon(Icons.privacy_tip_outlined, size: 64, color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Privacy Policy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Your privacy is important to us',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdatedSection() {
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
      child: Row(
        children: [
          Icon(Icons.update, color: colors4Liontent.primary),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Updated',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'June 15, 2023',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableOfContents() {
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
            'Table of Contents',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildTableOfContentsItem('1. Introduction'),
          _buildTableOfContentsItem('2. Information We Collect'),
          _buildTableOfContentsItem('3. How We Use Your Information'),
          _buildTableOfContentsItem('4. Information Sharing'),
          _buildTableOfContentsItem('5. Data Security'),
          _buildTableOfContentsItem('6. Your Rights'),
          _buildTableOfContentsItem('7. Children\'s Privacy'),
          _buildTableOfContentsItem('8. Changes to This Policy'),
          _buildTableOfContentsItem('9. Contact Us'),
        ],
      ),
    );
  }

  Widget _buildTableOfContentsItem(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.arrow_right, size: 16, color: colors4Liontent.primary),
          SizedBox(width: 8),
          Text(title, style: TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildPolicySections() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPolicySection(
            title: '1. Introduction',
            content:
                'Welcome to LionTent. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application and services. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.',
          ),
          SizedBox(height: 16),
          _buildPolicySection(
            title: '2. Information We Collect',
            content:
                'We collect information that you provide directly to us, including but not limited to:\n\n'
                '• Personal identification information (name, email address, phone number)\n'
                '• Profile information (profile picture, preferences)\n'
                '• Payment information (credit card details, billing address)\n'
                '• Booking information (dates, locations, preferences)\n'
                '• Communication data (messages, feedback)\n\n'
                'We also automatically collect certain information when you use our services, such as:\n\n'
                '• Device information (device type, operating system)\n'
                '• Log data (IP address, access times, pages viewed)\n'
                '• Location data (with your permission)\n'
                '• Usage data (features used, time spent)',
          ),
          SizedBox(height: 16),
          _buildPolicySection(
            title: '3. How We Use Your Information',
            content:
                'We use the information we collect to:\n\n'
                '• Provide, maintain, and improve our services\n'
                '• Process your bookings and payments\n'
                '• Communicate with you about our services\n'
                '• Send you marketing communications (with your consent)\n'
                '• Detect, investigate, and prevent fraudulent transactions\n'
                '• Comply with legal obligations\n'
                '• Analyze and improve our application performance',
          ),
          SizedBox(height: 16),
          _buildPolicySection(
            title: '4. Information Sharing',
            content:
                'We may share your information with:\n\n'
                '• Service providers who assist in our operations\n'
                '• Property hosts when you make a booking\n'
                '• Payment processors to handle transactions\n'
                '• Law enforcement when required by law\n\n'
                'We do not sell your personal information to third parties.',
          ),
          SizedBox(height: 16),
          _buildPolicySection(
            title: '5. Data Security',
            content:
                'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security.',
          ),
          SizedBox(height: 16),
          _buildPolicySection(
            title: '6. Your Rights',
            content:
                'Depending on your location, you may have certain rights regarding your personal information, including:\n\n'
                '• Right to access your personal information\n'
                '• Right to correct inaccurate information\n'
                '• Right to request deletion of your information\n'
                '• Right to withdraw consent\n'
                '• Right to data portability\n\n'
                'To exercise these rights, please contact us using the information provided in the Contact Us section.',
          ),
          SizedBox(height: 16),
          _buildPolicySection(
            title: '7. Children\'s Privacy',
            content:
                'Our services are not intended for individuals under the age of 16. We do not knowingly collect personal information from children. If you are a parent or guardian and believe your child has provided us with personal information, please contact us, and we will take steps to delete such information.',
          ),
          SizedBox(height: 16),
          _buildPolicySection(
            title: '8. Changes to This Policy',
            content:
                'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date. You are advised to review this Privacy Policy periodically for any changes.',
          ),
        ],
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
    return Container(
      width: double.infinity,
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
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
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
            '9. Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'If you have any questions about this Privacy Policy, please contact us:',
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
          ),
          SizedBox(height: 16),
          _buildContactItem(
            icon: Icons.email,
            title: 'Email',
            content: 'privacy@liontent.com',
          ),
          SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.phone,
            title: 'Phone',
            content: '+1 (555) 123-4567',
          ),
          SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.location_on,
            title: 'Address',
            content: '123 Privacy Street, Suite 100\nSan Francisco, CA 94105',
          ),
          SizedBox(height: 24),
          lengthButton1Light(
            navigateTo: _generateAndSharePDF,
            widgetchoice: Text(
              'Download Privacy Policy',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colors4Liontent.primary, size: 20),
        SizedBox(width: 12),
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
                content,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
