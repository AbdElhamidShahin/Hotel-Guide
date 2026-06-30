import 'package:flutter/material.dart';
import '../../data/chat_message.dart';

class HotelCardWidget extends StatelessWidget {
  final HotelCard hotel;
  const HotelCardWidget({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: screenWidth * 0.80,
        margin: const EdgeInsets.only(bottom: 12, left: 12, right: 16),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isLight
                  ? Colors.black.withOpacity(0.08)
                  : Colors.transparent,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: isLight ? null : Border.all(color: cs.outline, width: 0.5),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 12,
              child: Icon(
                Icons.chevron_left,
                color: cs.onSurfaceVariant,
                size: 20,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hotel.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hotel.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 12, color: cs.surfaceTint),
                    ),
                    if (hotel.price != null)
                      Text(
                        'من ${hotel.price!.toStringAsFixed(0)} جنيه / ليلة',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1F3C),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            _buildImage(context, hotel.imageUrl),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String url) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: url.isNotEmpty
          ? Image.network(url, width: 90, height: 90, fit: BoxFit.cover)
          : Container(
              width: 90,
              height: 90,
              color: cs.surfaceContainerHighest,
              child: Icon(Icons.hotel, color: cs.onSurfaceVariant),
            ),
    );
  }
}
