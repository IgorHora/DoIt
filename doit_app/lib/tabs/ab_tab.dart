import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_app/tiles/ab_tile.dart';
import 'package:flutter/material.dart';

class ABTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("lojas").getDocuments(),
      builder: (context, snapshot){
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        else {
          //inserir divideTiles
          return ListView(
            children: snapshot.data.documents.map(
              (doc){
                return ABTile(doc);
              }
            ).toList(),
          );
        } //else
      },
    );
  }
}
