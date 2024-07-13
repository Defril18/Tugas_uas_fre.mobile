import 'package:flutter/material.dart';
import 'user_service.dart';

class UserPage extends StatelessWidget {
  final Character character;

  UserPage({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(character.image),
            SizedBox(height: 16),
            Text(
              character.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Status: ${character.status}'),
            Text('Species: ${character.species}'),
            Text('Type: ${character.type}'),
            Text('Gender: ${character.gender}'),
            Text('Origin: ${character.origin.name}'),
            Text('Location: ${character.location.name}'),
          ],
        ),
      ),
    );
  }
}
