import 'package:flutter/material.dart';

//import '../animation.dart';
import '../models/movie_model.dart';
import 'movie_card_for_vertical.dart';


class VerticalListViewMovies extends StatelessWidget {
  final List<MovieModel> list;
  final Color? color;
  const VerticalListViewMovies({
    Key? key,
    required this.list,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: 310,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 14),
            for (var i = 0; i < list.length; i++)

              MovieFavouriteCard(
                isMovie: true,
                id: list[i].id,
                title: list[i].title,
                backdrop:  list[i].backdrop,
                poster: list[i].poster,
                color: color == null ? Colors.white : color!,
                releaseDate: list[i].releaseDate,
                voteAverage: list[i].voteAverage,
              )
          ],
        ));
  }
}



