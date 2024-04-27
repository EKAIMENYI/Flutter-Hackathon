import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // Hardcoded email and password for verification
  static const String validEmail = 'eliaskaimenyi@gmail.com';
  static const String validPassword = '1111';

  @override
  Widget build(BuildContext context) {
    // Use the theme colors from MaterialApp
    final theme = Theme.of(context);

    // Controllers for email and password fields
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Method to handle the login button pressed
    void _loginPressed() {
      // Get the entered email and password
      final enteredEmail = emailController.text.trim();
      final enteredPassword = passwordController.text.trim();

      // Check if the entered email and password match the valid credentials
      if (enteredEmail == validEmail && enteredPassword == validPassword) {
        // If login is successful, navigate to the TasksScreen
        Navigator.pushReplacementNamed(context, '/tasks');
      } else {
        // Show an error message for invalid credentials
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('Please enter valid email and password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title:
            Text('Login', textAlign: TextAlign.center), // Align text to center
        centerTitle: true, // Center the title text
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
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
