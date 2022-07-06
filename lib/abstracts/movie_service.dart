import '../models/movie_model.dart';

abstract class MovieService {
  Future<List<MovieModel>> getMovieList(String name);
  Future<MovieDetailModel> getDetailMovie(String id);
}