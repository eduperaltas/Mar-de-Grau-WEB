import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  static const String TITULO = "titulo";
  static const String IMG = "img";

  String Ctitulo;
  String Cimg;
  String uid;
  CategoriesModel({this.Ctitulo, this.Cimg,this.uid});
//  getters
  String get titulo => Ctitulo;
  String get img => Cimg;

  CategoriesModel.fromSnapshot(DocumentSnapshot snapshot) {
    Ctitulo = snapshot[TITULO];
    Cimg = snapshot[IMG];
    uid= snapshot.id;

  }

}
