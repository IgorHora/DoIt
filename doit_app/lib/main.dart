import 'package:doit_app/models/cart_model.dart';
import 'package:doit_app/models/user_model.dart';
import 'package:doit_app/telas/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      //altera carrinho com alteração do usuário
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'DoIt',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255, 5, 125, 145)
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      )
    );
  }
}

