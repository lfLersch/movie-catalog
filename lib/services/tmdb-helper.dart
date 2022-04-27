import '../Models/movie.dart';
import 'network-helper.dart';

const apiKey = '1741ee8ca22dabdb71c5011551a13f40';
const tmdbUrl = 'https://api.themoviedb.org/3/search/movie?api_key=';
const tmdbUrlSpecific = 'https://api.themoviedb.org/3/movie/';


class TMDBHelper {
  static const urlPostsBank = 'https://image.tmdb.org/t/p/original';

  Future<List<Movie>> getMovieListFromTMDB(String movieName) async {
    NetworkHelper networkHelper =
        NetworkHelper('$tmdbUrl$apiKey&query=$movieName&language=pt-BR');

    var movieData = await networkHelper.getData();
    List<Movie> movieList = _getMoviesFromJson(movieData);

    return movieList;
  }

  Future<dynamic> getMovieFromTMDB(Movie movie) async {
    NetworkHelper networkHelperMovieData =
    NetworkHelper(tmdbUrlSpecific + movie.id + '?api_key=$apiKey&language=pt-BR');
    var movieData = await networkHelperMovieData.getData();

    NetworkHelper networkHelperMovieCast =
    NetworkHelper(tmdbUrlSpecific + movie.id +'/credits?api_key=$apiKey&language=pt-BR');
    var movieCast = await networkHelperMovieCast.getData();

    return [movieData, movieCast];
  }



  String getGenre(int id) {
    switch (id) {
      case 28:
        return 'Action';
      case 12:
        return 'Adventure';
      case 16:
        return 'Animation';
      case 35:
        return 'Comedy';
      case 80:
        return 'Crime';
      case 99:
        return 'Documentary';
      case 18:
        return 'Drama';
      case 10751:
        return 'Family';
      case 14:
        return 'Fantasy';
      case 36:
        return 'History';
      case 27:
        return 'Horror';
      case 10402:
        return 'Music';
      case 9648:
        return 'Mystery';
      case 10749:
        return 'Romance';
      case 878:
        return 'Science Fiction';
      case 10770:
        return 'TV Movie';
      case 53:
        return 'Thriller';
      case 10752:
        return 'War';
    }
    return 'Genre';
  }




  List<Movie> _getMoviesFromJson(movieData) {
    List<Movie> movies = [];
    for(var movie in movieData['results']){
      List<String> genres = [];
      for(int id in movie['genre_ids']){
        genres.add(getGenre(id));
      }
      movies.add(Movie(title: movie['title'], genres: genres,id: movie['id'].toString(),posterPath: movie['poster_path']));
    }
      return movies;
  }
}

