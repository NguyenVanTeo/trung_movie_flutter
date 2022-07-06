import 'package:flutter/material.dart';

//import '../animation.dart';
import '../models/movie_model.dart';
import 'movie_card.dart';


class HorizontalListViewMovies extends StatelessWidget {
  final List<MovieModel> list;
  final Color? color;
  const HorizontalListViewMovies({
    Key? key,
    required this.list,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 310,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 7),
            for (var i = 0; i < list.length; i++)
              MovieCard(
                isMovie: true,
                id: list[i].id,
                name: list[i].title,
                backdrop:  list[i].backdrop,
                poster: list[i].poster,
                color: color == null ? Colors.white : color!,
                date: list[i].releaseDate,
                 onTap: () {
                //   pushNewScreen(
                //     context,
                //     MovieDetailsScreen(
                //       id: list[i].id,
                //       backdrop: list[i].backdrop,
                //     ),
                //   );
                //
                },
              )
          ],
        ));
  }
}



