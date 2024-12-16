import 'package:flutter/material.dart';
import 'ApplicationDetailsPage.dart';

class ApplicationStatusPage extends StatelessWidget {
  final List<Map<String, dynamic>> applications = [
    {
      'id': 'APP12345',
      'date': '2023-12-09',
      'status': 'Pending',
    },
    {
      'id': 'APP67890',
      'date': '2023-11-25',
      'status': 'Approved',
    },
    {
      'id': 'APP11223',
      'date': '2023-11-15',
      'status': 'Rejected',
    },
  ];

  ApplicationStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Applications'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final application = applications[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                application['status'] == 'Approved'
                    ? Icons.check_circle
                    : application['status'] == 'Rejected'
                        ? Icons.cancel
                        : Icons.hourglass_empty,
                color: application['status'] == 'Approved'
                    ? Colors.green
                    : application['status'] == 'Rejected'
                        ? Colors.red
                        : Colors.orange,
              ),
              title: Text('Application ID: ${application['id']}'),
              subtitle: Text('Date: ${application['date']}'),
              trailing: Text(
                application['status'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: application['status'] == 'Approved'
                      ? Colors.green
                      : application['status'] == 'Rejected'
                          ? Colors.red
                          : Colors.orange,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicationDetailsPage(
                      applicationId: application['id'],
                      status: application['status'],
                      date: application['date'],
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
