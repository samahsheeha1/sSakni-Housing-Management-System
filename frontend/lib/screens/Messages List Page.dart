import 'package:flutter/material.dart';
import 'ChatScreen.dart'; // Import ChatScreen

class MessagesListPage extends StatelessWidget {
  final List<Map<String, dynamic>> contacts = [
    {
      'name': 'Housing Admin',
      'lastMessage': 'Your request has been approved!',
      'time': '10:30 AM',
      'isRead': false,
    },
    {
      'name': 'Student Affairs',
      'lastMessage': 'Please provide your documents.',
      'time': 'Yesterday',
      'isRead': true,
    },
    {
      'name': 'Roommate - Sara',
      'lastMessage': 'Looking forward to moving in!',
      'time': '2 days ago',
      'isRead': false,
    },
  ];

  MessagesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade700,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                contact['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: contact['isRead'] ? Colors.black54 : Colors.black,
                ),
              ),
              subtitle: Text(
                contact['lastMessage'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54),
              ),
              trailing: Text(
                contact['time'],
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(contactName: contact['name']),
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
