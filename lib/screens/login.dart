import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the theme colors from MaterialApp
    final theme = Theme.of(context);

    // Method to handle the login button pressed
    void _loginPressed() {
      // If login is successful, navigate to the TasksScreen
      Navigator.pushReplacementNamed(context, '/tasks');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme:
                    theme.colorScheme.copyWith(primary: theme.primaryColor),
              ),
              child: ElevatedButton(
                onPressed: _loginPressed, // Pass the method directly
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
