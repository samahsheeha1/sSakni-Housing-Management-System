import 'package:flutter/material.dart';
import 'NotificationDetailsPage.dart';
import 'NotificationSettingsPage.dart';

class NotificationsListPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Application Approved',
      'message': 'Your application has been approved.',
      'date': '2023-12-09',
      'isRead': false,
    },
    {
      'title': 'New Update Available',
      'message': 'A new update is available for the app.',
      'date': '2023-12-01',
      'isRead': true,
    },
    {
      'title': 'Reminder',
      'message': 'Don’t forget to submit your documents.',
      'date': '2023-11-25',
      'isRead': false,
    },
  ];

  NotificationsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to NotificationSettingsPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                notification['isRead'] ? Icons.mark_email_read : Icons.email,
                color: notification['isRead'] ? Colors.green : Colors.orange,
              ),
              title: Text(
                notification['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                notification['message'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                notification['date'],
                style: const TextStyle(color: Colors.black54),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationDetailsPage(
                      title: notification['title'],
                      message: notification['message'],
                      date: notification['date'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
