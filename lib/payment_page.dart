import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';


void _checkCameraPermission() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}


class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'Credit/Debit Card';
  String _selectedMonth = '01';
  String _selectedYear = '2024';
  String _cardNumber = '';
  String _cardHolderName = '';
  String _otp = '';
  String _upiId = '';
  String _qrCode = '';

  final List<String> _months = [
    '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'
  ];
  final List<String> _years = [
    '2024', '2025', '2026', '2027', '2028', '2029', '2030'
  ];

  Future<bool> processPayment() async {
    try {
      if (_paymentMethod == 'Credit/Debit Card') {
        final expiryDate = '$_selectedMonth/$_selectedYear';

        final response = await http.post(
          Uri.parse('https://your-payment-gateway-api.com/payments'),
          body: {
            'card_number': _cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), ''),
            'card_holder_name': _cardHolderName,
            'expiry_date': expiryDate,
            'otp': _otp,
            'amount': '10.00',
          },
        );

        if (response.statusCode == 200) {
          // Save payment details to Firestore
          await FirebaseFirestore.instance.collection('payments').add({
            'card_number': _cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), ''),
            'card_holder_name': _cardHolderName,
            'expiry_date': expiryDate,
            'otp': _otp,
            'amount': '10.00',
            'timestamp': Timestamp.now(),
          });

          return true;
        } else {
          return false;
        }
      } else if (_paymentMethod == 'UPI') {
        final response = await http.post(
          Uri.parse('https://your-upi-payment-api.com/payments'),
          body: {
            'upi_id': _upiId,
            'amount': '10.00',
          },
        );

        if (response.statusCode == 200) {
          // Save payment details to Firestore
          await FirebaseFirestore.instance.collection('payments').add({
            'upi_id': _upiId,
            'amount': '10.00',
            'timestamp': Timestamp.now(),
          });

          return true;
        } else {
          return false;
        }
      } else if (_paymentMethod == 'Google Pay') {
        // For Google Pay, you can assume the QR code contains payment information
        final response = await http.post(
          Uri.parse('https://your-google-pay-api.com/payments'),
          body: {
            'qr_code': _qrCode,
            'amount': '10.00',
          },
        );

        if (response.statusCode == 200) {
          // Save payment details to Firestore
          await FirebaseFirestore.instance.collection('payments').add({
            'qr_code': _qrCode,
            'amount': '10.00',
            'timestamp': Timestamp.now(),
          });

          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  void _startQRScanner() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRScannerPage()),
    );

    if (result != null) {
      setState(() {
        _qrCode = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Details
                Text(
                  'Payment Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Payment Method Selection
                        Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _paymentMethod = 'Credit/Debit Card';
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _paymentMethod == 'Credit/Debit Card' ? Colors.blue : Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('credit.png', width: 30),
                                      SizedBox(width: 10),
                                      Text('Credit/Debit Card'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _paymentMethod = 'UPI';
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _paymentMethod == 'UPI' ? Colors.blue : Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('upi.jpg', width: 30),
                                      SizedBox(width: 10),
                                      Text('UPI'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _paymentMethod = 'Google Pay';
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _paymentMethod == 'Google Pay' ? Colors.blue : Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('gpay.jpg', width: 30),
                                      SizedBox(width: 10),
                                      Text('Google Pay'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Payment Details Form
                        if (_paymentMethod == 'Credit/Debit Card') ...[
                          Text('Card Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Card Number',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.credit_card),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your card number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _cardNumber = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Card Holder Name',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the card holder name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _cardHolderName = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          Text('Expiry Date', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedMonth,
                                    items: _months.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedMonth = newValue!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.calendar_today),
                                      hintText: 'Month',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select expiry month';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedYear,
                                    items: _years.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedYear = newValue!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Year',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select expiry year';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'OTP',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the OTP';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _otp = value!;
                            },
                          ),
                        ] else if (_paymentMethod == 'UPI') ...[
                          Text('UPI Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'UPI ID',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.account_balance_wallet),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your UPI ID';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _upiId = value!;
                            },
                          ),
                        ] else if (_paymentMethod == 'Google Pay') ...[
                          Text('Google Pay Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _startQRScanner,
                            child: Text('Scan QR Code'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                          if (_qrCode.isNotEmpty) ...[
                            SizedBox(height: 10),
                            Text('QR Code: $_qrCode', style: TextStyle(fontSize: 16)),
                          ],
                        ],
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                // Process the payment
                                final isPaymentSuccessful = await processPayment();
                                if (isPaymentSuccessful) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Payment successful'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Payment failed'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text('Pay'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              textStyle: TextStyle(fontSize: 18),
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
      ),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isFrontCamera = false; // Track the current camera

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  void _toggleCamera() {
    if (controller != null) {
      controller!.flipCamera();
      setState(() {
        isFrontCamera = !isFrontCamera;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Center(
                  child: (result != null)
                      ? Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                      : Text('Scan a code'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _toggleCamera,
                  child: Text(isFrontCamera ? 'Switch to Back Camera' : 'Switch to Front Camera'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      Navigator.pop(context, scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}


