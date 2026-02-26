import 'package:flutter/material.dart';
import '../care_services/care_services_section.dart';
import '../providers/top_providers_section.dart';
import '../offer/offer_banner.dart';
import '../care_services/care_services_listing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  
  final List<Map<String, dynamic>> caregivers = [
    {
      'name': 'Sarah Jenkins',
      'role': 'Certified Nurse',
      'experience': '8 Years Exp',
      'specialization': 'Elderly Care',
      'rating': 4.9,
      'reviews': 124,
      'hourlyRate': '₹25',
      'distance': '2.5 mi',
      'verified': true,
      'avatar': 'assets/images/provider1.png',
      'status': null,
      'available': true,
    },
    {
      'name': 'Emily Wilson',
      'role': 'Compassion Care',
      'experience': '4 Years Exp',
      'specialization': 'Elderly Care',
      'rating': 4.5,
      'reviews': 28,
      'hourlyRate': '₹19',
      'distance': '5.6 mi',
      'verified': true,
      'avatar': 'assets/images/provider4.png',
      'status': null,
      'available': true,
    },
  ];

  List<Map<String, dynamic>> get searchResults {
    if (_searchQuery.isEmpty) {
      return [];
    }
    return caregivers
        .where((c) =>
            c['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            c['specialization'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Location', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.teal, size: 18),
                SizedBox(width: 4),
                Text('San Francisco, CA', style: TextStyle(fontSize: 16, color: Colors.black)),
                Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 18),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications_none, color: Colors.black),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                ),
              ],
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 18,
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Trusted',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.teal, Colors.teal.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'Caregivers ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Required for ShaderMask
                          ),
                        ),
                      ),
                      Text(
                        'near you',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search caregivers or services...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              // Search Results
              if (searchResults.isNotEmpty) ...[
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE9ECEF)),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchResults.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                    itemBuilder: (context, index) {
                      final caregiver = searchResults[index];
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F6F3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.person, size: 20),
                        ),
                        title: Text(
                          caregiver['name'],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(caregiver['specialization']),
                        trailing: const Icon(Icons.arrow_forward,
                            size: 18, color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CaregiverListDetailScreen(
                                caregiver: caregiver,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
              SizedBox(height: 24),
              if (searchResults.isEmpty) ...[
                CareServicesSection(),
                SizedBox(height: 24),
                TopProvidersSection(),
                SizedBox(height: 24),
                OfferBanner(),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
