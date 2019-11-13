import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _background() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE9E6BD), Color(0xFFFC7000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _background(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder <QuerySnapshot>(
              future: Firestore.instance.collection("home")
                  .orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                else {
                  print(snapshot.data.documents.length);
                  return SliverStaggeredGrid.count(
                      crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map(
                        (doc){
                          return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                        }
                    ).toList(),
                    children: snapshot.data.documents.map(
                        (doc) {
                          return FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: doc.data["image"],
                              fit: BoxFit.cover,
                          );
                        }
                    ).toList(),
                  );
                } // else
              },
            ),
          ],
        ),
      ],
    );
  }
}
