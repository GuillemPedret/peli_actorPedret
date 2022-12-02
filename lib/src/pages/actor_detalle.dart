import 'package:flutter/material.dart';

import 'package:scooby_app/src/models/actor_model.dart';
import 'package:scooby_app/src/models/actors_model.dart';

import 'package:scooby_app/src/providers/actors_provider.dart';

import '../../src_movie/providers/peliculas_provider.dart';
import '../../src_movie/widgets/movie_horizontal.dart';

class ActorDetalle extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider_actor();


  @override
  Widget build(BuildContext context) {
    final Actor_ind pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _valoracio(context, pelicula),
            _descripcion(pelicula),
            _footer(context, pelicula),
          ]),
        )
      ],
    ));
  }

  Widget _crearAppbar(Actor_ind pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.redAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage("https://image.tmdb.org/t/p/w500" + pelicula.posterPath),
          //image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          //fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _valoracio(BuildContext context, Actor_ind pelicula) {
    return Container(
      padding: EdgeInsets.only(left: 0),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 0.0),
            child:
                Row(
                  children: <Widget>[Icon(Icons.star_border, size: 25), Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.bodyText1, textScaleFactor: 1.2)],
                )
          )
        ],
      ),
    );
  }


  Widget _descripcion(Actor_ind actor_id) {
    return FutureBuilder(
      future: peliculasProvider.getBiography(actor_id.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<Actor> snapshot){
        if(snapshot.hasData){
          Actor actor = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(15),
                    child:
                          Text(actor.biography),
                          );

        }else {
          return Center(child: CircularProgressIndicator());
        }
      },

    );
  }


  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(padding: EdgeInsets.only(left: 20.0), child: Text('Populares', style: Theme.of(context).textTheme.bodyText1)),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }


}
