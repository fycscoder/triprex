import 'package:flutter/material.dart';


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
      'image': 'hist.png',
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
      'description': 'Step back in time and explore iconic landmarks.',
      'image': 'romantic.jpg',
    },
    {
      'title': 'Luxury travel',
      'description': 'Experience the finest accommodations and services.',
      'image': 'honeymoon.jpg',
    },
    {
      'title': 'Weekend Joys',
      'description': '.',
      'image': 'weekend.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Categories'),
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
                child: Image.asset(
                  _categories[i]['image']!,
                  fit: BoxFit.cover,
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    _categories[i]['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    _categories[i]['description']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
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
                  padding: EdgeInsets.all(16),
                  child: Text(
                    '${category['title']}\n\n${category['description']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
