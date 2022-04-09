import 'package:flutter/material.dart';
import 'package:listview_stack_sliverwidget/db/movie_db.dart';
import 'package:listview_stack_sliverwidget/screens/listBuilderAndStack/movie_details.dart';

class MovieStack extends StatelessWidget {
  final Movie? movie;
  const MovieStack({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //GestureDetector and Inkwell for pressing..Inwek give a sound or responsive something but
      //but GestureDetector do not give, if you prees on GestureDetector just do it work without knowing
      //anything
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(movie: movie)));
        },
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            //in firts element will stay bellow and 2nd element stay 2nd bellow and so on.
            //here Text("${movie!.name}") will stay above of Image.asset()
            child: Stack(
              children: [
                Hero(
                  //here every widget tag must be different. after clicking this widget whe we 
                  //we will go that widget hero tag must be same
                  tag: movie!.id,
                  child: Image.asset("${movie!.image}",
                      width: double.infinity, height: 250, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 50,
                  //to make text in centre. have to take whole width of screen for this
                  //left 0 and rigt 0. now it takes whole width. now if textAlign make center
                  //then text will go centre.
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      color: Colors.black54,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${movie!.name}",
                          style: TextStyle(color: Colors.red, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: ElevatedButton(onPressed: () {}, child: Text("click")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
