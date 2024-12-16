import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({Key? key}) : super(key: key);

  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // Variables to manage toggle states
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your notification preferences:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Email Notifications Toggle
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('Email Notifications'),
                subtitle: const Text('Receive updates via email.'),
                value: emailNotifications,
                activeColor: Colors.green, // Set active color to green
                onChanged: (bool value) {
                  setState(() {
                    emailNotifications = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            // Push Notifications Toggle
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Receive app notifications.'),
                value: pushNotifications,
                activeColor: Colors.green, // Set active color to green
                onChanged: (bool value) {
                  setState(() {
                    pushNotifications = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            // SMS Notifications Toggle
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text('SMS Notifications'),
                subtitle: const Text('Receive updates via SMS.'),
                value: smsNotifications,
                activeColor: Colors.green, // Set active color to green
                onChanged: (bool value) {
                  setState(() {
                    smsNotifications = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
