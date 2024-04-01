import 'package:coffee/screene/screene/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_provider.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  // Define controllers to store the values of the form fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController telephoneController =
      TextEditingController(); // Add this

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    telephoneController.dispose(); // Add this
    super.dispose();
  }

  void createAccount() async {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      // All fields are valid, proceed with account creation.

      // Access the AuthProvider instance
      var authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Get the values from the form fields
      String name = firstNameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String telephone = telephoneController.text; // Add this

      print(
          'Registering user: $name, $email, $telephone'); // Add this line for debugging

      try {
        var success = await authProvider.register(name, email, password,
            telephone); // Pass telephone here if your registration logic supports it

        if (success) {
          // Registration was successful, navigate to the next screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ),
          );
        } else {
          // Registration failed, handle the error or show a message
          // You can access the error message from authProvider.getMessage()
          String errorMessage = authProvider.getMessage();
          print(
              'Registration failed: $errorMessage'); // Add this line for debugging
          // Show the error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
            ),
          );
        }
      } catch (e) {
        // Handle exceptions that might occur during registration
        print('Error during registration: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: firstNameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your First Name";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF04764E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your Email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF04764E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: telephoneController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your Telephone";
                      }
                      // Use a regular expression to validate numeric input for the phone number
                      if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                        return "Please enter a valid numeric phone number";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Telephone",
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color(0xFF04764E),
                      ),
                    ),
                  ), // Add this
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter a Password";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xFF04764E),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF04764E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
