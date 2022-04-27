import 'package:flutter/material.dart';
import 'package:movie_catalog/Models/movie.dart';
import 'package:movie_catalog/services/tmdb-helper.dart';

class CatalogBloc {
  var movieNameController = new TextEditingController();
  List<Movie> movies = [];

  searchMovies(value) async{
    movies = await TMDBHelper().getMovieListFromTMDB(value);
  }
}