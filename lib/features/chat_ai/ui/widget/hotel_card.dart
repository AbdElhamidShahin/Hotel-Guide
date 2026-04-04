import 'package:flutter/material.dart';

import '../../data/chat_message.dart';

class HotelCardWidget extends StatelessWidget {
  final HotelCard hotel;
  const HotelCardWidget({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12, child: Icon(Icons.chevron_left, color: Colors.black38, size: 20)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(hotel.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(hotel.description, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey), textDirection: TextDirection.rtl),
                  if (hotel.price != null)
                    Text('من ${hotel.price!.toStringAsFixed(0)} جنيه / ليلة',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1A1F3C))),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          _buildImage(hotel.imageUrl),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
      child: url.isNotEmpty
          ? Image.network(url, width: 90, height: 90, fit: BoxFit.cover)
          : Container(width: 90, height: 90, color: Colors.grey[200], child: const Icon(Icons.hotel)),
    );
  }
}