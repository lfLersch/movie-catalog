class Movie{
  String title, id;
  List<String> genres;
  String? posterPath;
  late String originalTitle, overview, cast, directors, producers;
  DateTime? date;
  num? runtime, grade, budget;
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
    budget = movieData['budget'];


    date = DateTime.parse(movieData['release_date']);

    producers = '';
    for(var producer in movieData['production_companies']){
      producers += producer['name'] + ', ';
    }
    producers = producers.substring(0, producers.length-2);

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