import '../../models/movie_model.dart';

import '../providers/movie_api_provider.dart';

class MovieApiRepository {
  final _provider = MovieApiProvider();
  Future<List<MovieModel>> getMovieList(String name) {
    return _provider.getMovieList(name);
  }

  Future<MovieDetailModel> getDetailMovie(String id) {
    return _provider.getDetailMovie(id);
  }

  Future<void> addMovieFavourite(MovieModel movie) {
    return _provider.addMovieFavourite(movie);
  }

  Future<void> deleteMovieFavourite(MovieModel movie) {
    return _provider.deleteMovieFavourite(movie);
  }

  Future<List<MovieModel>> getFavouriteList() {
    return _provider.getMovieFavourite();
  }
  Future<bool> isFavourite(String id) {
    return _provider.isFavourite(id);
  }
}

class NetworkError extends Error {}