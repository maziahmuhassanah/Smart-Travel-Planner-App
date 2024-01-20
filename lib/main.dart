import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_planner/home_page.dart';
import 'package:smart_travel_planner/signup.dart';
import 'package:smart_travel_planner/login.dart';
import 'place_registration.dart';
import 'q&a.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppUser()),
      ],
      child: MaterialApp(
        routes: {
          '/homepage': (context) => HomePage(username: ''),
          '/signup': (context) => SignupScreen(),
          '/qanda': (context) => UserQAScreen(),
        },
        title: 'Smart Travel Planner',
        home: 
        // HomePage(username: '',),
        LoginScreen(),
      ),
    );
  }
}

class AppUser with ChangeNotifier {
  String userId = '';

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}