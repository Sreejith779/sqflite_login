import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user['id']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Name: ${user['name']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${user['email']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
