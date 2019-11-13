import 'package:doit_app/tabs/ab_tab.dart';
import 'package:doit_app/tabs/home_tab.dart';
import 'package:doit_app/tabs/service_tab.dart';
import 'package:doit_app/widgets/cart_button.dart';
import 'package:doit_app/widgets/home_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: HomeDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          backgroundColor: Color(0xFFC1DDCC),
          appBar: AppBar(
            title: Text("Alimentos & Bebidas"),
            centerTitle: true,
          ),
          drawer: HomeDrawer(_pageController),
          floatingActionButton: CartButton(),
          body: ABTab(),
        ),
        Scaffold(
          backgroundColor: Color(0xFFC1DDCC),
          appBar: AppBar(
            title: Text("Serviços"),
            centerTitle: true,
          ),
          drawer: HomeDrawer(_pageController),
          floatingActionButton: CartButton(),
          body: ServiceTab(),
        ),
        Scaffold(
          backgroundColor: Color(0xFFC1DDCC),
          appBar: AppBar(
            title: Text("Pedidos"),
            centerTitle: true,
          ),
          drawer: HomeDrawer(_pageController),
          floatingActionButton: CartButton(),
          //body: ABTab(),
        ),
      ],
    );
  }

}
