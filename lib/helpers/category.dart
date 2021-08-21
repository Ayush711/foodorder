// TODO Implement this library.import"package:cloud_firestore/cloud_firestore.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import"package:food_order/models/category.dart";


class CategoryServices{
  String collection="categories";
  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async => await _firestore.collection(collection).get().then((result) {
    List<CategoryModel> categories =[];
    for(DocumentSnapshot category in result.docs){
      categories.add(CategoryModel.fromSnapshot(category));
  }
    return categories;

  }
  );
}