import 'package:flutter/material.dart';
import 'caregiver_profile_screen.dart';

class TopProvidersSection extends StatefulWidget {
  final List<Map<String, dynamic>> providers;
  final void Function(int)? onBookNow;

  const TopProvidersSection({
    super.key,
    this.providers = const [
      {
        'name': 'Sarah Jenkins',
        'role': 'RN · Elderly Care Specialist',
        'rating': 4.9,
        'reviews': 124,
        'experience': '5 Yrs Exp.',
        'rate': '25/hr',
        'avatar': 'assets/images/provider1.png',
        'verified': true,
      },
      {
        'name': 'Jane Smith',
        'role': 'RN · Patient Care',
        'rating': 4.8,
        'reviews': 98,
        'experience': '7 Yrs Exp.',
        'rate': '28/hr',
        'avatar': 'assets/images/provider2.png',
        'verified': false,
      },
    ],
    this.onBookNow,
  });

  @override
  State<TopProvidersSection> createState() => _TopProvidersSectionState();
}

class _TopProvidersSectionState extends State<TopProvidersSection> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (index < 0 || index >= widget.providers.length) return;

    setState(() {
      _currentIndex = index;
    });

    // Scroll to the provider card (340 width + 16 padding)
    final double itemWidth = 356; // 340 + 16
    _scrollController.animateTo(
      index * itemWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final providers = widget.providers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Top Care Providers', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                  onPressed: _currentIndex > 0 ? () => _scrollToIndex(_currentIndex - 1) : null,
                  splashRadius: 24,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.black, size: 28),
                  onPressed: _currentIndex < providers.length - 1 ? () => _scrollToIndex(_currentIndex + 1) : null,
                  splashRadius: 24,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 350, // Increased height to prevent overflow
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: providers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildProviderCard(providers[index], index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider, int index) {
    return Container(
      key: ValueKey(provider['name']),
      width: 340,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE9ECEF), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      provider['avatar'],
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 70,
                        height: 70,
                        color: const Color(0xFFE6F6F3),
                      ),
                    ),
                  ),
                  if (provider['verified'])
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(Icons.verified, color: Color(0xFF3B82F6), size: 22),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    const SizedBox(height: 4),
                    Text(provider['role'], style: const TextStyle(color: Color(0xFF3BCEAC), fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFC107), size: 22),
              const SizedBox(width: 6),
              Text('${provider['rating']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(width: 6),
              Text('(${provider['reviews']} reviews)', style: const TextStyle(color: Color(0xFF6B7280), fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFE9ECEF), thickness: 1.2),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.work, size: 20, color: Color(0xFF6B7280)),
              const SizedBox(width: 8),
              Text('${provider['experience']}', style: const TextStyle(fontSize: 16, color: Color(0xFF111827))),
              const SizedBox(width: 18),
              const Icon(Icons.attach_money, size: 20, color: Color(0xFF6B7280)),
              const SizedBox(width: 8),
              Text('${provider['rate']}', style: const TextStyle(fontSize: 16, color: Color(0xFF111827))),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2DE1C2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      widget.onBookNow?.call(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaregiverProfileScreen(provider: provider),
                        ),
                      );
                    },
                    child: const Text('Book Now', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE9ECEF), width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF111827), size: 28),
                  onPressed: () {},
                  splashRadius: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
