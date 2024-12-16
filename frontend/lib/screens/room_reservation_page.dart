import 'package:flutter/material.dart';
import 'ConfirmationPage.dart'; // Import the ConfirmationPage

class RoomReservationPage extends StatelessWidget {
  final Map<String, dynamic> room;

  const RoomReservationPage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Reservation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.orange.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Room Summary Section
                Container(
                  width: isWeb ? 600 : screenWidth * 0.9,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            room['images'][0],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room['type'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Price: ${room['price']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange.shade700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Availability: ${room['availability']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: room['availability'] == 'Available'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'You are about to reserve this room. Please review the details below and confirm your reservation.',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // User Details Section
                Container(
                  width: isWeb ? 600 : screenWidth * 0.9,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(Icons.person, 'Name:', 'John Doe'),
                          const Divider(),
                          _buildDetailRow(
                              Icons.email, 'Email:', 'john.doe@gmail.com'),
                          const Divider(),
                          _buildDetailRow(
                              Icons.phone, 'Phone:', '+123 456 789'),
                          const Divider(),
                          _buildDetailRow(Icons.location_on, 'Address:',
                              '123 Street, City'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Buttons Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to Confirmation Page with Room Details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationPage(
                              roomType: room['type'],
                              reservationId:
                                  'RSV${DateTime.now().millisecondsSinceEpoch}',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        backgroundColor: Colors.orange.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Cancel Action
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        side:
                            BorderSide(color: Colors.orange.shade700, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '$title $value',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
