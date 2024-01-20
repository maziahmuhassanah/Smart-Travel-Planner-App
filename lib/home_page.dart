import 'package:flutter/material.dart';
import 'create_itinerary.dart';
import 'place_registration.dart';
import 'cost_estimation.dart'; 
import 'q&a.dart'; 

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(username: widget.username),
      PlaceRegistrationScreen(),
      CreateItineraryScreen(),
      ViewEstimatedCostScreen(),
      UserQAScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Planner'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: 'Register Place',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Create Itinerary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'View Estimate Cost',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Q&A',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/menu.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _navigateToScreen(0);
              },
            ),
            ListTile(
              title: Text('Register Place'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _navigateToScreen(1);
              },
            ),
            ListTile(
              title: Text('Create Itinerary'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _navigateToScreen(2);
              },
            ),
            ListTile(
              title: Text('View Estimate Cost'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _navigateToScreen(3);
              },
            ),
            ListTile(
              title: Text('Q&A'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _navigateToScreen(4);
              },
            ),  
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(int index) {
    if (_currentIndex == index) return; // Do nothing if the current page is selected again
    setState(() {
      _currentIndex = index;
    });
  }
}

class HomeScreen extends StatelessWidget {
  final String username;

  HomeScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            StateCard(state: 'Kuala Lumpur', backgroundImage: 'assets/images/kl_background.jpg'),
            StateCard(state: 'Terengganu', backgroundImage: 'assets/images/terengganu_background.jpg'),
            StateCard(state: 'Kelantan', backgroundImage: 'assets/images/kelantan_background.jpg'),
          ],
        ),
      ),
    );
  }
}

class StateCard extends StatelessWidget {
  final String state;
  final String backgroundImage;

  StateCard({required this.state, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            state,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
