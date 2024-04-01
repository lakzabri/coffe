import 'package:coffee/screene/screene/signUp.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../services/auth_provider.dart';
import '../../utilis/primary_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isObscure = true; // Whether the password is obscured or not

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Email validation function
  bool validateEmail(String value) {
    if (value.isEmpty) {
      emailFocusNode.requestFocus();
      return false;
    } else {
      // You can use a regular expression to validate the email format
      // For simplicity, this example only checks if '@' is present
      if (!value.contains('@')) {
        emailFocusNode.requestFocus();
        return false;
      }
    }
    return true;
  }

  // Password validation function
  bool validatePassword(String value) {
    if (value.isEmpty) {
      passwordFocusNode.requestFocus();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey, // Add this line
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/hom.jpg", height: 160),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: isObscure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  text: "Login",
                  press: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text;

                    if (validateEmail(email) && validatePassword(password)) {
                      _formKey.currentState!.save(); // Save the form
                      print("is validate");

                      // Call the login function and obtain the token
                      var login = await Provider.of<AuthProvider>(context,
                              listen: false)
                          .login(emailController.text, passwordController.text);

                      if (login) {
                        // Set the obtained token

                  
                        
                        print("login with success");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(Provider.of<AuthProvider>(context,
                                    listen: false)
                                .message)));
                        print("login failed");
                      }
                    }
                  },
                ),
                SizedBox(height: 10),
                PrimaryButton(
                  color: Theme.of(context).colorScheme.secondary,
                  text: "Sign Up",
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUP(),
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
