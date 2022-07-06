import 'package:equatable/equatable.dart';
import '../../models/movie_model.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}
class MovieDetailLoading extends MovieDetailState {}
class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel movie;
  const MovieDetailLoaded({
    required this.movie,
  });
}
class MovieDetailError extends MovieDetailState {
  final String? message;
  const MovieDetailError(this.message);
}


