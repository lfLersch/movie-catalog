import 'package:flutter/material.dart';
import 'package:movie_catalog/components/poster-container.dart';

import '../Models/movie.dart';
import '../catalog-bloc.dart';
import '../constants.dart';

class CatalogScreen extends StatefulWidget {
  static const String id = 'catalog_screen';

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  var bloc = new CatalogBloc();
  List<Movie> movies = [];

  @override
  void dispose() {
    bloc.movieNameController.dispose();
    super.dispose();
  }

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
                  child: Text(Strings.title, style: TextStyles.textStyleMovieTitle)),
              SizedBox(height: 30),
              TextField(
                onSubmitted: (value) async {
                  bloc.searchMovies(value);
                  setState(() {});
                },
                textInputAction: TextInputAction.search,
                controller: bloc.movieNameController,
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
                    hintText: Strings.search,
                    fillColor: Colours.grey),
              ),
              SizedBox(height: 30),
              if (bloc.movies.isNotEmpty)
                Wrap(direction: Axis.vertical, spacing: 20, children: [
                  for (var movie in bloc.movies) PosterContainer(movie)
                ]),
            ],
          ),
        ),
      ),
    );
  }
}
