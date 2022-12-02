class Cast {
  List<Actor> actores = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  String biography;
  String profilePath;
  String name;
  Actor({
    this.profilePath,this.biography, this.name
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    biography = json['biography'];
    profilePath = json['profile_path'];
    name = json['name'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
