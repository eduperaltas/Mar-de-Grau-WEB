import 'package:flutter/material.dart';
import 'package:mardegrau/Model/Product.dart';

class ProductProvider with ChangeNotifier {

  Product _plato = new Product();
  Product get plato => _plato;

  void platoinicial(Product pla){
    _plato=pla;
    notifyListeners();
  }

  void selectopcion(opcion opc,int numberop){
    if(numberop==1)plato.Pop1=opc;
    if(numberop==2)plato.Pop2=opc;
    if(numberop==3)plato.Pop3=opc;
    if(numberop==4)plato.Pop4=opc;
    if(numberop==5)plato.Pop5=opc;
    if(numberop==6)plato.Pop6=opc;
    if(numberop==7)plato.Pop7=opc;
    if(numberop==8)plato.Pop8=opc;
    notifyListeners();
  }

}