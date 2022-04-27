import 'package:flutter/material.dart';
import 'package:movie_catalog/components/poster-container.dart';

import '../Models/movie.dart';
import '../constants.dart';
import '../services/catalog.dart';

class CatalogScreen extends StatefulWidget {
  static const String id = 'catalog_screen';
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.all(35),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                  child: Text(kTextTitle,
                      style: kTextStyleTitle)),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    hintText: kTextSearchTextField,
                    fillColor: kColorsGrey),
              ),
              SizedBox(height: 30),
              FutureBuilder(
                  future: Catalog().getMovieListFromTMDB('marvel') ,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Wrap(
                          direction: Axis.vertical,
                          spacing: 20,
                          children:
                           getPosterList(snapshot.data as List<Movie>)
                      );
                    }
                    return Container();

                    
                  },
              )],
          ),
        ),
      ),
    );
  }

  getPosterList(List<Movie> movies) {
    List<Widget> posters = [];
    for(var movie in movies){
      posters.add(PosterContainer(movie));
    }
    return posters;
  }
}
