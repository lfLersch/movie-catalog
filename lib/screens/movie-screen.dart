import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/String.dart';
import 'package:movie_catalog/components/category-box.dart';
import 'package:movie_catalog/components/full-line-text-box.dart';
import 'package:movie_catalog/components/generic-text-box.dart';
import 'package:movie_catalog/services/format-helper.dart';
import 'package:movie_catalog/services/network-helper.dart';

import '../Models/movie.dart';
import '../constants.dart';
import '../services/tmdb-helper.dart';

class MovieScreen extends StatefulWidget {
  static const String id = 'movie_screen';
  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  @override
  Widget build(BuildContext context) {
    final formatHelper = FormatHelper();
    final Movie movie = ModalRoute.of(context)?.settings.arguments! as Movie;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: TMDBHelper().getMovieFromTMDB(movie),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Movie movie = snapshot.data as Movie;
                return Stack(children: [
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
                          buildPoster(movie),
                          buildGrade(movie),
                          buildMovieTitle(movie),
                          buildOriginalTitle(movie),
                          buildMovieGeneralInfoSection(movie, formatHelper),
                          buildOverviewSection(movie),
                          buildFinancialSection(formatHelper, movie),
                          buildDirectorsSection(movie),
                          buildCastSection(movie),
                        ],
                      ),
                    ),
                  )
                ]);
              } else {
                return Container();
              }
            }),
      ),
    );
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
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                )),
                          ),
                        );
  }

  Container buildPoster(Movie movie) {
    return Container(
                          height: 318,
                          width: 216,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            image: DecorationImage(
                                image: movie.posterPath == null
                                    ? NetworkImage(Strings.noPosterURL)
                                    : NetworkImage(
                                        NetworkHelper.urlPostsBank +
                                            movie.posterPath!),
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
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colours.grade),
                            ),
                            Text(
                              '/10',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colours.gray03),
                            ),
                          ],
                        );
  }

  Text buildMovieTitle(Movie movie) {
    return Text(
                          movie.title.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colours.gray01),
                        );
  }

  Row buildOriginalTitle(Movie movie) {
    return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              Strings.originalTitle,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colours.gray02),
                            ),
                            Text(
                              movie.originalTitle,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colours.gray03),
                            ),
                          ],
                        );
  }

  Column buildMovieGeneralInfoSection(Movie movie, FormatHelper formatHelper) {
    return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GenericTextBox(
                                    Strings.year, movie.date!.year.toString()),
                                GenericTextBox(Strings.time, formatHelper.toTime(movie.runtime!)),
                              ],
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                for (String genre in movie.genres)
                                  CategoryBox(genre.toUpperCase())
                              ],
                            ),
                          ],
                        );
  }

  Column buildOverviewSection(Movie movie) {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(Strings.overview,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colours.gray02)),
                            Text(movie.overview,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colours.gray01)),
                          ],
                        );
  }

  Column buildFinancialSection(FormatHelper formatHelper, Movie movie) {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FullLineTextBox(
                                Strings.budget, '\$' + formatHelper.toDolar(movie.budget!)),
                            FullLineTextBox(Strings.producers, movie.producers),
                          ],
                        );
  }

  Column buildCastSection(Movie movie) {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(Strings.cast,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colours.gray02)),
                            Text(movie.cast,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colours.gray01)),
                          ],
                        );
  }

  Column buildDirectorsSection(Movie movie) {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(Strings.director,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colours.gray02)),
                            Text(movie.directors,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colours.gray01)),
                          ],
                        );
  }
}
