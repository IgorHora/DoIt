import 'package:doit_app/datas/ab_data.dart';
import 'package:doit_app/telas/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ABData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //abre a tela de produto
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>ProductScreen(product))
        );
      },
      child: Card(
          //testa se grid ou list
          child: type == "grid"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //fixa aspecto independente do tamanho da tela
                    AspectRatio(
                      aspectRatio: 0.9,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(7.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              product.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "R\$ ${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Image.network(product.images[0],
                        fit: BoxFit.cover,
                        height: 200.0,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(9.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "R\$ ${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}
