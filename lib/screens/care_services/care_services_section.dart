import 'package:flutter/material.dart';
import 'care_services_listing_screen.dart';

class CareServicesSection extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final void Function(int)? onServiceTap;

  const CareServicesSection({
    super.key,
    this.services = const [
      {'icon': Icons.elderly, 'label': 'Elderly Care', 'color': Color(0xFF00C897)},
      {'icon': Icons.medical_services, 'label': 'Patient Care', 'color': Color(0xFF4D8DFF)},
      {'icon': Icons.healing, 'label': 'Post Surgery', 'color': Color(0xFFFF6B6B)},
      {'icon': Icons.accessible, 'label': 'Disability Care', 'color': Color(0xFFB388FF)},
    ],
    this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Care Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CareServicesListingScreen(),
                  ),
                );
              },
              child: Text('See all', style: TextStyle(color: Colors.teal)),
            ),
          ],
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final service = services[index];
              return GestureDetector(
                onTap: () {
                  onServiceTap?.call(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CareServicesListingScreen(
                        selectedService: service['label'],
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: service['color'].withValues(alpha: 0.1),
                      child: Icon(service['icon'], color: service['color'], size: 32),
                    ),
                    SizedBox(height: 8),
                    Text(service['label'], style: TextStyle(fontSize: 14)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
