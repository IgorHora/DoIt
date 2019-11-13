import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_app/tiles/service_tile.dart';
import 'package:flutter/material.dart';

class ServiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("services").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return ListView(
            children: snapshot.data.documents.map((doc) {
              return ServiceTile(doc);
            }).toList(),
          );
        }
      },
    );
  }
}
