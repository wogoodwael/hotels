import 'package:flutter/material.dart';

import 'widgets/recent_search_item.dart';
import 'widgets/recommended_card.dart';
import 'widgets/search_row.dart';

class SearchHotelsPage extends StatelessWidget {
  const SearchHotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: SearchRow(),
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Icon(Icons.location_on_outlined)),
              title: const Text('Search place nearby',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: const Text('Current location • Maps',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recently Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  RecentSearchItem(
                    title: 'Sihanouk Ville, Cambodia',
                    icon: Icons.access_time_outlined,
                  ),
                  RecentSearchItem(
                    title: 'Okinawa, Japan',
                    icon: Icons.access_time_outlined,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        RecommendedCard(
                          title: 'Long-Tail Boat Charter',
                          rating: '5.0',
                          reviews: '100 reviews',
                          description: 'Lorem ipsum dolor sit amet..',
                          imageUrl:
                              'https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b',
                        ),
                        SizedBox(width: 16),
                        RecommendedCard(
                          title: 'Koh Rong Samloem',
                          rating: '4.8',
                          reviews: '100 reviews',
                          description: 'Lorem ipsum dolor sit alme',
                          imageUrl:
                              'https://images.unsplash.com/photo-1520454974749-611b7248ffdb',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
