import 'package:flutter/material.dart';
import 'screens/login.dart'; // Import the LoginScreen
import 'screens/tasks_screen.dart'; // Import the TasksScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'To do App', // Set app title
      theme: ThemeData(
        // Configure app theme
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 11, 178, 28), // Set primary color
        ),
        useMaterial3: true, // Enable Material 3 design elements
      ),

      home: LoginScreen(),

      routes: {
        '/login': (context) => LoginScreen(),
        '/tasks': (context) => TasksScreen(),
        // Define other routes here
      },
    );
  }
}
