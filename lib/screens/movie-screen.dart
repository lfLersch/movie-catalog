import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/components/category-box.dart';
import 'package:movie_catalog/components/full-line-text-box.dart';
import 'package:movie_catalog/components/generic-text-box.dart';
import 'package:movie_catalog/services/format-helper.dart';
import 'package:movie_catalog/services/network-helper.dart';

import '../Models/movie.dart';
import '../constants.dart';
import '../bloc/movie-bloc.dart';
import '../services/tmdb-helper.dart';

class MovieScreen extends StatefulWidget {
  static const String id = 'movie_screen';

  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  var bloc = new MovieBloc();

  @override
  Widget build(BuildContext context) {
    bloc.movie = ModalRoute.of(context)?.settings.arguments! as Movie;
    return FutureBuilder(
        future: bloc.getMovieFromTMDB(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildMovieScreen(context);
          } else {
            return buildLoadingScreen();
          }
        });
  }

  Scaffold buildLoadingScreen() {
    return const Scaffold(
              body: Center(child: CircularProgressIndicator())
            ,
          );
  }

  Scaffold buildMovieScreen(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
        Container(
          height: 300,
          color: Colours.gray08,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 90),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 32,
              children: [
                buildBackButton(context),
                buildPoster(bloc.movie),
                buildGrade(bloc.movie),
                buildMovieTitle(bloc.movie),
                buildOriginalTitle(bloc.movie),
                buildMovieGeneralInfoSection(bloc.movie),
                buildOverviewSection(bloc.movie),
                buildFinancialSection(bloc.movie),
                buildDirectorsSection(bloc.movie),
                buildCastSection(bloc.movie),
              ],
            ),
          ),
        )
      ]),
    ));
  }

  Align buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 80,
        child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Row(
              children: const [
                Icon(
                  // <-- Icon
                  Icons.arrow_back_ios,
                  size: 12,
                  color: Colours.gray02,
                ),
                Text(Strings.back, style: TextStyles.textStyleBack),
              ],
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            )),
      ),
    );
  }

  Container buildPoster(Movie movie) {
    return Container(
      height: 318,
      width: 216,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        image: DecorationImage(
            image: movie.posterPath == null
                ? const NetworkImage(Strings.noPosterURL)
                : NetworkImage(TMDBHelper.urlPostsBank + movie.posterPath!),
            fit: BoxFit.cover),
      ),
    );
  }

  Row buildGrade(Movie movie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          movie.grade!.toStringAsFixed(1),
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colours.grade),
        ),
        const Text(
          '/10',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colours.gray03),
        ),
      ],
    );
  }

  Text buildMovieTitle(Movie movie) {
    return Text(
      movie.title.toUpperCase(),
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colours.gray01),
    );
  }

  Row buildOriginalTitle(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Strings.originalTitle,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colours.gray02),
        ),
        Text(
          movie.originalTitle,
          style: const TextStyle(
              fontSize: 10, fontWeight: FontWeight.w600, color: Colours.gray03),
        ),
      ],
    );
  }

  Column buildMovieGeneralInfoSection(Movie movie) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenericTextBox(Strings.year, movie.date!.year.toString()),
            GenericTextBox(Strings.time, bloc.getMovieTime()),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (String genre in movie.genres) CategoryBox(genre.toUpperCase())
          ],
        ),
      ],
    );
  }

  Column buildOverviewSection(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(Strings.overview, style: TextStyles.genericSubject),
        Text(movie.overview, style: TextStyles.genericData),
      ],
    );
  }

  Column buildFinancialSection(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FullLineTextBox(Strings.budget, '\$' + bloc.getDolarBudget()),
        FullLineTextBox(Strings.producers, movie.producers),
      ],
    );
  }

  Column buildCastSection(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(Strings.cast, style: TextStyles.genericSubject),
        Text(movie.cast, style: TextStyles.genericData),
      ],
    );
  }

  Column buildDirectorsSection(Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(Strings.director, style: TextStyles.genericSubject),
        Text(movie.directors, style: TextStyles.genericData),
      ],
    );
  }
}
