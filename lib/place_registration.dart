import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PlaceRegistrationScreen extends StatefulWidget {
  @override
  _PlaceRegistrationScreenState createState() =>
      _PlaceRegistrationScreenState();
}

class _PlaceRegistrationScreenState extends State<PlaceRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedCountry = 'Select Country';
  String selectedState = 'Select State';
  var _isSending = false;

  // Add a list of countries and states
  final List<String> countries = ['Select Country', 'Malaysia', 'Other'];
  final Map<String, List<String>> stateMap = {
    'Malaysia': [
      'Johor', 'Kedah', 'Kelantan', 'Melaka', 'Negeri Sembilan',
      'Pahang', 'Pulau Pinang', 'Perak', 'Perlis', 'Selangor', 'Terengganu',
      'Sabah', 'Sarawak', 'Kuala Lumpur', 'Labuan', 'Putrajaya',
    ],
    'Other': ['Not Available'],
  };

  // Function to build dropdown items
  List<DropdownMenuItem<String>> buildDropdownItems(List<String> items) {
    return items.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList();
  }

  Future<void> _placeregistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();

      if (selectedCountry != 'Select Country' &&
          selectedState != 'Select State') {
        try {
          final url = Uri.https(
            'smart-planner-travel-app-default-rtdb.asia-southeast1.firebasedatabase.app',
            'places.json',
          );

          final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'country': selectedCountry,
              'state': selectedState,
            }),
          );

          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 200) {
            // Successfully registered place in Firebase
            print('Place registered successfully');
          } else {
            // Error registering place
            print('Error registering place: ${response.reasonPhrase}');
          }
        } catch (e) {
          // Exception occurred
          print('Error registering place: $e');
        }

        setState(() {
          _isSending = false;
        });
      } else {
        // Show an error message or handle invalid input
        print('Invalid input');
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown button for Country
              DropdownButton<String>(
                value: selectedCountry,
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value!;
                    // Reset state when country changes
                    selectedState = stateMap[selectedCountry] != null
                        ? stateMap[selectedCountry]![0]
                        : 'Select State';
                  });
                },
                items: buildDropdownItems(countries),
              ),
              SizedBox(height: 16.0),

              // Dropdown button for State
              DropdownButton<String>(
                value: selectedState,
                onChanged: (value) {
                  setState(() {
                    selectedState = value!;
                  });
                },
                items: stateMap[selectedCountry] != null
                    ? buildDropdownItems(stateMap[selectedCountry]!)
                    : buildDropdownItems(['Select State']),
              ),
              SizedBox(height: 16.0),

              // Button to register place
              ElevatedButton(
                onPressed: _isSending ? null : _placeregistration,
                child: _isSending
                    ? CircularProgressIndicator()
                    : Text('Register Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
