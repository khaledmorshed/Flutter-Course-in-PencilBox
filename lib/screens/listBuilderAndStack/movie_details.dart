import 'package:flutter/material.dart';
import 'package:listview_stack_sliverwidget/db/movie_db.dart';

class MovieDetails extends StatelessWidget {
  final Movie? movie;
  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //appbar will not disapper
            pinned: true,
            //when scroll down star then image will start showing
            floating: true,
            expandedHeight: 300,
            title: Text(movie!.name),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: movie!.id,
                child: Image.asset(
                  movie!.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //to give parrallel effect.it means when we scroll appbar will start disappper gradually
          SliverList(
              delegate: SliverChildListDelegate([
            ListTile(
              title: Text("${movie!.name}"),
              subtitle: Text("${movie!.category}"),
              trailing: Text("${movie!.rating}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(description),
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }
}

class ListVieDetails extends StatelessWidget {
  const ListVieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Hero(
          tag: movie!.id,
          child: Image.asset(
            movie!.image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        ListTile(
          title: Text("${movie!.name}"),
          subtitle: Text("${movie!.category}"),
          trailing: Text("${movie!.rating}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
            ),
          ),
        ),
      ],
    );
  }
}
