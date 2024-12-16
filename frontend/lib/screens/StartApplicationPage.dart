import 'package:flutter/material.dart';

class StartApplicationPage extends StatelessWidget {
  const StartApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Application'),
        backgroundColor: Colors.orange,
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title Section
                const Text(
                  'Start Your Housing Application',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please fill out the details below to begin your application process.',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Form Section
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: isWeb ? 500 : screenWidth * 0.9,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildTextField(
                          label: "Full Name",
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          label: "Student ID",
                          icon: Icons.badge,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          label: "Contact Number",
                          icon: Icons.phone,
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          label: "Email Address",
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 15),

                        // Dropdown for Preferred Room Type
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Preferred Room Type",
                            labelStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIcon: Icon(Icons.room_preferences,
                                color: Colors.orange),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            filled: true,
                            fillColor: Colors.orange.shade50,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Colors.orange.shade600,
                                width: 2,
                              ),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: "Single Room",
                              child: Text("Single Room"),
                            ),
                            DropdownMenuItem(
                              value: "Double Room",
                              child: Text("Double Room"),
                            ),
                            DropdownMenuItem(
                              value: "Suite",
                              child: Text("Suite"),
                            ),
                          ],
                          onChanged: (value) {
                            // Handle room type selection
                          },
                          style: const TextStyle(color: Colors.black),
                          dropdownColor: Colors.orange.shade50,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Next Steps Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to UploadDocumentsPage
                    Navigator.pushNamed(context, '/uploadDocuments');
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
                    'Next Step',
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
      ),
    );
  }

  // Helper Function to Build Text Fields
  Widget _buildTextField({required String label, required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: Colors.orange),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        filled: true,
        fillColor: Colors.orange.shade50,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.orange.shade600, width: 2),
        ),
      ),
    );
  }
}
