import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class UserQAScreen extends StatefulWidget {
  @override
  _UserQAScreenState createState() => _UserQAScreenState();
}

class _UserQAScreenState extends State<UserQAScreen> {
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Q&A'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.reference().child('questions').onValue,
              builder: (context, snapshot) {
                // Handle changes in questions and update UI
                return ListView.builder(
                  itemCount: 0, // Replace with the actual number of questions
                  itemBuilder: (context, index) {
                    // Build UI for each question
                    return ListTile(
                      title: Text('Question $index'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    decoration: InputDecoration(hintText: 'Ask a question...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    appUser.setUserId('userId'); // Replace with the actual user ID after authentication
                    askQuestion(appUser.userId, _questionController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void askQuestion(String userId, String question) {
    final reference = FirebaseDatabase.instance.reference().child('questions');
    reference.push().set({
      'userId': userId,
      'question': question,
      'timestamp': ServerValue.timestamp,
    });
    _questionController.clear();
  }
}
