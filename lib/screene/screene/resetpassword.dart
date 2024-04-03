import 'package:coffee/screene/screene/signin.dart';
import 'package:flutter/material.dart';

import '../../services/auth_provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authProvider = AuthProvider();
  String _email = '';
  String _password = '';
  String _passwordConfirmation = '';
  bool isObscurePassword = true;
  bool isObscurePasswordConfirmation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.1),
      ),
      body: Padding(
        padding: EdgeInsets.all(35), // Added padding here
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "إعادة تعيين كلمة المرور",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Color(0xFF04764E)),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xFF04764E),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.green.withOpacity(0.1),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Color(0xFF04764E)),
                  prefixIcon: Icon(
                    Icons.password_outlined,
                    color: Color(0xFF04764E),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.green.withOpacity(0.1),
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                    icon: isObscurePassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    color: Color(0xFF04764E),
                  ),
                ),
                obscureText: isObscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(color: Color(0xFF04764E)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Colors.green.withOpacity(0.1),
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscurePasswordConfirmation =
                            !isObscurePasswordConfirmation;
                      });
                    },
                    icon: isObscurePasswordConfirmation
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    color: Color(0xFF04764E),
                  ),
                ),
                obscureText: isObscurePasswordConfirmation,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool success = await _authProvider.resetPassword(
                        _email, _password, _passwordConfirmation);
                    if (success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Password reset failed. Please try again.'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF04764E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
