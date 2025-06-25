import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';

class SecuritySettings extends StatelessWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 20),
          title: Text(
            'Security Settings',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: colors4Liontent.primary,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Make your account more secure',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Setup multifactor authentication and monitor all your active sessions',
                ),
              ),

              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.lock, size: 20),
                title: Text('Change Password'),
                subtitle: Text('Update your password'),
                trailing: Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {
                  // Handle change password action
                },
              ),

              ListTile(
                leading: Icon(Icons.security, size: 20),
                title: Text('Two-Factor Authentication'),
                subtitle: Text('Enable or disable 2FA'),
                trailing: Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {
                  // Handle 2FA action
                },
              ),

              ListTile(
                leading: Icon(Icons.devices, size: 20),
                title: Text('Active Sessions'),
                subtitle: Text('View all devices where you are logged in'),
                trailing: Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {
                  // Handle logout action
                },
              ),

              ListTile(
                leading: Icon(Icons.delete_forever_outlined, size: 20),
                title: Text('Delete my account'),

                trailing: Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {
                  // Handle logout action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
