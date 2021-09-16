

import 'package:cloud_firestore/cloud_firestore.dart';
class opcion{
  String Oname;
  String Oselect;
  opcion({this.Oname,this.Oselect});
}

class  Product {
 String Pid;
 String Pname;
 String Pphoto;
 String Pdescription;
 double Pprice;
 String Pcategoria;
 int cantidad = 0;
 String comentarios;
 opcion Pop1;
 opcion Pop2;
 opcion Pop3;
 opcion Pop4;
 opcion Pop5;
 opcion Pop6;
 opcion Pop7;
 opcion Pop8;
 String get_op1;
 String get_op2;
 String get_op3;
 String get_op4;
 String get_op5;
 String get_op6;
 String get_op7;
 String get_op8;

 Product({
    this.Pid,
    this.Pname,
    this.Pphoto,
    this.Pdescription,
    this.Pprice,
    this.cantidad,
    this.comentarios,
    this.Pcategoria,
    this.Pop1,
    this.Pop2,
    this.Pop3,
    this.Pop5,
    this.Pop6,
    this.Pop7,
    this.Pop8,
    this.get_op1,
    this.get_op2,
    this.get_op3,
    this.get_op4,
    this.get_op5,
    this.get_op6,
    this.get_op7,
    this.get_op8,
  });

  String get name => Pname;
  String get id => Pid;
  String get photo => Pphoto;
  String get descripcion => Pdescription;
  double get precio => Pprice;
  String get categoria => Pcategoria;
  opcion get op1 => Pop1;
  opcion get op2 => Pop2;
  opcion get op3 => Pop3;
  opcion get op4 => Pop4;
  opcion get op5 => Pop5;
  opcion get op6 => Pop6;
  opcion get op7 => Pop7;
  opcion get op8 => Pop8;

  void printPlato(){
    print('----DETALLE DE PLATO----');
    print('nombre:'+name);
    print('id:'+id);
    print('foto:'+photo);
    print('desc:'+descripcion);
    print('categoria:'+categoria);
    print('cant:'+cantidad.toString());
    if(op1!=null)print('op1:'+op1.Oname+' '+op1.Oselect);
    if(op2!=null)print('op2:'+op2.Oname+' '+op2.Oselect);
    if(op3!=null)print('op3:'+op3.Oname+' '+op3.Oselect);
  }

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    Pdescription= snapshot['descripcion'];
    Pname= snapshot['nombre'];
    Pphoto= snapshot['foto'];
    Pprice= snapshot['precio'];
    Pid= snapshot['idprod'];
    Pcategoria= snapshot['categoria'];
  }

}