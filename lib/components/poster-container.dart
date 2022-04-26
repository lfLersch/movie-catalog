import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/constants.dart';
import 'package:movie_catalog/screens/movie-screen.dart';

class PosterContainer extends StatefulWidget {
  const PosterContainer({Key? key}) : super(key: key);

  @override
  _PosterContainerState createState() => _PosterContainerState();
}

class _PosterContainerState extends State<PosterContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, MovieScreen.id),
      child: Container(
        height: 470,
        width: 320,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            image: DecorationImage(
                image: NetworkImage(kTexturl), fit: BoxFit.cover),),
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
            children: const [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('CAPITÃ MARVEL', style: kTextStyleMovieTitle),
              ),
              SizedBox(height: 12),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Ação - Aventura',
                    style: kTextStyleMovieCategory,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
