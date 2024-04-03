import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Text(
                '150x150',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'William Smith',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'London, England',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('92 678 345 12+'),
              trailing: Icon(Icons.more_horiz),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('example@gmail.com'),
              trailing: Icon(Icons.more_horiz),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Franklin Avenue, Corner St. London, 24125151'),
              trailing: Icon(Icons.more_horiz),
            ),
          ],
        ),
      ),
    );
  }
}
