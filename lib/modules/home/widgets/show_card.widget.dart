// lib/modules/home/widgets/show_card_widget.dart (Create this file and directory if needed)
import 'package:faculdadeextensao/core/constants.dart';
import 'package:faculdadeextensao/modules/home/model/show.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowCardWidget extends StatelessWidget {
  final Show show;
  final VoidCallback onInterestedPressed;

  const ShowCardWidget({
    super.key,
    required this.show,
    required this.onInterestedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior:
          Clip.antiAlias, // Ensures image corners are rounded with card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AspectRatio(
          //   aspectRatio: 3 / 4,
          //   child: Image.network(
          //     // Use show.image if it's a full URL, otherwise placeholder
          //     Uri.tryParse(show.imageUrl)?.isAbsolute ?? false
          //         ? show.imageUrl
          //         : placeholderImageUrl,
          //     fit: BoxFit.cover,
          //     errorBuilder: (context, error, stackTrace) => const Center(
          //         child: Icon(Icons.broken_image, size: 50, color: gray600)),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        show.title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: gray400),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${DateFormat('dd/MM/yyyy').format(show.date)} 18:00',
                              style:
                                  const TextStyle(fontSize: 12, color: gray400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        show.description,
                        style: const TextStyle(fontSize: 13, color: gray300),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 14, color: gray400),
                          const SizedBox(width: 4),
                          Text(
                            '4 horas',
                            style:
                                const TextStyle(fontSize: 12, color: gray400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onInterestedPressed,
                      style: ElevatedButton.styleFrom(backgroundColor: rose600),
                      child: const Text("Estou Interessado"),
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
}
