import 'package:flutter/material.dart';
import 'book_flight_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _categories = [
    {
      'title': 'Adventure tours',
      'description': 'Explore thrilling landscapes and activities.',
      'image': 'inter.jpg',
    },
    {
      'title': 'Cultural tours',
      'description': 'Immerse yourself in local traditions and heritage.',
      'image': 'hist.jpg',
    },
    {
      'title': 'Wildlife safaris',
      'description': 'Experience the thrill of wildlife encounters.',
      'image': 'mount.jpg',
    },
    {
      'title': 'Beach getaways',
      'description': 'Relax on pristine shores and soak up the sun.',
      'image': 'beach.jpg',
    },
    {
      'title': 'Honeymoon tours',
      'description': 'Spend your precious moments with TripRex',
      'image': 'romantic.jpg',
    },
    {
      'title': 'Romantic',
      'description': 'Cherish your best and memorable memories.',
      'image': 'honeymoon.jpg',
    },
    {
      'title': 'Weekend Joys',
      'description': 'Plan a refreshing weekend trip to unwind and explore new horizons.',
      'image': 'weekend.jpg',
    },
    {
      'title': 'Luxury Travel',
      'description': 'Experience the finest accommodations and services.',
      'image': 'lux.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Categories'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _categories.length,
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                _showFullScreenDialog(context, _categories[i]);
              },
              child: GridTile(
                child: Stack(
                  children: [
                    Image.asset(
                      _categories[i]['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black54,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _categories[i]['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _categories[i]['description']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BookFlightPage(
                                      tourName: _categories[i]['title']!,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              ),
                              child: const Text(
                                'Book Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFullScreenDialog(BuildContext context, Map<String, String> category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(category['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${category['title']}\n\n${category['description']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
