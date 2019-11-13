import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_app/telas/ab_screen.dart';
import 'package:flutter/material.dart';

class ABTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  ABTile(this.snapshot);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ABScreen(snapshot))
        );
      },
    );
  }
}
