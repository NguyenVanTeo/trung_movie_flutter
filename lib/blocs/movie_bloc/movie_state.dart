import 'package:equatable/equatable.dart';
import '../../models/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}
class MovieLoading extends MovieState {}
class MovieLoaded extends MovieState {
  final List<MovieModel> upcomingList;
  final List<MovieModel> popularList;
  final List<MovieModel> nowPlayingList;
  final List<MovieModel> topRatedList;

  const MovieLoaded({
    required this.upcomingList,
    required this.popularList,
    required this.nowPlayingList,
    required this.topRatedList,
  });
}

class MovieError extends MovieState {
  final String? message;
  const MovieError(this.message);
}