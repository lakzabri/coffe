import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screene/welcome_screen.dart';
import 'services/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        // Add other providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          secondaryHeaderColor: const Color(0xFFf7fee7),
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
