import 'package:flutter/material.dart';
import 'custom_service_details.dart';

class CustomServiceDetailsListView extends StatelessWidget {
  const CustomServiceDetailsListView({super.key});

  @override
  Widget build(BuildContext context) {
    // onSurfaceVariant = secondary icon colour — adapts in dark mode.
    final iconColor = Theme.of(context).colorScheme.onSurfaceVariant;

    final List<Map<String, dynamic>> services = [
      {'text': '4.8', 'icon': Icons.star, 'color': Colors.amber},
      {'text': 'واي فاي مجاني', 'icon': Icons.wifi, 'color': iconColor},
      {'text': 'وجبة إفطار مجانية', 'icon': Icons.coffee_outlined, 'color': iconColor},
    ];

    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = services[index];
          return CustomServiceDetails(
            text: item['text'],
            icon: item['icon'],
            iconColor: item['color'],
          );
        },
      ),
    );
  }
}
