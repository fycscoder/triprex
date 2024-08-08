import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _rating = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to save feedback to Firestore
  Future<void> _sendFeedback(String feedbackText, int rating) async {
    try {
      await _firestore.collection('feedback').add({
        'feedback': feedbackText,
        'rating': rating,
        'timestamp': Timestamp.now(),
      });
      // Feedback successfully saved
      Navigator.pop(context);
    } catch (e) {
      // Handle errors
      print('Error sending feedback: $e');
      // Optionally show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'feed.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Dialog(
              child: Container(
                color: Colors.white.withOpacity(0.8), // Overlay to make content readable
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Provide Your Feedback',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: 'Enter your feedback here',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            maxLines: 5,
                            maxLength: 4096,
                            textInputAction: TextInputAction.newline,
                            validator: (String? text) {
                              if (text == null || text.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Rate the app',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                icon: Icon(
                                  index < _rating ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                ),
                                onPressed: () => _setRating(index + 1),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text(
                            'Send',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String feedbackText = _controller.text.trim();
                              await _sendFeedback(feedbackText, _rating);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
