import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Strings {
  static const back = 'Voltar';
  static const originalTitle = 'Título original: ';
  static const cast = 'Elenco';
  static const year = 'Ano';
  static const time = 'Duração';
  static const budget = 'ORÇAMENTO';
  static const producers = 'PRODUTORAS';
  static const director = 'Diretor';
  static const overview = 'Descrição';
  static const noPosterURL = 'https://www.cer-cavalos.com/images/not_found.png';
  static const title = 'Filmes';
  static const search = 'Pesquise filmes';
}

class Colours {
  static const grade = Color(0xFF00384C);
  static const gray01 = Color(0xFF343A40);
  static const gray02 = Color(0xFF5E6770);
  static const gray03 = Color(0xFF868E96);
  static const gray07 = Color(0xFFE9ECEF);
  static const gray08 = Color(0xFFF1F3F5);
  static const grey = Color(0xFFf1f3f5);
  static const title = Color(0xFF343a40);
}

class TextStyles {
  static const textStyleBack = TextStyle(
      color: Colours.gray02, fontWeight: FontWeight.w500, fontSize: 12);
  static const textStyleTitle = TextStyle(color: Colours.title, fontSize: 20);
  static const textStyleMovieTitle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
  static const textStyleMovieCategory =
      TextStyle(color: Colors.white, fontSize: 10);
  static const genericSubject = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colours.gray02);
  static const genericData = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Colours.gray01);

}
