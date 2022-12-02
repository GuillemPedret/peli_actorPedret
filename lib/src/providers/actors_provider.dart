import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:scooby_app/src/models/actor_model.dart';
import 'package:scooby_app/src/models/actors_model.dart';

class PeliculasProvider_actor {
  String _apikey = '57db077ea0d03d0610d00848933b8b9c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Actor_ind> _populares = [];

  final _popularesStreamController = StreamController<List<Actor_ind>>.broadcast();

  Function(List<Actor_ind>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Actor_ind>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Actor_ind>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Actores.fromJsonList(decodedData['results']);

    return peliculas.items;
  }



  Future<List<Actor_ind>> getEnCines() async {
    final url = Uri.https(_url, '3/person/popular', {'api_key': _apikey, 'language': _language}); // Pelicula
    print(url);
    return await _procesarRespuesta(url);

  }


  Future<List<Actor_ind>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/person/popular', {'api_key': _apikey, 'language': _language, 'page': _popularesPage.toString()});  // Pelicula
    final resp = await _procesarRespuesta(url);
    print(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<Actor> getBiography(String actorId) async {
    final url = Uri.https(_url, '3/person/$actorId', {'api_key': _apikey, 'language': _language});  // pelicula
    
    final resp = await http.get(url);
    print(url);


      Actor actor = await Actor.fromJsonMap(jsonDecode(resp.body));
      print(resp.body);

    return actor;
  }


  Future<List<Actor_ind>> buscarActor(String query) async {
    final url = Uri.https(_url, '3/search/person', {'api_key': _apikey, 'language': _language,'page': '1', 'query': query});  // Pelicula
    print(url);
    return await _procesarRespuesta(url);
  }
}
