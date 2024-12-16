import 'package:flutter/material.dart';
import 'ConfirmationPage.dart';

class RoommateMatchingPage extends StatefulWidget {
  final List<Map<String, dynamic>> potentialRoommates = [
    {
      'name': 'Ali Ahmed',
      'age': 21,
      'interests': ['Reading', 'Sports'],
      'photo': 'assets/images/person1.jpg',
      'status': 'Available',
    },
    {
      'name': 'Sara Khalid',
      'age': 22,
      'interests': ['Movies', 'Cooking'],
      'photo': 'assets/images/person2.jpg',
      'status': 'Available',
    },
    {
      'name': 'Mohammed Ali',
      'age': 20,
      'interests': ['Gaming', 'Traveling'],
      'photo': 'assets/images/person2.jpg',
      'status': 'Matched',
    },
    {
      'name': 'Fatima Noor',
      'age': 23,
      'interests': ['Music', 'Art'],
      'photo': 'assets/images/person4.jpg',
      'status': 'Available',
    },
  ];

  final bool requiresRoommates;
  final Map<String, dynamic> selectedRoom; // Pass selected room details
  final VoidCallback onSkip;

  RoommateMatchingPage({
    Key? key,
    required this.requiresRoommates,
    required this.selectedRoom,
    required this.onSkip,
  }) : super(key: key);

  @override
  _RoommateMatchingPageState createState() => _RoommateMatchingPageState();
}

class _RoommateMatchingPageState extends State<RoommateMatchingPage> {
  List<Map<String, dynamic>> selectedRoommates = [];
  int requiredRoommates = 0;
  String? selectedInterest;
  List<Map<String, dynamic>> filteredRoommates = [];

  @override
  void initState() {
    super.initState();

    // Calculate the required number of roommates based on the room type
    final roomType = widget.selectedRoom['type'] ?? '';
    if (roomType.contains('2-Bed')) {
      requiredRoommates = 1; // Needs 1 roommate
    } else if (roomType.contains('3-Bed')) {
      requiredRoommates = 2; // Needs 2 roommates
    } else if (roomType.contains('4-Bed')) {
      requiredRoommates = 3; // Needs 3 roommates
    }

    // Initialize filteredRoommates
    filteredRoommates = List.from(widget.potentialRoommates);
  }

  void applyFilter(String interest) {
    setState(() {
      selectedInterest = interest;
      filteredRoommates = widget.potentialRoommates
          .where((roommate) =>
              roommate['interests'].contains(interest) ||
              selectedInterest == null)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Navigate directly to confirmation page if roommates aren't required
    if (!widget.requiresRoommates) {
      Future.microtask(() => widget.onSkip());
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roommate Matching'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.orange.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Page Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Find the Perfect Roommate',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Filter Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Filter by Interests',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      value: selectedInterest,
                      items: ['Sports', 'Movies', 'Gaming', 'Cooking', 'Art']
                          .map((interest) => DropdownMenuItem(
                                value: interest,
                                child: Text(interest),
                              ))
                          .toList(),
                      onChanged: (value) {
                        applyFilter(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedInterest = null;
                        filteredRoommates =
                            List.from(widget.potentialRoommates);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),

            // Note for the user
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'You need to select $requiredRoommates roommate(s) for this room.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Roommate List
            Expanded(
              child: ListView.builder(
                itemCount: filteredRoommates.length,
                itemBuilder: (context, index) {
                  final roommate = filteredRoommates[index];
                  return _buildRoommateCard(context, roommate);
                },
              ),
            ),

            // Next Button
            ElevatedButton(
              onPressed: selectedRoommates.length == requiredRoommates
                  ? () {
                      // Navigate to ConfirmationPage when selection is complete
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                            roomType: widget.selectedRoom['type'] ?? 'Room',
                            reservationId:
                                'R${DateTime.now().millisecondsSinceEpoch}',
                          ),
                        ),
                      );
                    }
                  : null, // Disable button until selection is complete
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                selectedRoommates.length == requiredRoommates
                    ? 'Next'
                    : 'Select $requiredRoommates roommate(s) to continue',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoommateCard(
      BuildContext context, Map<String, dynamic> roommate) {
    final isSelected = selectedRoommates.contains(roommate);

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(roommate['photo']),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roommate['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Age: ${roommate['age']}'),
                  Text('Interests: ${roommate['interests'].join(', ')}'),
                  Text(
                    'Status: ${roommate['status']}',
                    style: TextStyle(
                      color: roommate['status'] == 'Available'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            if (roommate['status'] == 'Available')
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedRoommates.remove(roommate);
                    } else if (selectedRoommates.length < requiredRoommates) {
                      selectedRoommates.add(roommate);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  isSelected ? 'Unmatch' : 'Match',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
