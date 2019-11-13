import 'package:cloud_firestore/cloud_firestore.dart';

class ABData {

  String category;
  String id;
  String title;
  String description;

  double price;

  List images;
  List flavor;

  ABData.fromDocument (DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    price = snapshot.data["price"]+0.0;
    images = snapshot.data["image"];
    flavor = snapshot.data["flavor"];
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      "description": description,
      "price": price,
    };

  }
}