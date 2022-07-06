import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/repositories/movie_api_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieApiRepository _apiRepository = MovieApiRepository();

  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) async {
      if (event is GetMovieDetailData) {
        emit(MovieDetailLoading());
        try {
          final movie = await _apiRepository.getDetailMovie(event.id);
          movie.isFavourite=await _apiRepository.isFavourite(event.id);
          emit(MovieDetailLoaded(movie: movie));
        } on NetworkError {
          emit(MovieDetailError("Failed to fetch data. is your device online?"));
        }
      }
    });
  }
}