import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                //controller.page é double
                color: controller.page.round() == page ?
                    Theme.of(context).primaryColor : Colors.grey[600],
                size: 30.0,
              ),
              SizedBox(width: 30.0,),
              Text(
                text,
                style: TextStyle(
                  color: controller.page.round() == page ?
                  Theme.of(context).primaryColor : Colors.grey[600],
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
