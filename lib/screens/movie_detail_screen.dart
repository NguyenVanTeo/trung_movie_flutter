
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mt_movie/blocs/detail_bloc/movie_detail_event.dart';
import 'package:mt_movie/blocs/detail_bloc/movie_detail_state.dart';
import '../blocs/detail_bloc/movie_detail_bloc.dart';
import '../../constants.dart';
import '../../models/movie_model.dart';
import '../widgets/no_results_found.dart';
import '../../common/globals.dart' as globals;

import 'package:favorite_button/favorite_button.dart';
import '../services/repositories/movie_api_repository.dart';
import 'movie_favourite_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  final String id;
  final String history;
  const MovieDetailScreen({
    Key? key,
    required this.id,
    required this.history,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc()..add(GetMovieDetailData(id: widget.id)),
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoaded) {
            return MovieDetailScreenWidget(
              movie: state.movie,
              history: widget.history,
            );
          } else if (state is MovieDetailError) {
            return const ErrorPage();
          } else if (state is MovieDetailLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade700,
                  strokeWidth: 2,
                  backgroundColor: Colors.cyanAccent,
                ),
              ),
            );
          }
          return const Scaffold();
        },
      ),
    );
  }
}


class MovieDetailScreenWidget extends StatelessWidget {
  final MovieDetailModel movie;
  final String history;
  const MovieDetailScreenWidget({
    Key? key,
    required this.movie,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: Text('Detail'),
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back,
            color: Colors.white),
            onPressed: () {
              if(history=='favourite_screen'){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
              } else{
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              globals.pathImage + (movie.poster),
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(),
                  child: Column(
                    children: [
                      Container(
                        width: 400.0,
                        height: 400.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${globals.pathImage}${movie.poster}',
                            ),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              offset: new Offset(2.0, 5.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                movie.title,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            Visibility(
                              visible: movie.voteAverage > 0,
                              child: Text(
                                '${movie.voteAverage}/10',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          movie.overview,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 150.0,
                              height: 60.0,
                              alignment: Alignment.center,
                              child: Text(
                                'Rate Movie',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xaa3C3261),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xaa3C3261)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.bookmark,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xaa3C3261)),
                            ),
                          )
                          ,FavoriteButton(
                            iconColor: Colors.pink,
                            isFavorite:  movie.isFavourite,
                            valueChanged: (isFavorite) {
                             var movieAdd = MovieModel(title: movie.title, poster: movie.poster, id: movie.id, backdrop: movie.backdrop, voteAverage: movie.voteAverage, releaseDate: movie.releaseDate,isFavourite: isFavorite);
                             clickFavourite(movieAdd,isFavorite);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // click icon favourite
  Future<void> clickFavourite(MovieModel movie, bool isFavorite) async {
    MovieApiRepository apiRepository = MovieApiRepository();
    if(isFavorite==true) {
      await apiRepository.addMovieFavourite(movie);
    }
    else{
      await apiRepository.deleteMovieFavourite(movie);
    }
  }

// Kiem tra co ton tai trong danh sach favourite Local
  Future<bool> getIsFavourite(String id) async{
  final MovieApiRepository apiRepository = MovieApiRepository();
  bool isFavorite= await apiRepository.isFavourite(id);
    return isFavorite;
  }
}