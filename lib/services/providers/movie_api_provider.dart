
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../../models/movie_model.dart';

import '../../abstracts/movie_service.dart';

import '../../common/globals.dart' as globals;

class MovieApiProvider extends MovieService {

 @override
  Future<List<MovieModel>> getMovieList( String name) async {
    final url = Uri.parse('${globals.movieAPI}$name?api_key=${globals.keyAPI}');
    http.Response response = await http.get(url);
    String json = response.body;
    Map<String, dynamic> mapJson = jsonDecode(json);
    if (response.statusCode == 200) {
      List<MovieModel> movieList = (mapJson['results'] as List).map((itemMovie) => MovieModel.fromJson(itemMovie)).toList();
      return movieList;
    } else {
      throw Exception('Failed to load feeds');
    }
  }

 @override
 Future<MovieDetailModel> getDetailMovie(String id) async {
   final url = Uri.parse('${globals.movieAPI}${id}?api_key=${globals.keyAPI}');
   http.Response response = await http.get(url);
   String json = response.body;
   Map<String, dynamic> mapJson = jsonDecode(json);
   if (response.statusCode == 200) {
     return  MovieDetailModel.fromJson(mapJson);
   } else {
     throw Exception('Failed to load feeds');
   }
 }

 // Save movie favourite to localstograge
 Future<void> addMovieFavourite(MovieModel movie) async {
   //await Hive.openBox('favourite');
   //final myBox = Hive.box('favourite');
   //Box<MovieModel> myBox = Hive.box<MovieModel>('favourite');
   Box<MovieModel> myBox= await Hive.openBox<MovieModel>('favourite');
   var itemLists = myBox.values.where((items) => items.id == movie.id).toList();
   if (itemLists.isEmpty) {
     await myBox.add(movie);
   }
   myBox.close();
   Hive.close();
  }


// them phim vao dnah sach yeu thich
Future<List<MovieModel>> getMovieFavourite() async {
   //await Hive.openBox('favourite');
  //final myBox = Hive.box('favourite');
  final myBox= await Hive.openBox<MovieModel>('favourite');
  List<MovieModel> movies = myBox.values.toList();
   myBox.close();
   Hive.close();
  return movies;
}

// xoa phim trong danh sach yeu thich
  Future<void> deleteMovieFavourite(MovieModel movie) async {
    await Hive.openBox('favourite');
    final myBox = Hive.box('favourite');
    var itemLists = myBox.values
        .where((items) => items.id == movie.id)
        .toList();
    await myBox.delete(itemLists[0].key);
    myBox.close();
    await Hive.close();
  }

// phim nam trong danh sach yeu thich hay khong?
 Future<bool> isFavourite(String id) async {
   bool result= false;
   var  myBox = await Hive.openBox<MovieModel>('favourite');
   List<MovieModel> movies = myBox.values
       .where((items) => items.id == id)
      .toList();
   if(movies.isNotEmpty) {
     result = true;
   }
   myBox.close();
   Hive.close();
   return result;
 }
}