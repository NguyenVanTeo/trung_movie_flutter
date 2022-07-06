import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//import '../animation.dart';
import '../constants.dart';
import '../screens/movie_detail_screen.dart';
import 'star_icon_display.dart';
import '../../common/globals.dart' as globals;

class MovieFavouriteCard extends StatelessWidget {
  final String poster;
  final String title;
  final String backdrop;
  final String releaseDate;
  final String id;
  final Color color;
  final bool isMovie;
  final double voteAverage;
  const MovieFavouriteCard({
    Key? key,
    required this.poster,
    required this.title,
    required this.backdrop,
    required this.releaseDate,
    required this.id,
    required this.color,
    required this.isMovie,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(id: id,
            history: 'favourite_screen',)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(boxShadow: kElevationToShadow[8]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 9 / 14,
                    child: CachedNetworkImage(
                      imageUrl:   globals.pathImage +poster,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: normalText.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: '+releaseDate,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: normalText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: color.withOpacity(.8),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        IconTheme(
                          data: const IconThemeData(
                            color: Colors.cyanAccent,
                            size: 20,
                          ),
                          child: StarDisplay(
                            value: ((voteAverage * 5)/10).round(),
                          ),
                        ),
                        Text(
                          "  " + voteAverage.toString() + "/10",
                          style: normalText.copyWith(
                            color: Colors.amber,
                            letterSpacing: 1.2,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

