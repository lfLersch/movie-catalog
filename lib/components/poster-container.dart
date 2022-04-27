import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/Models/movie.dart';
import 'package:movie_catalog/constants.dart';
import 'package:movie_catalog/screens/movie-screen.dart';
import 'package:movie_catalog/services/network-helper.dart';

class PosterContainer extends StatefulWidget {
  final Movie movie;
  const PosterContainer(this.movie, {Key? key}) : super(key: key);

  @override
  _PosterContainerState createState() => _PosterContainerState();
}

class _PosterContainerState extends State<PosterContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, MovieScreen.id, arguments: widget.movie),
      child: Container(
        height: 470,
        width: 320,
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            image: DecorationImage( image:
                 widget.movie.posterPath == null
                ?  const NetworkImage(Strings.noPosterURL)
                    : NetworkImage(NetworkHelper.urlPostsBank + widget.movie.posterPath!), fit: BoxFit.cover),),
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 0 , 0, 32),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              gradient: LinearGradient(
                  begin: FractionalOffset.center,
                  end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black,
                ],stops: const [
                0.0,
                1.0
              ]
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(widget.movie.title.toUpperCase(), style: TextStyles.textStyleMovieTitle),
              ),
              SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.movie.genresAsString(),
                    style: TextStyles.textStyleMovieCategory,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
