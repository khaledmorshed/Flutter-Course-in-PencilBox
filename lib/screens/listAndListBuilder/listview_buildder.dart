import 'package:flutter/material.dart';
import 'package:listview_stack_sliverwidget/db/movie_db.dart';

import '../listBuilderAndStack/stack_listview_builder.dart';

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const StackListViewBuilder()));
        },
        child: Text("click"),
      ),
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
            return ListTile(
              title: Text("${movieObject.name}"),
              subtitle: Text("${movieObject.category}"),
            );
          }),
    );
  }
}
