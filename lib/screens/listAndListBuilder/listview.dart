import 'package:flutter/material.dart';
import 'package:listview_stack_sliverwidget/db/movie_db.dart';

import 'listview_buildder.dart';


class MovieList extends StatelessWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("movie list with only listView"),
      ),
      //list actually static. can be used insted of column
      //but can be converted into dynamic like bellow
      //because we have collection named movies so every collection cab be converted
      //into map. here map run loop inside of collection and retreive object
      //from movies list one by one
      body: ListView(
        children: movies.map((movieObject) {
          return ListTile(
            title: Text("${movieObject.name}"),
            subtitle: Text("${movieObject.category}"),
            leading: Image.asset(movieObject.image, width: 50, height: 50, fit: BoxFit.cover,),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListViewBuilder()));
          },
          child: Text("click")),
    );
  }
}
