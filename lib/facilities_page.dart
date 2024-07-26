import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FacilitiesPage extends StatefulWidget {
  const FacilitiesPage({super.key});

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  final List<Facility> facilities = [
    Facility(icon: Icons.pool, name: 'Swimming', url: 'https://www.instagram.com/reel/C9R3-HdND6Z/?igsh=cjRpbThxeXUzbnpt'),
    Facility(icon: Icons.restaurant, name: 'Dining', url: 'https://youtube.com/shorts/OdlZzw2nJvk?si=P9CqmH2QToCwA2zi'),
    Facility(icon: Icons.directions_car, name: 'Transport', url: 'https://youtube.com/shorts/rJHrpoCp2gU?si=jW8r3IfP6xOU6TrZ'),
    Facility(icon: Icons.directions_bike, name: 'Riding', url: 'https://www.instagram.com/reel/CY2MHaKAO_Y/?igsh=am9jeTRhc3ZlNWFm'),
    Facility(icon: Icons.free_breakfast, name: 'Breakfast', url: 'https://youtube.com/shorts/Q57HVZ-TlyU?si=jj1PUGBdl7JVkw5Z'),
    Facility(icon: Icons.bed, name: 'Bedroom', url: 'https://youtube.com/shorts/KzqTLO-RvGU?si=W-U9fY9xB87AV4a3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facilities'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine number of columns based on screen width
          int columns = (constraints.maxWidth > 600) ? 3 : 2;

          return GridView.builder(
            padding: EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.0,
            ),
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              return FacilityCard(facility: facilities[index]);
            },
          );
        },
      ),
    );
  }
}

class Facility {
  final IconData icon;
  final String name;
  final String url;

  Facility({required this.icon, required this.name, required this.url});
}

class FacilityCard extends StatelessWidget {
  final Facility facility;

  FacilityCard({required this.facility});

  Future<void> _launchURL() async {
    if (await canLaunch(facility.url)) {
      await launch(facility.url);
    } else {
      throw 'Could not launch ${facility.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine icon size and text size based on screen width
    double iconSize = MediaQuery.of(context).size.width > 600 ? 60.0 : 50.0;
    double textSize = MediaQuery.of(context).size.width > 600 ? 18.0 : 16.0;

    return InkWell(
      onTap: _launchURL,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              facility.icon,
              size: iconSize,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 16.0),
            Text(
              facility.name,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
