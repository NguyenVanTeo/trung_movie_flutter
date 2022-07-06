import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mt_movie/blocs/movie_bloc/movie_event.dart';
import 'package:mt_movie/blocs/movie_bloc/movie_state.dart';
import 'package:hive/hive.dart';
import 'package:mt_movie/screens/home_screen.dart';
import '../../models/movie_model.dart';
import '../../widgets/no_results_found.dart';
import '../blocs/movie_bloc/movie_bloc.dart';
import '../screens/home_screen.dart';
import '../widgets/vertical_list_cards.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  List<MovieModel> movies = [];
  @override
  void initState() {
    super.initState();
    _getMovieFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()..add(MovieData()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoaded) {
            return FavouriteScreenWidget(
              favouriteList: movies,
            );
          } else if (state is MovieError) {
            return const ErrorPage();
          } else if (state is MovieLoading) {
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

  Future<void> _getMovieFavourite() async{
    final movieList = await Hive.openBox<MovieModel>('favourite');
    movies = movieList.values.toList();
    await Hive.close();
  }
}

class FavouriteScreenWidget extends StatelessWidget {
  final List<MovieModel> favouriteList;
  const FavouriteScreenWidget({
    Key? key,
    required this.favouriteList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen()));
          },
        ),
        centerTitle: true,
        title: Text(
          'Favourites',
          //style: state.themeData.textTheme.headline5,
        ),
        //backgroundColor: state.themeData.primaryColor,
        actions: <Widget>[
          IconButton(
            //color: Color.red,
            icon: Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            VerticalListViewMovies(
              list: favouriteList,
            ),
            ],
        ),
      ),
    );
  }
}


