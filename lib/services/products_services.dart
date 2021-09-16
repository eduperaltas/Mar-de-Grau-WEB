import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mardegrau/Model/products.dart';


class ProductsServices {
  String collection = "products";
  FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllProducts() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });
}
