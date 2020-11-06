import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CahtScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _waitState() {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return Scaffold(
      body: FutureBuilder(
          future: _initialization,
          builder: (ctx, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return _waitState();
            }
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats/mNJDKVVbYkMUaZwwTueu/messages')
                  .snapshots(),
              builder: (ctx, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return _waitState();
                }

                final documents = streamSnapshot.data.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(documents[index]['text']),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          FirebaseFirestore.instance
              .collection('chats/mNJDKVVbYkMUaZwwTueu/messages')
              .add({'text': 'This was added by clicking the button!'});
        },
      ),
    );
  }
}
