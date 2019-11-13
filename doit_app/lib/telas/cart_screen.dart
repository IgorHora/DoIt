
import 'package:doit_app/models/cart_model.dart';
import 'package:doit_app/models/user_model.dart';
import 'package:doit_app/telas/login_screen.dart';
import 'package:doit_app/tiles/cart_tile.dart';
import 'package:doit_app/widgets/cart_price.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC1DDCC),
      appBar: AppBar(
        title: Text(
          "Meu Carrinho",
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(6.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  //se p=null exibe 0//se p<=1 exibe ITEM
                  "${p ?? 0} ${p <= 1 ? "ITEM" : "ITEMS"}",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                );
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        // ignore: missing_return
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 60.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    "Faça o login para visualizar seu carrinho!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 18.0),
                  RaisedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>LoginScreen())
                      );
                    },
                  ),
                ],
              ),
            );

          } else if (model.products == null || model.products.length == 0){
            return Center(
              child: Text (
                "O carrinho está vazio!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map((product){
                    return CartTile(product);
                  },
                  ).toList(),
                ),
                CartPrice((){})
              ],
            );
          }
        },
      ),
    );
  }
}
