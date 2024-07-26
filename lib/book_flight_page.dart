import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookFlightPage extends StatefulWidget {
  const BookFlightPage({super.key});

  @override
  State<BookFlightPage> createState() => _BookFlightPageState();
}

class _BookFlightPageState extends State<BookFlightPage> {
  bool isOneWay = true;
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(64, 147, 206, 1),
                  Color.fromRGBO(215, 234, 248, 1),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage('img1.jpg'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Book your flight',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOneWay
                              ? const Color.fromRGBO(64, 147, 206, 1)
                              : const Color.fromRGBO(215, 234, 248, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isOneWay = true;
                          });
                        },
                        child: Text(
                          'One way',
                          style: TextStyle(
                            fontSize: 14,
                            color: isOneWay ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isOneWay
                              ? const Color.fromRGBO(64, 147, 206, 1)
                              : const Color.fromRGBO(215, 234, 248, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isOneWay = false;
                          });
                        },
                        child: Text(
                          'Round Trip',
                          style: TextStyle(
                            fontSize: 14,
                            color: !isOneWay ? Colors.white : Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 308,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('From'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: fromController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Color.fromRGBO(224, 237, 246, 1),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('To'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: toController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Color.fromRGBO(224, 237, 246, 1),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Date'),
                      const SizedBox(height: 5),
                      TextField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Color.fromRGBO(224, 237, 246, 1),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(64, 147, 206, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            // Save to Firestore
                            FirebaseFirestore.instance.collection('flights').add({
                              'from': fromController.text,
                              'to': toController.text,
                              'date': dateController.text,
                              'isOneWay': isOneWay,
                              // Add more fields as needed
                            });
                          },
                          child: const Text(
                            'View Flights',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 400, // Adjust the height as needed
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('flights').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      var flights = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: flights.length,
                        itemBuilder: (context, index) {
                          var flight = flights[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              title: Text(
                                '${flight['from']} ➔ ${flight['to']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Text(
                                    'Date: ${flight['date']}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Trip Type: ${flight['isOneWay'] ? 'One Way' : 'Round Trip'}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
