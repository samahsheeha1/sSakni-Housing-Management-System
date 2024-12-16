import 'package:flutter/material.dart';
import 'dart:math';

class ConfirmationPage extends StatelessWidget {
  final String roomType;
  final String reservationId;

  const ConfirmationPage({
    Key? key,
    required this.roomType,
    required this.reservationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Confirmed'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Animated Balloons Background
          const AnimatedBalloonBackground(),
          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Reservation Successful!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your reservation for a $roomType has been confirmed.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: isWeb ? 400 : screenWidth * 0.9,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow(
                            title: 'Reservation ID:',
                            value: reservationId,
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(
                            title: 'Room Type:',
                            value: roomType,
                          ),
                          const SizedBox(height: 10),
                          _buildDetailRow(
                            title: 'Status:',
                            value: 'Confirmed',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                      backgroundColor: Colors.orange.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Go to Dashboard',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Animated Balloons Background Widget
class AnimatedBalloonBackground extends StatelessWidget {
  const AnimatedBalloonBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(20, (index) {
        final random = Random();
        final startDelay = random.nextInt(5);
        final duration = random.nextInt(5) + 5;

        return Positioned(
          bottom: random.nextDouble() * MediaQuery.of(context).size.height,
          left: random.nextDouble() * MediaQuery.of(context).size.width,
          child: AnimatedBalloon(
            delay: Duration(seconds: startDelay),
            duration: Duration(seconds: duration),
          ),
        );
      }),
    );
  }
}

class AnimatedBalloon extends StatefulWidget {
  final Duration delay;
  final Duration duration;

  const AnimatedBalloon({
    Key? key,
    required this.delay,
    required this.duration,
  }) : super(key: key);

  @override
  State<AnimatedBalloon> createState() => _AnimatedBalloonState();
}

class _AnimatedBalloonState extends State<AnimatedBalloon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() {
        if (_controller.status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });

    _animation = Tween<double>(begin: 1.0, end: -0.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset:
              Offset(0, _animation.value * MediaQuery.of(context).size.height),
          child: child,
        );
      },
      child: Icon(
        Icons.circle,
        size: Random().nextDouble() * 30 + 20, // Random size
        color: Colors.orangeAccent.withOpacity(0.5),
      ),
    );
  }
}
