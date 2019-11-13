import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_app/datas/cart_product.dart';
import 'package:doit_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;
  List<CartProduct> products = [];

  CartModel(this.user){
    if (user.isLoggedIn())
    _loadCartItems();
  }

  bool isLoading = false;

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem (CartProduct cartProduct){
    products.add(cartProduct);

    //cria carrinho associado ao usuário; pega cartId
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("cart").add(cartProduct.toMap()).then((doc){
        cartProduct.cartId = doc.documentID;
    });

    //atualiza carrinho
    notifyListeners();
  }

  void removeCartItem (CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cartId).delete();

    products.remove(cartProduct);

    //atualiza carrinho
    notifyListeners();

  }

  double getProductsPrice(){
    double price = 0.0;
    for (CartProduct c in products){
      if(c.abData != null)
        price += c.abData.price;
    }
    return price;
  }

  //força atualização de preços
  void updatePrices(){
    notifyListeners();
  }

  void _loadCartItems() async{
    QuerySnapshot query = await Firestore.instance.collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart").getDocuments();

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    //atualiza carrinho
    notifyListeners();
  }

}