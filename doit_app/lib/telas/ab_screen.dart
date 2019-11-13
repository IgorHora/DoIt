import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_app/datas/ab_data.dart';
import 'package:doit_app/tiles/product_tile.dart';
import 'package:flutter/material.dart';

class ABScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  ABScreen(this.snapshot);

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
            future: Firestore.instance.collection("lojas").document
              (snapshot.documentID).collection("items").getDocuments(),
            builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          else
            return TabBarView(
              children: [
                //grade ab
                GridView.builder(
                  padding: EdgeInsets.all(3.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //qtd itens horizontal
                      crossAxisCount: 2,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                    ABData abdata = ABData.fromDocument(snapshot.data.documents[index]);
                    abdata.category = this.snapshot.documentID;
                      //envia grid e dados
                      return ProductTile("grid", abdata);
                    },
                ),
                ListView.builder(
                    padding: EdgeInsets.all(3.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      ABData abdata = ABData.fromDocument(snapshot.data.documents[index]);
                      abdata.category = this.snapshot.documentID;
                      //envia grid e dados
                      return ProductTile("list", abdata);
                    },
                ),
              ],
              physics: NeverScrollableScrollPhysics(),
            );
          }
        ),
      ),
    );
  }
}
