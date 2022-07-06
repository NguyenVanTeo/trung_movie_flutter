import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}
class GetMovieDetailData extends MovieDetailEvent {
  final String id;
  const GetMovieDetailData({
    required this.id,
  });
}