import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';

class BestPractices extends StatelessWidget {
  const BestPractices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text('Best Practices', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildGuestGuidelinesSection(),
            _buildHostGuidelinesSection(),
            _buildSafetyTipsSection(),
            _buildCommunityGuidelinesSection(),
            _buildFeedbackSection(),
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
          Icon(Icons.tips_and_updates, size: 64, color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Best Practices',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Guidelines for a great experience',
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

  Widget _buildGuestGuidelinesSection() {
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
              Icon(
                Icons.person_outline,
                color: colors4Liontent.primary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Guest Guidelines',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Booking Process',
            description:
                'Read property descriptions carefully, check amenities, and review cancellation policies before booking. Contact hosts with any questions before confirming your reservation.',
            icon: Icons.calendar_today,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Communication',
            description:
                'Maintain clear communication with your host before and during your stay. Respond promptly to messages and inform hosts of any changes to your plans.',
            icon: Icons.message,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Respect the Property',
            description:
                'Treat the property as if it were your own. Follow house rules, keep the space clean, and report any issues to the host immediately.',
            icon: Icons.home,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Check-in & Check-out',
            description:
                'Follow the check-in and check-out procedures provided by the host. Be punctual and inform the host if you need to adjust your arrival or departure times.',
            icon: Icons.access_time,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Reviews',
            description:
                'Leave honest and constructive reviews after your stay. Focus on your experience and provide specific feedback that will help future guests and hosts.',
            icon: Icons.star,
          ),
        ],
      ),
    );
  }

  Widget _buildHostGuidelinesSection() {
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
              Icon(
                Icons.home_work_outlined,
                color: colors4Liontent.primary,
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Host Guidelines',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Property Listings',
            description:
                'Create accurate and detailed property listings with high-quality photos. Clearly describe amenities, house rules, and any potential limitations.',
            icon: Icons.list_alt,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Pricing Strategy',
            description:
                'Set competitive prices based on location, amenities, and seasonal demand. Consider offering discounts for longer stays to attract more bookings.',
            icon: Icons.attach_money,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Guest Communication',
            description:
                'Respond to inquiries and booking requests promptly. Provide clear check-in instructions and be available to address guest concerns during their stay.',
            icon: Icons.people,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Property Maintenance',
            description:
                'Keep your property clean, well-maintained, and stocked with essential supplies. Address maintenance issues promptly to ensure guest satisfaction.',
            icon: Icons.build,
          ),
          SizedBox(height: 16),
          _buildGuidelineItem(
            title: 'Professionalism',
            description:
                'Treat your hosting as a business. Maintain professional communication, honor confirmed bookings, and strive to exceed guest expectations.',
            icon: Icons.business,
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyTipsSection() {
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
              Icon(Icons.security, color: colors4Liontent.primary, size: 24),
              SizedBox(width: 12),
              Text(
                'Safety Tips',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildSafetyTipItem(
            title: 'Verify Identity',
            description:
                'Use our platform\'s verification features to confirm your identity and the identity of your hosts/guests.',
            icon: Icons.verified_user,
          ),
          SizedBox(height: 16),
          _buildSafetyTipItem(
            title: 'Secure Payments',
            description:
                'Always make payments through our platform. Never send money directly to hosts or provide payment information outside the app.',
            icon: Icons.payment,
          ),
          SizedBox(height: 16),
          _buildSafetyTipItem(
            title: 'Read Reviews',
            description:
                'Check reviews from previous guests/hosts to assess reliability and safety. Be cautious of listings with no reviews or suspicious patterns.',
            icon: Icons.rate_review,
          ),
          SizedBox(height: 16),
          _buildSafetyTipItem(
            title: 'Emergency Contacts',
            description:
                'Keep emergency contact information handy, including local authorities and our support team. Share your travel plans with trusted friends or family.',
            icon: Icons.emergency,
          ),
          SizedBox(height: 16),
          _buildSafetyTipItem(
            title: 'Trust Your Instincts',
            description:
                'If something feels off, trust your instincts. Report suspicious behavior to our support team and consider alternative accommodations if necessary.',
            icon: Icons.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityGuidelinesSection() {
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
              Icon(Icons.groups, color: colors4Liontent.primary, size: 24),
              SizedBox(width: 12),
              Text(
                'Community Guidelines',
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
            'Our community is built on trust, respect, and mutual benefit. We expect all users to:',
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
          ),
          SizedBox(height: 16),
          _buildCommunityGuidelineItem(
            title: 'Be Respectful',
            description:
                'Treat others with respect, regardless of differences in background, beliefs, or preferences.',
            icon: Icons.favorite,
          ),
          SizedBox(height: 16),
          _buildCommunityGuidelineItem(
            title: 'Be Honest',
            description:
                'Provide accurate information and honest reviews. Misrepresentation harms our community.',
            icon: Icons.check_circle,
          ),
          SizedBox(height: 16),
          _buildCommunityGuidelineItem(
            title: 'Be Responsive',
            description:
                'Respond to communications in a timely manner to maintain a smooth experience for all parties.',
            icon: Icons.reply,
          ),
          SizedBox(height: 16),
          _buildCommunityGuidelineItem(
            title: 'Be Considerate',
            description:
                'Consider the impact of your actions on others, including neighbors and the local community.',
            icon: Icons.people_outline,
          ),
          SizedBox(height: 16),
          _buildCommunityGuidelineItem(
            title: 'Follow Local Laws',
            description:
                'Comply with all applicable laws and regulations in your jurisdiction.',
            icon: Icons.gavel,
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
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
              Icon(Icons.feedback, color: colors4Liontent.primary, size: 24),
              SizedBox(width: 12),
              Text(
                'We Value Your Feedback',
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
            'Help us improve our platform by sharing your experiences and suggestions. Your feedback helps us create a better experience for everyone.',
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
          ),
          SizedBox(height: 24),
          lengthButton1Light(
            navigateTo: () {},
            widgetchoice: Text(
              'Submit Feedback',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineItem({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors4Liontent.primaryLight.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: colors4Liontent.primary, size: 20),
        ),
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
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSafetyTipItem({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.orange[700], size: 20),
        ),
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
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommunityGuidelineItem({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.green[700], size: 20),
        ),
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
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
