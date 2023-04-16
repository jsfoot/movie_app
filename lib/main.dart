// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Movie App",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String popular = "popular";
  final String nowPlaying = "now-playing";
  final String comingSoon = "coming-soon";
  final String detailInfo = "movie?id=";

  void onMovieTap(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(id: id),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<MovieModel>> popMovieInstances = ApiService().getMovieModel(popular);
    final Future<List<MovieModel>> nowPlayingInstances = ApiService().getMovieModel(nowPlaying);
    final Future<List<MovieModel>> commingSoonInstances = ApiService().getMovieModel(comingSoon);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height + 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: const Text(
                    "Popular Movies",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: popMovieInstances,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final id = snapshot.data!.elementAt(index).id.toString();
                                return onMovieTap(id);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    width: 250,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      "https://image.tmdb.org/t/p/w500/${snapshot.data!.elementAt(index).posterPath}",
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: const Text(
                    "Now in Cinemas",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: nowPlayingInstances,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              final id = snapshot.data!.elementAt(index).id.toString();
                              return onMovieTap(id);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    "https://image.tmdb.org/t/p/w500/${snapshot.data!.elementAt(index).posterPath}",
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  width: 140,
                                  child: Text(
                                    snapshot.data!.elementAt(index).title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: const Text(
                    "Coming soon",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: commingSoonInstances,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              final id = snapshot.data!.elementAt(index).id.toString();
                              return onMovieTap(id);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    "https://image.tmdb.org/t/p/w500/${snapshot.data!.elementAt(index).posterPath}",
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  width: 140,
                                  child: Text(
                                    snapshot.data!.elementAt(index).title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieDetailInstance = ApiService().getMovieDetailModel(id);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: movieDetailInstance,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final String runtime =
                "${snapshot.data!['runtime'] ~/ 60}h ${snapshot.data!['runtime'] % 60}min";

            final List<String> genreList = [];
            final List<dynamic> genres = snapshot.data!['genres'];
            for (var genre in genres) {
              genreList.add(genre['name']);
            }
            final double rating = snapshot.data!['vote_average'];

            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500/${snapshot.data!['poster_path']}",
                      ),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.045,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "  Back to list",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!['original_title'],
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            for (var _ in [for (var i = 0; i < rating.toInt() ~/ 2; i++) i])
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            if (rating.toInt().isOdd)
                              const Icon(
                                Icons.star_half,
                                color: Colors.yellow,
                              ),
                            for (var _ in [for (var i = 0; i < (10 - rating.toInt()) ~/ 2; i++) i])
                              const Icon(
                                Icons.star,
                                color: Colors.grey,
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "$runtime | ",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5,
                              ),
                            ),
                            for (var genre in genreList)
                              Text(
                                '$genre, ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.5,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Text(
                            "Storyline",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 15,
                          child: Text(
                            '${snapshot.data!['overview']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: MediaQuery.of(context).size.width / 2 - 100,
                  child: Container(
                    width: 200,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Center(
                      child: Text(
                        "Buy ticket",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class MovieModel {
  final bool adult;
  final String? backdropPath;
  final List<dynamic> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final num voteAverage;
  final int voteCount;

  MovieModel(
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  );

  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        genreIds = json['genre_ids'],
        id = json['id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        releaseDate = json['release_date'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "backdrop_path": backdropPath,
      "genre_ids": genreIds,
      "id": id,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "release_date": releaseDate,
      "title": title,
      "video": video,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
  }
}

class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final Map? belongsToCollection;
  final int budget;
  final List<dynamic> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<Map<String, dynamic>> productionCompanies;
  final List<Map<String, dynamic>> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<Map<String, dynamic>> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final num voteAverage;
  final int voteCount;

  MovieDetailModel(
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  );

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        belongsToCollection = json['belongs_to_collection'],
        budget = json['budget'],
        genres = json['genres'],
        homepage = json['homepage'],
        id = json['id'],
        imdbId = json['imdb_id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        productionCompanies = json['production_companies'],
        productionCountries = json['production_countries'],
        releaseDate = json['release_date'],
        revenue = json['revenue'],
        runtime = json['runtime'],
        spokenLanguages = json['spoken_languages'],
        status = json['status'],
        tagline = json['tagline'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "backdrop_path": backdropPath,
      "belongs_to_collection": belongsToCollection,
      "budget": budget,
      "genres": genres,
      "homepage": homepage,
      "id": id,
      "imdb_id": imdbId,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "production_companies": productionCompanies,
      "production_countries": productionCountries,
      "release_date": releaseDate,
      "revenue": revenue,
      "runtime": runtime,
      "spoken_languages": spokenLanguages,
      "status": status,
      "tagline": tagline,
      "title": title,
      "video": video,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
  }
}

class ApiService {
  final baseUrl = "https://movies-api.nomadcoders.workers.dev";

  Future<List<MovieModel>> getMovieModel(String key) async {
    final List<MovieModel> movieInfoList = [];
    final url = Uri.parse('$baseUrl/$key');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movieJson = jsonDecode(response.body);
      final movies = movieJson['results'];

      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInfoList.add(instance);
      }

      return movieInfoList;
    }
    throw Error();
  }

  Future<Map> getMovieDetailModel(String id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movieDetail = jsonDecode(response.body);
      return movieDetail;
    }
    throw Error();
  }
}
