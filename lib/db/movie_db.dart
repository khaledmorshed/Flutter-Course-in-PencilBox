import 'package:flutter/material.dart';

final movies = [
  Movie(
    id: 1,
    name: 'Avengers',
    category: 'Action/Sci-Fi',
    releaseYear: 2012,
    rating: 8.2,
    image: 'images/avengers.jpg',
  ),
  Movie(
      id: 2,
      name: 'Captain America',
      category: 'Action/Sci-Fi',
      releaseYear: 2011,
      rating: 8.3,
      image: 'images/captainamerica.jpg'),
  Movie(
      id: 3,
      name: 'Captain Marvel',
      category: 'Action/Sci-Fi',
      releaseYear: 2018,
      rating: 8.7,
      image: 'images/captainmarvel.jpg'),
  Movie(
      id: 4,
      name: 'Dr Strange',
      category: 'Action/Sci-Fi',
      releaseYear: 2017,
      rating: 7.5,
      image: 'images/drstrange.jpg'),
  Movie(
      id: 5,
      name: 'Iron Man',
      category: 'Action/Sci-Fi',
      releaseYear: 2008,
      rating: 8.4,
      image: 'images/ironman.jpg'),
  Movie(
      id: 6,
      name: 'Spider Man : Homecoming',
      category: 'Action/Sci-Fi',
      releaseYear: 2016,
      rating: 8.1,
      image: 'images/spiderman.jpeg'),
  Movie(
      id: 7,
      name: 'Thor',
      category: 'Action/Sci-Fi',
      releaseYear: 2009,
      rating: 8.0,
      image: 'images/thor.jpg'),
];

class Movie {
  int id;
  String name;
  String category;
  int releaseYear;
  double rating;
  String image;

  Movie({
    required this.id,
    required this.name,
    required this.category,
    required this.releaseYear,
    required this.rating,
    required this.image,
  });
}

const description = '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent condimentum magna augue, nec maximus urna auctor vulputate. Praesent sagittis dignissim tortor, at luctus massa porta vitae. Suspendisse potenti. Duis congue purus et nibh ultricies sodales. Donec ornare porttitor turpis eu facilisis. Sed scelerisque libero eu aliquam congue. Cras maximus nisl arcu, non pulvinar tellus ultrices vel. Nunc tincidunt quam vitae massa blandit, sit amet fringilla sapien dignissim. Mauris luctus posuere leo, ut tincidunt erat euismod vitae. Morbi vel odio eget metus aliquet tincidunt vitae in arcu. Pellentesque eu tincidunt augue. Nulla sed enim pharetra, ullamcorper nisi a, tempus magna. Pellentesque nulla nunc, ultricies porta commodo id, mollis sodales nibh. Praesent suscipit risus non risus blandit, et eleifend dolor vulputate. Morbi iaculis sodales commodo.

Maecenas molestie pretium magna non lobortis. Phasellus ullamcorper euismod lorem. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec sed elit interdum, lobortis magna vitae, sodales dui. Donec ultricies erat ut massa fermentum rhoncus. Fusce a erat magna. Integer interdum facilisis velit, non consectetur enim consectetur nec. Praesent at suscipit justo. Quisque laoreet in nunc in malesuada. Phasellus vitae arcu ac purus mollis scelerisque. Aenean tortor lorem, malesuada hendrerit ornare non, sodales vitae felis. Duis porttitor lacus quis ipsum lobortis, sit amet tincidunt lorem maximus. Phasellus cursus erat varius iaculis sagittis. Mauris vitae egestas enim. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.

Vivamus non lacinia quam. Nulla porttitor nulla non quam finibus, eleifend consequat nunc maximus. Proin id tincidunt felis, sed blandit felis. Nunc tellus eros, ultrices non leo a, iaculis viverra lacus. Mauris ipsum mauris, suscipit consectetur sagittis sed, tempus eu tortor. In hac habitasse platea dictumst. Nam semper placerat metus, vitae imperdiet dolor rutrum vitae. Sed scelerisque quam at rhoncus egestas. Proin a varius justo. Mauris leo turpis, imperdiet quis pretium eget, faucibus suscipit lorem. Sed a nisi vitae velit bibendum congue eu vitae urna. Donec porta elit libero, at aliquam nisi finibus at. Quisque malesuada sem nec velit egestas consequat.

Mauris pellentesque ultricies rutrum. Morbi eget nibh sed arcu rhoncus feugiat. Curabitur eu mauris a enim egestas semper et volutpat enim. Fusce tempor dolor sed mi suscipit, et congue enim vulputate. Nam vestibulum magna in libero pellentesque, eget pharetra dui blandit. Maecenas iaculis, urna ultricies aliquam condimentum, nunc lectus gravida risus, eu condimentum urna odio in lacus. Curabitur sit amet posuere nunc. Fusce facilisis consequat nisi, sed ornare libero hendrerit ut. Pellentesque tincidunt felis augue, et faucibus dui viverra et. Suspendisse tempor lacinia leo, eu ullamcorper neque facilisis quis. Vestibulum pulvinar augue lorem, id hendrerit dolor rutrum sodales. Ut pulvinar lacus sapien, et bibendum neque convallis vitae. Fusce erat massa, pharetra ut dapibus non, lobortis ac libero.

Maecenas condimentum laoreet sapien. Morbi ullamcorper orci in leo sodales fermentum. Cras tempus lobortis libero. Pellentesque non velit lorem. Ut sollicitudin massa libero, ut imperdiet leo congue ut. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed ultricies velit sed erat vestibulum elementum. Mauris condimentum, mauris sed facilisis placerat, ipsum ante tincidunt ligula, vitae tristique purus sapien sit amet dolor. Suspendisse potenti. Etiam condimentum, erat eu convallis ultrices, lacus nulla vulputate eros, non elementum quam enim et massa.''';
