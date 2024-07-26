import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Triprex'),
        backgroundColor: Color.fromARGB(255, 204, 247, 255),
      ),
      body: Stack(
        children: [
          // Tricolored background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.33, 0.66, 1.0],
                ),
              ),
            ),
          ),
          // Content with gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black26, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Welcome to Triprex',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildCurvedBox(
                        'Triprex is a travel agency and tour booking platform designed to provide a seamless and stress-free experience for travelers. Our mission is to ensure that every trip is a memorable one, and we strive to achieve this by prioritizing safety, trust, and expertise.',
                      ),
                      SizedBox(height: 20),
                      _buildFeatureSection(),
                      SizedBox(height: 20),
                      _buildCurvedBox(
                        'Why Choose Triprex?\n\nAt Triprex, we understand that every traveler has unique needs and preferences. That\'s why we offer a range of services designed to cater to your specific requirements. From visa applications to hotel bookings, transportation rentals, and tour activities, we have everything you need to make your trip unforgettable.',
                      ),
                      SizedBox(height: 20),
                      _buildCurvedBox(
                        'Tour and Travel Highlights:',
                        isTitle: true,
                      ),
                      SizedBox(height: 10),
                      _buildHighlightsSection(),
                      SizedBox(height: 20),
                      _buildCurvedBox(
                        'Previous Tours:',
                        isTitle: true,
                      ),
                      SizedBox(height: 10),
                      _buildTourSection('Lonavala', 'img4.jpg', 'Explore the beautiful hills and enjoy the serene environment of Lonavala. Perfect for a quick getaway.'),
                      SizedBox(height: 10),
                      _buildTourSection('Agra', 'agra.jpg', 'Visit the iconic Taj Mahal and experience the rich history and culture of Agra.'),
                      SizedBox(height: 10),
                      _buildTourSection('Maldives', 'beach.jpg', 'Relax on the pristine beaches of the Maldives and enjoy luxury resorts and crystal-clear waters.'),
                      SizedBox(height: 10),
                      _buildTourSection('Greece', 'img5.jpg', 'Discover the ancient ruins and stunning islands of Greece, a perfect blend of history and beauty.'),
                      SizedBox(height: 10),
                      _buildTourSection('Dubai', 'img9.jpg', 'Experience the futuristic city of Dubai, with its towering skyscrapers, luxurious shopping, and vibrant nightlife.'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurvedBox(String text, {bool isTitle = false}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isTitle ? 22 : 18,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
          color: Colors.black,
        ),
        textAlign: isTitle ? TextAlign.center : TextAlign.justify,
      ),
    );
  }

  Widget _buildFeatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Safety First',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_user, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Trusted Travel Guide',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Expertise and Experience',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mood, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Stress Relief',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighlightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBulletPoint('Customized travel packages for all types of travelers'),
        _buildBulletPoint('24/7 customer support to assist you at any time'),
        _buildBulletPoint('Best price guarantee on all bookings'),
        _buildBulletPoint('Special deals and discounts for members'),
        _buildBulletPoint('Expert travel advice and tips to make the most of your trip'),
        _buildBulletPoint('Comprehensive travel insurance options'),
        _buildBulletPoint('Eco-friendly and sustainable travel options'),
        _buildBulletPoint('Group tours with experienced guides'),
        _buildBulletPoint('Hassle-free visa and travel documentation services'),
        _buildBulletPoint('Wide range of destinations to choose from'),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 18, color: Colors.white)),
        Expanded(child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white))),
      ],
    );
  }

  Widget _buildTourSection(String title, String imagePath, String description) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
