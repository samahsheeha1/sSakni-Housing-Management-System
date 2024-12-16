import 'package:flutter/material.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({Key? key}) : super(key: key);

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How can I reset my password?',
      'answer': 'Click on "Forgot Password" on the login page.',
    },
    {
      'question': 'What documents are required?',
      'answer': 'University ID and proof of registration are needed.',
    },
    {
      'question': 'Can I update my application?',
      'answer': 'Yes, before the deadline, you can make updates.',
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredFAQs = faqs
        .where((faq) =>
            faq['question']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search FAQs...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredFAQs.isEmpty
                ? const Center(child: Text('No FAQs found.'))
                : ListView.builder(
                    itemCount: filteredFAQs.length,
                    itemBuilder: (context, index) {
                      final faq = filteredFAQs[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          title: Text(faq['question']!),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(faq['answer']!),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
