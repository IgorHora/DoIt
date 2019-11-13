import 'package:doit_app/models/user_model.dart';
import 'package:doit_app/telas/login_screen.dart';
import 'package:doit_app/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeDrawer extends StatelessWidget {

  final PageController pageController;

  HomeDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _background() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFE9E6BD), Color(0xFF89D5E0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _background(),
          ListView(
            padding: EdgeInsets.only(left: 30.0, top: 20.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 6.0),
                height: 160.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Do It",
                              style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            Text(
                              "The Birthday Party Maker",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                          ],
                        )
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Entre ou Cadastre-se" :
                                  "Sair",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor
                                  ),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>LoginScreen())
                                    );
                                  else
                                    model.signOut();
                                },// onTap
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.cake,"Produtos", pageController, 1),
              DrawerTile(Icons.local_drink, "Serviços", pageController, 2),
              DrawerTile(Icons.assignment, "Pedidos", pageController, 3)
            ],
          )
        ],
      ),
    );
  }
}
