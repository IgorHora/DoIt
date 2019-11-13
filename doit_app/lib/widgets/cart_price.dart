import 'package:doit_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {

    var now = new DateTime.now();
    var aproval = now.add(Duration(days: 1));
    String date = ('${now.day}/${now.month}/${now.year}');
    String aprovalDate = ('${aproval.day}/${aproval.month}/${aproval.year}');

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: ScopedModelDescendant<CartModel>(
          // ignore: missing_return
          builder: (context,child,model){

            double price = model.getProductsPrice();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight:  FontWeight.w500),
                ),
                SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Data do Agendamento"),
                    Text("31/12/2019")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Data do Pedido"),
                    Text(date)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Data de Aprovação"),
                    Text(aprovalDate)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text("R\$ ${price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0
                     ),
                   )
                  ],
                ),
                SizedBox(height: 12.0,),
                RaisedButton(
                  child: Text("Finalizar Pedido"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: (){},
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
