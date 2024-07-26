import 'package:flutter/material.dart';

class TourPage extends StatefulWidget {
  const TourPage({Key? key}) : super(key: key);

  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  final List<String> _images = [
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
          return Stack(
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
                      colors: [Color.fromARGB(47, 68, 137, 255).withOpacity(0.7), Color.fromARGB(61, 64, 195, 255).withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600), // Example max width
                  padding: EdgeInsets.all(20),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Man asking questions
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'tour.png',
                            width: constraints.maxWidth > 400 ? 150 : 100,
                            height: constraints.maxWidth > 400 ? 300 : 200,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
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
                                      fontSize: constraints.maxWidth > 400 ? 24 : 20,
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
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              child: ClipRRect(
                                key: ValueKey(_currentIndex),
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  _images[_currentIndex],
                                  width: constraints.maxWidth > 400 ? 300 : 200,
                                  height: constraints.maxWidth > 400 ? 200 : 150,
                                  fit: BoxFit.cover,
                                ),
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
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_currentIndex > 0) {
                                        _currentIndex--;
                                      }
                                    });
                                  },
                                  child: Text('Previous'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_currentIndex < _images.length - 1) {
                                        _currentIndex++;
                                      }
                                    });
                                  },
                                  child: Text('Next'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
