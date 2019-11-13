import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  ServiceScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFC1DDCC),
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.apps),),
              Tab(icon: Icon(Icons.format_list_bulleted),)
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("services").document
              (snapshot.documentID).collection("items").getDocuments(),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
              else
                return TabBarView(
                  children: [
                    Container(),
                    Container(),
                  ],
                  physics: NeverScrollableScrollPhysics(),
                );
            }
        ),
      ),
    );
  }
}
