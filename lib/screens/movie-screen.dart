import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalog/components/category-box.dart';
import 'package:movie_catalog/components/full-line-text-box.dart';
import 'package:movie_catalog/components/generic-text-box.dart';

import '../constants.dart';

class MovieScreen extends StatefulWidget {
  static const String id = 'movie_screen';
  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                          children: [
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        )),
                  ),
                ),
                Container(
                  height: 318,
                  width: 216,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(kTexturl), fit: BoxFit.cover),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '7.3',
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
                  'CAPITÃ MARVEL',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kColorGray01),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Título original: ',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: kColorGray02),
                    ),
                    Text(
                      'Captain Marvel',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: kColorGray03),
                    ),
                  ],
                ),

                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GenericTextBox('Ano', '2019'),
                      GenericTextBox('Duração', '1h 20 min'),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CategoryBox('AÇÃO'),
                      CategoryBox('AVENTURA'),
                      CategoryBox('SCI-FI'),
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
                    Text(kTextDesc,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: kColorGray01)),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FullLineTextBox('ORÇAMENTO', '\$ 152,000,000'),
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
                    Text('Ryan Fleck, Anna Boden',
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
                        'Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Djimon Hounsou, Lee Pace',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: kColorGray01)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
