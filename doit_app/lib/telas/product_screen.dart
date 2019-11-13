import 'package:carousel_pro/carousel_pro.dart';
import 'package:doit_app/datas/ab_data.dart';
import 'package:doit_app/datas/cart_product.dart';
import 'package:doit_app/models/cart_model.dart';
import 'package:doit_app/models/user_model.dart';
import 'package:doit_app/telas/cart_screen.dart';
import 'package:doit_app/telas/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductScreen extends StatefulWidget {
  final ABData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ABData product;
  String flavor;


  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor =  Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Color(0xFFC1DDCC),
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      //para permitir subir a tela
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            //exibe imagens do produto
            child: Carousel(
              //imagem como url no firebase
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              dotSize: 5.0,
              dotSpacing: 18.0,
              autoplay: false,
              autoplayDuration: (Duration(seconds: 5)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500
                  ),
                  //quebra de título
                  maxLines: 2,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 23.0,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 14.0,),
                Text(
                  "Sabor",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 3.0,
                      //crossAxisSpacing: 3.0,
                      childAspectRatio: 0.15,
                    ),
                    children: product.flavor.map(
                        (f){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                flavor = f;
                              });
                            },
                            //campo sabor
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                border: Border.all(
                                  width: 3.0,
                                  color: f == flavor ? primaryColor : Colors.grey[500],
                                )
                              ),
                              alignment: Alignment.center,
                              width: 50.0,
                              child: Text(f),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 40.0,
                  child: ScopedModelDescendant<UserModel>(
                    builder: (context, child, model) {
                      return RaisedButton(
                        color: primaryColor,
                        textColor: Colors.white,
                        //habilita o botão qdo houver seleção de sabor
                        onPressed: (flavor != null || !model.isLoggedIn()) ? (){
                          if(model.isLoggedIn()) {
                            CartProduct cartProduct = CartProduct();
                            cartProduct.flavor = flavor;
                            cartProduct.quantity = 1;
                            cartProduct.productId = product.id;
                            cartProduct.lojas = product.category;

                            CartModel.of(context).addCartItem(cartProduct);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>CartScreen()
                              )
                            );
                          }//if
                          else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>LoginScreen()
                              )
                            );
                          }//else
                        } : null,
                        child: Text(model.isLoggedIn() ? "Adicionar ao carrinho"
                          : "Entre para comprar",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      );

                    },
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
