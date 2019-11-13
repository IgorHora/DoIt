import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doit_app/datas/ab_data.dart';
import 'package:doit_app/datas/cart_product.dart';
import 'package:doit_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {

      //atualiza os precos antes de desenhar o carrinho
      CartModel.of(context).updatePrices();

      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 150.0,
            child: Image.network(cartProduct.abData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.abData.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0
                        ),
                  ),
                  Text(
                    "Sabor: ${cartProduct.flavor}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${cartProduct.abData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey,
                        onPressed: (){
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );

    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: (cartProduct.abData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("lojas")
                  .document(cartProduct.lojas)
                  .collection("items")
                  .document(cartProduct.productId)
                  .get(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.abData = ABData.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    height: 70.0,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
            )
          : _buildContent()),
    );
  }
}
