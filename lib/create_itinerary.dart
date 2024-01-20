import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CreateItineraryScreen extends StatefulWidget {
  @override
  _CreateItineraryScreenState createState() => _CreateItineraryScreenState();
}

class _CreateItineraryScreenState extends State<CreateItineraryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _placeController = '';
  var _dateController = '';
  var _timeController = '';
  var _noteController = '';
  var _isSending = false;

  Future<void> _itinerary() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();
      final url = Uri.https(
      'smart-planner-travel-app-default-rtdb.asia-southeast1.firebasedatabase.app',
      'itinerary.json',
      );
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'place': _placeController,
            'date': _dateController,
            'time': _timeController,
            'note': _noteController,

          },
        ),
      );

      print(response.body);
      print(response.statusCode);

      final Map<String, dynamic> resData = json.decode(response.body);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CreateItineraryScreen()),
        );
      }
    }
  }
  
  List<Itinerary> itineraries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Itinerary'),
      ),
      body: itineraries.isEmpty
          ? Center(
              child: Text('No itineraries yet'),
            )
          : ListView.builder(
              itemCount: itineraries.length,
              itemBuilder: (context, index) {
                return ItineraryCard(itinerary: itineraries[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Prompt user to fill in itinerary details
          Itinerary? newItinerary = await showDialog<Itinerary>(
            context: context,
            builder: (BuildContext context) {
              return AddItineraryDialog();
            },
          );

          // If user clicks "Save" in the dialog, add the new itinerary to the list
          if (newItinerary != null) {
            setState(() {
              itineraries.add(newItinerary);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Itinerary {
  final String place;
  final String date;
  final String time;
  final String note;

  Itinerary({
    required this.place,
    required this.date,
    required this.time,
    required this.note,
  });
}

class ItineraryCard extends StatelessWidget {
  final Itinerary itinerary;

  const ItineraryCard({required this.itinerary});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(itinerary.place),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${itinerary.date}'),
            Text('Time: ${itinerary.time}'),
            Text('Note: ${itinerary.note}'),
          ],
        ),
      ),
    );
  }
}

class AddItineraryDialog extends StatefulWidget {
  @override
  _AddItineraryDialogState createState() => _AddItineraryDialogState();
}

class _AddItineraryDialogState extends State<AddItineraryDialog> {
  late TextEditingController placeController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    placeController.dispose();
    dateController.dispose();
    timeController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Itinerary'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: placeController,
              decoration: InputDecoration(labelText: 'Place'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextField(
              controller: noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without saving
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Save the itinerary and close the dialog
            Itinerary newItinerary = Itinerary(
              place: placeController.text,
              date: dateController.text,
              time: timeController.text,
              note: noteController.text,
            );
            Navigator.of(context).pop(newItinerary);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
