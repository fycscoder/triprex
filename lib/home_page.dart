import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<String> _imagePaths = [
    'inter.jpg',
    'weekend.jpg',
    'beach.jpg',
    'mount.jpg',
    'romantic.jpg',
    'honeymoon.jpg',
  ];
  final List<String> _captions = [
    'Explore the world with our international tours.',
    'Relax and unwind with our weekend getaways.',
    'Escape to our beach destinations for a relaxing vacation.',
    'Challenge yourself with our mountain treks and adventures.',
    'Create unforgettable memories with our romantic getaways.',
    'Start your new life together with our honeymoon packages.',
  ];
  int _currentIndex = 0;
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _imagePaths.length;
      });
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _showFullScreenDialog() {
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
                  image: AssetImage(_imagePaths[_currentIndex]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    _captions[_currentIndex],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _showFullScreenDialog,
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
                    colors: [Color.fromARGB(6, 68, 137, 255).withOpacity(0.7), Colors.lightBlueAccent.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome to your Travel Companion!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                            text: '\n\nPlan your dream vacation with ease.',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ScaleTransition(
                      scale: _animation,
                      child: Image.asset(
                        _imagePaths[_currentIndex],
                        height: 200,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        _captions[_currentIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
