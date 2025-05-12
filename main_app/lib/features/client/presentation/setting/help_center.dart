import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'How do I track my order?',
        'answer':
            'You can track your order from the "My Orders" section in your account.',
      },
      {
        'question': 'Can I return a product?',
        'answer': 'Yes, products can be returned within 14 days of delivery.',
      },
      {
        'question': 'How do I change my delivery address?',
        'answer':
            'Go to your profile settings and update your delivery address.',
      },
      {
        'question': 'Why is my order delayed?',
        'answer':
            'Delays can happen due to high demand or courier issues. Check your order status for updates.',
      },
      {
        'question': 'What payment methods are accepted?',
        'answer':
            'We accept credit cards, debit cards, PayPal, and cash on delivery in some regions.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // اللون الفخم
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = faqs[index];
          return AnimatedExpansionTile(
            question: item['question']!,
            answer: item['answer']!,
          );
        },
      ),
    );
  }
}

class AnimatedExpansionTile extends StatefulWidget {
  final String question;
  final String answer;

  const AnimatedExpansionTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  AnimatedExpansionTileState createState() => AnimatedExpansionTileState();
}

class AnimatedExpansionTileState extends State<AnimatedExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.blue[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color:
                  _isExpanded
                      ? Colors.blueAccent.withValues(alpha: 0.2)
                      : Colors.grey.withValues(alpha: 0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ExpansionTile(
          title: Text(
            widget.question,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: _isExpanded ? Colors.blueAccent : Colors.black,
            ),
          ),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8,
          ),
          onExpansionChanged: (bool expanding) {
            setState(() {
              _isExpanded = expanding;
            });
          },
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.answer,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
