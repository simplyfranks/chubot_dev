import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text('Terms of Service', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildLastUpdatedSection(),
            _buildTableOfContents(),
            _buildTermsSections(),
            _buildAcceptanceSection(),
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
          Icon(Icons.gavel_outlined, size: 64, color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Terms of Service',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Please read these terms carefully',
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
          _buildTableOfContentsItem('1. Agreement to Terms'),
          _buildTableOfContentsItem('2. Description of Services'),
          _buildTableOfContentsItem('3. User Accounts'),
          _buildTableOfContentsItem('4. Booking and Cancellation'),
          _buildTableOfContentsItem('5. Payment Terms'),
          _buildTableOfContentsItem('6. Host Responsibilities'),
          _buildTableOfContentsItem('7. User Responsibilities'),
          _buildTableOfContentsItem('8. Intellectual Property'),
          _buildTableOfContentsItem('9. Limitation of Liability'),
          _buildTableOfContentsItem('10. Termination'),
          _buildTableOfContentsItem('11. Changes to Terms'),
          _buildTableOfContentsItem('12. Contact Information'),
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

  Widget _buildTermsSections() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTermsSection(
            title: '1. Agreement to Terms',
            content:
                'By accessing or using the LionTent application and services, you agree to be bound by these Terms of Service. If you disagree with any part of the terms, you may not access the application or use our services.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '2. Description of Services',
            content:
                'LionTent provides a platform that connects property owners/hosts with potential guests. Our services include:\n\n'
                '• Property listings and search functionality\n'
                '• Booking and reservation management\n'
                '• Payment processing\n'
                '• Communication tools between hosts and guests\n'
                '• Reviews and ratings system\n\n'
                'We act as an intermediary and are not responsible for the quality, safety, or legality of the properties listed on our platform.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '3. User Accounts',
            content:
                'To use certain features of our services, you must register for an account. You agree to:\n\n'
                '• Provide accurate and complete information\n'
                '• Maintain the security of your account credentials\n'
                '• Notify us immediately of any unauthorized access\n'
                '• Be responsible for all activities that occur under your account\n\n'
                'We reserve the right to suspend or terminate accounts that violate these terms.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '4. Booking and Cancellation',
            content:
                'When making a booking through our platform:\n\n'
                '• You agree to pay all fees and charges associated with your booking\n'
                '• Cancellation policies vary by property and are clearly stated during booking\n'
                '• Refunds are subject to the host\'s cancellation policy\n'
                '• We may charge service fees for cancellations\n\n'
                'Hosts may cancel bookings in exceptional circumstances, and we will assist in finding alternative accommodations.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '5. Payment Terms',
            content:
                'Payment processing is handled through our secure platform:\n\n'
                '• All payments are processed in the currency displayed during booking\n'
                '• We may charge service fees in addition to the property rate\n'
                '• Hosts receive payment after the guest\'s stay, minus our service fees\n'
                '• Taxes may apply and will be clearly indicated during booking\n\n'
                'By making a payment, you authorize us to charge your payment method for the total amount.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '6. Host Responsibilities',
            content:
                'As a host, you agree to:\n\n'
                '• Provide accurate property descriptions and photos\n'
                '• Maintain your property in good condition\n'
                '• Comply with all applicable laws and regulations\n'
                '• Respond to guest inquiries and booking requests promptly\n'
                '• Honor confirmed bookings\n'
                '• Provide a safe and clean environment for guests\n\n'
                'We reserve the right to remove listings that violate our standards.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '7. User Responsibilities',
            content:
                'As a user of our platform, you agree to:\n\n'
                '• Provide accurate personal information\n'
                '• Treat properties with respect and care\n'
                '• Comply with house rules set by hosts\n'
                '• Pay for any damages caused during your stay\n'
                '• Leave honest reviews based on your experience\n'
                '• Not engage in fraudulent activities\n\n'
                'Violation of these responsibilities may result in account suspension.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '8. Intellectual Property',
            content:
                'All content on our platform, including text, graphics, logos, and software, is the property of LionTent or our licensors and is protected by copyright and other intellectual property laws. You may not reproduce, distribute, or create derivative works without our express permission.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '9. Limitation of Liability',
            content:
                'To the maximum extent permitted by law, LionTent shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use or inability to use our services. Our liability is limited to the amount paid by you for the specific booking giving rise to the claim.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '10. Termination',
            content:
                'We may terminate or suspend your account and access to our services immediately, without prior notice, for any reason, including breach of these Terms. Upon termination, your right to use the services will immediately cease.',
          ),
          SizedBox(height: 16),
          _buildTermsSection(
            title: '11. Changes to Terms',
            content:
                'We reserve the right to modify these terms at any time. We will notify users of any material changes by posting the new Terms on this page and updating the "Last Updated" date. Your continued use of our services after such modifications constitutes your acknowledgment of the modified Terms.',
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection({required String title, required String content}) {
    return Container(
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

  Widget _buildAcceptanceSection() {
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
            '12. Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'If you have any questions about these Terms of Service, please contact us:',
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
          ),
          SizedBox(height: 16),
          _buildContactItem(
            icon: Icons.email,
            title: 'Email',
            content: 'legal@liontent.com',
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
            content: '123 Legal Avenue, Suite 200\nSan Francisco, CA 94105',
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: lengthButton1Light(
                  navigateTo: () {},
                  widgetchoice: Text(
                    'Download Terms',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors4Liontent.primary,
                    side: BorderSide(color: colors4Liontent.primary),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Accept Terms',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
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
