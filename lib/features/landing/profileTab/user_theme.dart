import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';

class UserTheme extends StatefulWidget {
  const UserTheme({super.key});

  @override
  State<UserTheme> createState() => _UserThemeState();
}

class _UserThemeState extends State<UserTheme> {
  String _selectedTheme = 'system';
  bool _useDynamicColors = true;
  double _textScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text('Theme Settings', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildThemeModeSection(),
            _buildDynamicColorsSection(),
            _buildTextSizeSection(),
            _buildPreviewSection(),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeSection() {
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
            'Theme Mode',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          _buildThemeOption(
            title: 'System Default',
            subtitle: 'Follow system theme settings',
            icon: Icons.brightness_auto,
            value: 'system',
            isSelected: _selectedTheme == 'system',
            onTap: () {
              setState(() {
                _selectedTheme = 'system';
              });
            },
          ),
          Divider(height: 24),
          _buildThemeOption(
            title: 'Light Theme',
            subtitle: 'Always use light theme',
            icon: Icons.light_mode,
            value: 'light',
            isSelected: _selectedTheme == 'light',
            onTap: () {
              setState(() {
                _selectedTheme = 'light';
              });
            },
          ),
          Divider(height: 24),
          _buildThemeOption(
            title: 'Dark Theme',
            subtitle: 'Always use dark theme',
            icon: Icons.dark_mode,
            value: 'dark',
            isSelected: _selectedTheme == 'dark',
            onTap: () {
              setState(() {
                _selectedTheme = 'dark';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? colors4Liontent.primaryLight.withOpacity(0.2)
                      : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isSelected ? colors4Liontent.primary : Colors.grey[600],
              size: 24,
            ),
          ),
          SizedBox(width: 16),
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
          if (isSelected)
            Icon(Icons.check_circle, color: colors4Liontent.primary),
        ],
      ),
    );
  }

  Widget _buildDynamicColorsSection() {
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
            'Dynamic Colors',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Use System Colors',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Adapt app colors to match system theme',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _useDynamicColors,
                onChanged: (value) {
                  setState(() {
                    _useDynamicColors = value;
                  });
                },
                activeColor: colors4Liontent.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextSizeSection() {
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
            'Text Size',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.text_decrease, color: Colors.grey[600]),
              SizedBox(width: 16),
              Expanded(
                child: Slider(
                  value: _textScaleFactor,
                  min: 0.8,
                  max: 1.4,
                  divisions: 6,
                  label: '${(_textScaleFactor * 100).round()}%',
                  onChanged: (value) {
                    setState(() {
                      _textScaleFactor = value;
                    });
                  },
                  activeColor: colors4Liontent.primary,
                ),
              ),
              Icon(Icons.text_increase, color: Colors.grey[600]),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Preview Text',
            style: TextStyle(
              fontSize: 16 * _textScaleFactor,
              color: Colors.black87,
            ),
          ),
          Text(
            'This is how your text will look with the selected size.',
            style: TextStyle(
              fontSize: 14 * _textScaleFactor,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection() {
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
            'Theme Preview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  _selectedTheme == 'dark'
                      ? Colors.grey[900]
                      : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color:
                        _selectedTheme == 'dark'
                            ? Colors.white
                            : Colors.black87,
                  ),
                  title: Text(
                    'Sample Title',
                    style: TextStyle(
                      color:
                          _selectedTheme == 'dark'
                              ? Colors.white
                              : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    'Sample subtitle text',
                    style: TextStyle(
                      color:
                          _selectedTheme == 'dark'
                              ? Colors.white70
                              : Colors.black54,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors4Liontent.primary,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 40),
                  ),
                  child: Text('Sample Button'),
                ),
              ],
            ),
          ),
        ],
      ),
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
      // child: ElevatedButton(
      //   onPressed: () {
      //     // Save theme settings
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('Theme settings saved successfully'),
      //         backgroundColor: Colors.green,
      //         behavior: SnackBarBehavior.floating,
      //       ),
      //     );
      //   },
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: colors4Liontent.primary,
      //     foregroundColor: Colors.white,
      //     padding: EdgeInsets.symmetric(vertical: 16),
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //   ),
      //   child: Text(
      //     'Save Changes',
      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      //   ),
      // ),
    );
  }
}
