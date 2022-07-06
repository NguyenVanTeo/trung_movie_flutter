import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends HiveObject{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String poster;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String backdrop;
  @HiveField(4)
  final double voteAverage;
  @HiveField(5)
  final String releaseDate;
  @HiveField(6)
  final bool isFavourite;

  MovieModel({
    required this.title,
    required this.poster,
    required this.id,
    required this.backdrop,
    required this.voteAverage,
    required this.releaseDate,
    required this.isFavourite,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdrop: json['backdrop_path'] ,
      poster: json['poster_path'] ,
      id: json['id'].toString(),
      title: json['title'] ?? '',
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      releaseDate: json['release_date'] ,
      isFavourite: false,
    );
  }
}

class MovieDetailModel {
  final String title;
  final String poster;
  final String id;
  final String backdrop;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  bool isFavourite;
  MovieDetailModel({
    required this.title,
    required this.poster,
    required this.id,
    required this.backdrop,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.isFavourite,
  });

  set setFavourite(bool value){
    isFavourite=value;
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      backdrop: json['backdrop_path'] ,
      poster: json['poster_path'] ,
      id: json['id'].toString(),
      title: json['title'] ?? '',
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      releaseDate: json['release_date'] ,
      overview: json['overview'] ?? json['actors'] ?? '',
      isFavourite:json['adult'],
    );
  }
}
