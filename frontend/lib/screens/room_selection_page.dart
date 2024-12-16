import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'roommate_matching.dart';
import 'room_reservation_page.dart';
import 'room_details_page.dart';

class RoomSelectionPage extends StatefulWidget {
  const RoomSelectionPage({Key? key}) : super(key: key);

  @override
  _RoomSelectionPageState createState() => _RoomSelectionPageState();
}

class _RoomSelectionPageState extends State<RoomSelectionPage> {
  final List<Map<String, dynamic>> rooms = [
    {
      'type': 'Single Room',
      'price': '\$300/month',
      'availability': 'Available',
      'images': [
        'assets/images/room1_1.jpg',
        'assets/images/room1_2.jpg',
        'assets/images/room1_3.jpg',
      ],
    },
    {
      'type': 'Double Room',
      'price': '\$500/month',
      'availability': 'Only 1 left',
      'images': [
        'assets/images/room2_1.jpg',
        'assets/images/room2_2.jpg',
      ],
    },
    {
      'type': 'Suite',
      'price': '\$800/month',
      'availability': 'Available',
      'images': [
        'assets/images/room3_1.jpg',
        'assets/images/room3_2.jpg',
        'assets/images/room3_3.jpg',
      ],
    },
    {
      'type': 'Three-Bed Room',
      'price': '\$900/month',
      'availability': 'Few left',
      'images': [
        'assets/images/room1_1.jpg',
        'assets/images/room1_2.jpg',
        'assets/images/room1_3.jpg',
      ],
    },
    {
      'type': 'Four-Bed Room',
      'price': '\$1100/month',
      'availability': 'Available',
      'images': [
        'assets/images/room1_1.jpg',
        'assets/images/room1_2.jpg',
        'assets/images/room1_3.jpg',
      ],
    },
    {
      'type': 'Five-Bed Room',
      'price': '\$1300/month',
      'availability': 'Available',
      'images': [
        'assets/images/room2_1.jpg',
        'assets/images/room2_2.jpg',
        'assets/images/room2_3.jpg',
      ],
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    // Filtered rooms based on search query
    final filteredRooms = rooms
        .where((room) =>
            room['type'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Selection'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.orange.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Select Your Room',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Search Bar
              Center(
                child: Container(
                  width: isWeb ? 400 : screenWidth * 0.9,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by room type...',
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.orange),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Room Cards
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWeb ? 3 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isWeb ? 1 : 1, // Square images for mobile
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredRooms.length,
                itemBuilder: (context, index) {
                  final room = filteredRooms[index];
                  return RoomCard(
                    room: room,
                    onDetailsPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetailsPage(room: room),
                        ),
                      );
                    },
                    onSelectPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoommateMatchingPage(
                            requiresRoommates: room['type'] != 'Single Room',
                            onSkip: () {
                              Navigator.pop(context); // Close Roommate Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RoomReservationPage(room: room),
                                ),
                              );
                            },
                            selectedRoom: {},
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Map<String, dynamic> room;
  final VoidCallback onDetailsPressed;
  final VoidCallback onSelectPressed;

  const RoomCard({
    Key? key,
    required this.room,
    required this.onDetailsPressed,
    required this.onSelectPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider for Room Images
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  aspectRatio: 1.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 1.0,
                ),
                items: room['images'].map<Widget>((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              room['type'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              room['price'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Availability: ${room['availability']}',
              style: TextStyle(
                fontSize: 12,
                color: room['availability'] == 'Available'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onSelectPressed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Select',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                OutlinedButton(
                  onPressed: onDetailsPressed,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    side: BorderSide(color: Colors.orange.shade700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
