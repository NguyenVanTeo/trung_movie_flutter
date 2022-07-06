import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mt_movie/blocs/movie_bloc/movie_event.dart';
import 'package:mt_movie/blocs/movie_bloc/movie_state.dart';

import '../../models/movie_model.dart';
import '../../widgets/header_text.dart';
import '../../widgets/horizontal_list_cards.dart';
import '../../widgets/no_results_found.dart';
import '../blocs/movie_bloc/movie_bloc.dart';
import 'movie_favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc()..add(MovieData()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoaded) {
            return HomeScreenWidget(
              popularList: state.popularList,
              upcomingList: state.popularList,
              nowPlayingList: state.nowPlayingList,
              topRatedList: state.topRatedList,
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
}

class HomeScreenWidget extends StatelessWidget {
  final List<MovieModel> upcomingList;
  final List<MovieModel> popularList;
  final List<MovieModel> nowPlayingList;
  final List<MovieModel> topRatedList;
  const HomeScreenWidget({
    Key? key,
    required this.upcomingList,
    required this.popularList,
    required this.nowPlayingList,
    required this.topRatedList,
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
          },
        ),
        centerTitle: true,
        title: Text(
          'Movies',
          //style: state.themeData.textTheme.headline5,
        ),
        //backgroundColor: state.themeData.primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavouriteScreen()));
            },
          )
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 120,
            ),
            const HeaderText(text: "Upcoming"),
            HorizontalListViewMovies(
              list: upcomingList,
            ),
            const SizedBox(
              height: 14,
            ),
            const HeaderText(text: "Popular"),
            HorizontalListViewMovies(
              list: popularList,
            ),
            const SizedBox(
              height: 14,
            ),
            const HeaderText(text: "Now playing"),
            HorizontalListViewMovies(
              list: nowPlayingList,
            ),
            const SizedBox(
              height: 14,
            ),
            const HeaderText(text: "Top Rated"),
            HorizontalListViewMovies(
              list: topRatedList,
            )
          ],
        ),
      ),
    );
  }
}
