import 'package:cloud_firestore/cloud_firestore.dart';

class car2 {
   String IMG1 = "img1";
   String IMG2 = "img2";
   String IMG3 = "img3";
   String IMG4 = "img4";
   String IMG5 = "img5";
   String IMG6 = "img6";


  String Cimg1="";
  String Cimg2="";
  String Cimg3="";
  String Cimg4="";
  String Cimg5="";
  String Cimg6="";
  car2({this.Cimg1, this.Cimg2,this.Cimg3,this.Cimg4,this.Cimg5,this.Cimg6});
//  getters
  String get img1 => Cimg1;
  String get img2 => Cimg2;
  String get img3 => Cimg3;
  String get img4 => Cimg4;
  String get img5 => Cimg5;
  String get img6 => Cimg6;

  // void setImMG1(String x){Cimg1=x;}

  car2.fromSnapshot(DocumentSnapshot snapshot) {
    Cimg1 = snapshot[IMG1];
    Cimg2 = snapshot[IMG2];
    Cimg3 = snapshot[IMG3];
    Cimg4 = snapshot[IMG4];
    Cimg5 = snapshot[IMG5];
    Cimg6 = snapshot[IMG6];
  }

}
