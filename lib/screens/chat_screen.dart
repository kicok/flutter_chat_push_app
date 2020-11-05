import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CahtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Firebase.initializeApp();
          FirebaseFirestore.instance
              .collection('chats/mNJDKVVbYkMUaZwwTueu/messages')
              .snapshots()
              .listen((data) {
            data.docs.forEach((documents) {
              print(documents['text']);
            });
            // print(data.docs[0]['text']);
          });
        },
      ),
    );
  }
}
