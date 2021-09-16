import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mardegrau/Model/categories.dart';

class CategoriesServices {
  String collection = "categories";
  final Future<FirebaseApp> initialization = Firebase.initializeApp();

  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;


  Future<List<CategoriesModel>> getAll() async =>
      firebaseFiretore.collection(collection).get().then((result) async{
        List<CategoriesModel> categories = [];
        for (DocumentSnapshot category in result.docs)  {
          categories.add(CategoriesModel.fromSnapshot(category));
        }
        return categories;
      });

  Stream<List<CategoriesModel>> get getDataStreamSnapshots  {
    List<CategoriesModel> categories = [];
    firebaseFiretore.collection(collection).snapshots().listen((data) {
      data.docs.forEach((doc) => categories.add(CategoriesModel.fromSnapshot(doc)) );
      /*data.docs.forEach((doc) => print(doc['titulo']) );*/
    });
  }


}
