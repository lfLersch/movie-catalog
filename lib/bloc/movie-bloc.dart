import 'dart:ffi';

import 'package:movie_catalog/Models/movie.dart';
import 'package:movie_catalog/services/format-helper.dart';
import 'package:movie_catalog/services/tmdb-helper.dart';

class MovieBloc {
  final formatHelper = FormatHelper();
  late Movie movie;

  getDolarBudget() {
    return formatHelper.toDolar(movie.budget!);
  }

  getMovieTime() {
    return formatHelper.toTime(movie.runtime!);
  }

  Future<bool> getMovieFromTMDB() async{
    await movie.setMovieFromJson(await TMDBHelper().getMovieFromTMDB(movie));
    return true;
  }
}
