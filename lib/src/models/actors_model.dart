import 'dart:convert';

class Actores {
  List<Actor_ind> items = [];

  Actores();

  Actores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Actor_ind.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Actor_ind {
  String uniqueId;

  int voteCount;
  int id;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String name;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Actor_ind({
    this.voteCount,
    this.id,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.name,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Actor_ind.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    id = json['id'];
    voteCount = json['known_for'][0]['vote_count'];

    voteAverage = json['known_for'][0]['vote_average']/1 ;
    title = json['name'];   // Pelicula
    popularity = json['known_for'][0]['popularity'] ;
    posterPath = json['profile_path'];
    originalLanguage = json['known_for'][0]['original_language'];
    name = json['name'];  // Pelicula
    genreIds = json['known_for'][0]['genre_ids'].cast<int>();
    backdropPath = json['known_for'][0]['backdrop_path'];

    overview = json['known_for'][0]['overview'];
    releaseDate = json['known_for'][0]['release_date'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-auu4kfi2d9/stencil/59512910-bb6d-0136-46ec-71c445b85d45/e/933395a0-cb1b-0135-a812-525400970412/icons/icon-no-image.svg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
