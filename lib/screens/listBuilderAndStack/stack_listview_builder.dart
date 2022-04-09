import 'package:flutter/material.dart';
import 'package:listview_stack_sliverwidget/db/movie_db.dart';
import 'package:listview_stack_sliverwidget/screens/listBuilderAndStack/movie_stack.dart';

class StackListViewBuilder extends StatelessWidget {
  const StackListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView.builder"),
      ),
      //it iterate all collection here is named movies one by one also give the that
      //collection
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          //here moveies is collection so we need movie object
          final movieObject = movies[index];
          return MovieStack(movie: movieObject);
        },
      ),
    );
  }
}
