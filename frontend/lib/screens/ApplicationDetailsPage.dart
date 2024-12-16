import 'package:flutter/material.dart';

class ApplicationDetailsPage extends StatelessWidget {
  final String applicationId;
  final String status;
  final String date;

  const ApplicationDetailsPage({
    Key? key,
    required this.applicationId,
    required this.status,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width:
              MediaQuery.of(context).size.width > 600 ? 500 : double.infinity,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  status == 'Approved'
                      ? Icons.check_circle
                      : status == 'Rejected'
                          ? Icons.cancel
                          : Icons.hourglass_empty,
                  size: 80,
                  color: status == 'Approved'
                      ? Colors.green
                      : status == 'Rejected'
                          ? Colors.red
                          : Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow(
                  Icons.assignment, 'Application ID:', applicationId),
              const SizedBox(height: 10),
              _buildDetailRow(Icons.date_range, 'Date Submitted:', date),
              const SizedBox(height: 10),
              _buildDetailRow(
                Icons.info_outline,
                'Status:',
                status,
                color: status == 'Approved'
                    ? Colors.green
                    : status == 'Rejected'
                        ? Colors.red
                        : Colors.orange,
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text(
                    'Back to Applications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value,
      {Color color = Colors.black87}) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange.shade700),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }
}
