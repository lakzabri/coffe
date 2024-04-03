import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(SearchScreen());

class SearchScreen extends StatelessWidget {
  // const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Search Screen')),
        body: const Center(
          child: SearchField(),
        ),
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String _searchQuery = '';

  Future<List<dynamic>> _getSearchResults(String query) async {
    final response = await http.get(Uri.parse('https://api.example.com/search?q=$query'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Search',
            suffixIcon: IconButton(
              onPressed: () async {
                final results = await _getSearchResults(_searchQuery);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Search Results'),
                    content: Text('Number of results: ${results.length}'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}
