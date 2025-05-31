// lib/views/widgets/show_tile.dart

import 'package:faculdadeextensao/modules/home/model/show.dart';
import 'package:flutter/material.dart';

/// A tile widget that displays a single [Show] summary and an “I’m Interested” button.
class ShowTile extends StatelessWidget {
  final Show show;
  final VoidCallback onPressed;

  const ShowTile({
    Key? key,
    required this.show,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormatted = '${show.date.day.toString().padLeft(2, '0')}/'
        '${show.date.month.toString().padLeft(2, '0')}/'
        '${show.date.year}';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              show.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            // Date
            Text(
              dateFormatted,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              show.description,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 12),

            // “I’m Interested” button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text('Confirm Interest'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
