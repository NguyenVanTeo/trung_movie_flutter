import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/repositories/movie_api_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieApiRepository _apiRepository = MovieApiRepository();

  MovieBloc() : super(MovieInitial()) {
    on<MovieEvent>((event, emit) async {
      if (event is MovieData) {
        emit(MovieLoading());
        try {
              final popular = await _apiRepository.getMovieList('popular');
              final upcoming = await _apiRepository.getMovieList('upcoming');
              final nowPlaying = await _apiRepository.getMovieList('now_playing');
              final topRated = await _apiRepository.getMovieList('top_rated');
              emit(MovieLoaded(upcomingList: upcoming, popularList: popular,nowPlayingList:nowPlaying,topRatedList:topRated));
        } on NetworkError {
          emit(MovieError("Failed to fetch data. is your device online?"));
        }
      }
    });
  }
}