// class Product{
//   final String name;
//   final String image;
//   final double rating;
//   final double price;
//   final String vendor;
//   final bool wishlist;
//  final String details;
//
//   Product({this.details, this.name, this.image, this.rating,this.price, this.vendor, this.wishlist});
//
//
// }
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
class ProductModel{


  static const ID="id";
  static const NAME="name";
  static const RATING="rating";
  static const IMAGE="image";
  static const PRICE="price";
  static const RATE="rates";
  static const RESTAURANTID="restaurantId";
  static const RESTAURANT="restaurant";
  static const CATEGORY="category";
  static const FEATURED= "featured";
  static const DESCRIPTION= "description";


  String _id;
  String _name;
  double _rating;
  String _image;
  int _price;
  int _rates;
  int _restaurantId;
  String _restaurant;
  String _category;
  bool _featured;
  String _description;

   String get id => _id;
  String get name => _name;
  int get price=> _price;
  double get rating => _rating;
  String get image => _image;
  int get rates => _rates;
  int  get restaurantId  =>_restaurantId;
  String get restaurant => _restaurant;
  String get category => _category;
  bool get featured => _featured;
  String get description => _description;


  ProductModel.fromSnapshot(DocumentSnapshot snapshot)
  {
    _id=snapshot.get(ID);
    _name=snapshot.get(NAME);
    _price=snapshot.get(PRICE);
    _rating=snapshot.get(RATING);
    _image=snapshot.get(IMAGE);
    _rates=snapshot.get(RATE);
    _restaurantId=snapshot.get(RESTAURANTID);
    _restaurant=snapshot.get(RESTAURANT);
    _category=snapshot.get(CATEGORY);
    _featured =snapshot.get(FEATURED);
    _description=snapshot.get(DESCRIPTION);

  }



}