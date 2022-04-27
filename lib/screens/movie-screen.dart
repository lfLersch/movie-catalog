import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/components/category-box.dart';
import 'package:movie_catalog/components/full-line-text-box.dart';
import 'package:movie_catalog/components/generic-text-box.dart';
import 'package:movie_catalog/services/network-helper.dart';

import '../Models/movie.dart';
import '../constants.dart';
import '../services/catalog.dart';

class MovieScreen extends StatefulWidget {
  static const String id = 'movie_screen';
  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments! as Movie;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Catalog().getMovieFromTMDB(movie),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Movie movie = snapshot.data as Movie;
                return Container(
                  padding: new EdgeInsets.fromLTRB(20, 50, 20, 90),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 32,
                      children: [
                        Align(
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
                                      color: kColorGray02,
                                    ),
                                    Text('Voltar', style: kTextStyleBack),
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
                        ),
                        Container(
                          height: 318,
                          width: 216,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            image: DecorationImage(
                                image: movie.posterPath == null
                                    ?  NetworkImage(kTexturl)
                                    : NetworkImage(NetworkHelper.urlPostsBank + movie.posterPath!),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              movie.grade!.toStringAsFixed(1),
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: kColorGrade),
                            ),
                            Text(
                              '/10',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kColorGray03),
                            ),
                          ],
                        ),
                        Text(
                          movie.title.toUpperCase(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kColorGray01),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text(
                              'Título original: ',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: kColorGray02),
                            ),
                            Text(
                              movie.originalTitle,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: kColorGray03),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GenericTextBox('Ano', movie.date!.year.toString()),
                                GenericTextBox('Duração', '1h 20 min'),
                              ],
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                for(String genre in movie.genres) CategoryBox(genre.toUpperCase())
                              ],
                            ),
                          ],
                        ),

                        //ADICIONA MINI CAIXAS
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Descrição',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kColorGray02)),
                            Text(movie.overview,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: kColorGray01)),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FullLineTextBox('ORÇAMENTO', '\$' + movie.budget.toString()),
                            FullLineTextBox('PRODUTORA', 'MARVEL STUDIOS'),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Diretor',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kColorGray02)),
                            Text(movie.directors,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: kColorGray01)),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Elenco',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kColorGray02)),
                            Text(
                                movie.cast,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: kColorGray01)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}
