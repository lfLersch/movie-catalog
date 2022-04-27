import 'package:intl/intl.dart';

class Movie{
  String title, id;
  List<String> genres;
  String? posterPath;
  late String originalTitle, overview, producer, cast, directors, budget;
  DateTime? date;
  num? runtime, grade;
  Movie({required this.title,required this.posterPath,required this.id,required this.genres});

  genresAsString(){
    String genresString;
    if(genres.isNotEmpty){
      genresString = genres[0];
      int index = 1;
      while(index < genres.length){
        genresString += ' - ' + genres[index];
        index ++;
      }
      return genresString;
    }
    return '';
  }

  setMovieFromJson(movieJson) {
    var movieData = movieJson[0];
    originalTitle = movieData['original_title'];
    overview = movieData['overview'];
    runtime = movieData['runtime'];
    grade = movieData['vote_average'];
    var dolarFormat =  NumberFormat("#,##0.00", "en_US");
    budget = dolarFormat.format(movieData['budget']);
    date = DateTime.parse(movieData['release_date']);
    producer = movieData['production_companies'][0]['name'];

    var movieCastCrew = movieJson[1];
    var genericMap = movieCastCrew['cast'];
    cast = '';
    if(genericMap != null){
      cast += genericMap[0]['name'];
      for(var actor in genericMap.sublist(1)){
        cast += ', ' + actor['name'];
      }
    }

    genericMap = movieCastCrew['crew'];
    directors = '';
    for(var crew in genericMap){
      if(crew['job'] == 'Director'){
        directors += crew['name'] + ', ';
      }
    }
     directors = directors.substring(0, directors.length-2);
  }

}