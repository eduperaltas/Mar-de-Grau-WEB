import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mardegrau/widgets/CLIENT/list-buttons.dart';

class ProductModel {
  static const NOMBRE = "nombre";
  static const FOTO = "foto";
  static const PRECIO = "precio";
  static const DESCRIPCION = "descripcion";
  static const CATEGORIA = "categoria";


  String Pname;
  String Ppicture;
  String Pdescription;
  String Pcategoria;
  String Pid;
  double Pprice;
  List<radioButton> lopciones;

  ProductModel({this.Pcategoria,this.Pname,this.Pdescription,this.Ppicture,
    this.Pprice,this.lopciones,this.Pid});
  
  String get name => Pname;

  String get picture => Ppicture;

  String get id => Pid;

  String get description => Pdescription;
  
  String get categoria => Pcategoria;

  double get price => Pprice;

  List<radioButton> get opciones => lopciones;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Pdescription = snapshot[DESCRIPCION] ?? " ";
    Pprice = double.parse(snapshot[PRECIO]) ;
    Pname = snapshot[NOMBRE];
    Ppicture = snapshot[FOTO];
    Pcategoria = snapshot[CATEGORIA];
    Pid = snapshot['idprod'];
  }
}
