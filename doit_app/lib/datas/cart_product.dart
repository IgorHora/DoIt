import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_app/datas/ab_data.dart';

class CartProduct {

  String cartId;
  String lojas;
  String productId;
  String flavor;
  int quantity;
  ABData abData;
  CartProduct();


  CartProduct.fromDocument (DocumentSnapshot documentSnapshot){
   cartId = documentSnapshot.documentID;
   lojas = documentSnapshot.data["category"];
   productId = documentSnapshot.data["productId"];
   quantity = documentSnapshot.data["quantity"];
   flavor = documentSnapshot.data["flavor"];
  }


  Map<String, dynamic> toMap(){
    return{
      "category": lojas,
      "productId": productId,
      "quantity": quantity,
      "flavor": flavor,
      //"product": abData.toResumedMap(),
    };

  }

}