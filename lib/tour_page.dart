import 'package:flutter/material.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});

  @override
  TourPageState createState() => TourPageState();
}

class TourPageState extends State<TourPage> {
  final List<String> _images = [
    'tour2.png', 
    'agra.jpg',
    'beach.jpg',
    'img3.jpg',
    'img4.jpg',
    'img5.jpg',
    'new_york.jpg',
    'norway.jpg',
    'sidney.jpg',
    'town.jpg',
    'temple.jpg'
  ];

  final List<String> _descriptions = [
    'Fuel your soul with TripRex', 
    'Taj Mahal, Agra, India',
    'Tropical beach, Maldives',
    'Colorful houses, Burano, Italy',
    'Machu Picchu, Peru',
    'Santorini, Greece',
    'Central Park, New York City, USA',
    'Fjords, Norway',
    'Opera House, Sydney, Australia',
    'Colmar, France',
    'Temple, China',
  ];

  int _currentIndex = 0;

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _images.length) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore the World',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(83, 33, 149, 243),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    'back.jpg', // Replace with your background image path
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(47, 68, 137, 255).withOpacity(0.7),
                          Color.fromARGB(61, 64, 195, 255).withOpacity(0.7)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 800), // Increased max width
                    padding: EdgeInsets.all(30), // Increased padding
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 15.0,
                          spreadRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Spark Your Wanderlust: ',
                                style: TextStyle(
                                  fontSize: constraints.maxWidth > 600 ? 24 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              TextSpan(
                                text: 'Explore Breathtaking Destinations',
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            _images[_currentIndex],
                            width: constraints.maxWidth > 600 ? 500 : 300, // Increased width
                            height: constraints.maxWidth > 600 ? 300 : 200, // Increased height
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          _descriptions[_currentIndex],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: _previousImage,
                              color: Colors.blue,
                              iconSize: 30,
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: _nextImage,
                              color: Colors.blue,
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
