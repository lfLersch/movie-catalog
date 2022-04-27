import 'package:flutter/material.dart';
import 'package:movie_catalog/components/poster-container.dart';

import '../Models/movie.dart';
import '../bloc/catalog-bloc.dart';
import '../constants.dart';

class CatalogScreen extends StatefulWidget {
  static const String id = 'catalog_screen';

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  var bloc = new CatalogBloc();
  bool loading = false;
  List<Movie> movies = [];

  @override
  void dispose() {
    bloc.movieNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.fromLTRB(35, 50,35,35),
          child: Column(
            children: [
              buildTitle(),
              buildspace(),
              buildSearchField(),
              buildspace(),
              if (loading) buildLoading() else buildPosters(),
            ],
          ),
        ),
      ),
    );
  }

  CircularProgressIndicator buildLoading() => CircularProgressIndicator();

  SizedBox buildspace() => const SizedBox(height: 30);

  Wrap buildPosters() {
    return Wrap(
        direction: Axis.vertical,
        spacing: 20,
        children: [for (var movie in bloc.movies) PosterContainer(movie)]);
  }

  TextField buildSearchField() {
    return TextField(
      onSubmitted: (value) async {
        setState(() {
          loading = true;
        });
        await bloc.searchMovies(value);
        setState(() {
          loading = false;
        });
      },
      textInputAction: TextInputAction.search,
      controller: bloc.movieNameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: Icon(Icons.search),
          filled: true,
          hintText: Strings.search,
          fillColor: Colours.grey),
    );
  }

  Align buildTitle() {
    return const Align(
        alignment: Alignment.centerLeft,
        child: Text(Strings.title, style: TextStyles.textStyleTitle));
  }
}
