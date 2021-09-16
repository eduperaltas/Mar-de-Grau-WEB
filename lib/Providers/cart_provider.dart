import 'package:flutter/material.dart';
import 'package:mardegrau/Model/Product.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cart = [];

  List<Product> get cart => _cart;

  String  get cant_cart {
    int cant=0;
    for(int i =0; i<_cart.length; i++){
      cant=cant+_cart[i].cantidad;
    }
    cant.toString();
  }

  String total(){
    var total=0.0;
    for(int i =0; i<_cart.length; i++){
      total=total+(_cart[i].Pprice*_cart[i].cantidad);
    }
    String resultado='S/. '+ total.toStringAsFixed(2);
    return resultado;
  }

  void modificarPedido(String npedido,String action,int cant){
    int index =_cart.indexWhere((e) => e.Pname==npedido);
    if(action=='menos')_cart[index].cantidad-=cant;
    if(action=='mas')_cart[index].cantidad+=cant;
    notifyListeners();
  }

  void addToCatalog(Product plato, int cant) {
    int index =_cart.indexWhere((e) => e.Pname==plato.Pname);
    if(index>=0 && _cart[index].Pname==plato.name){
      _cart[index].cantidad+=cant;
      plato.printPlato();
    }
    else{
      if(plato.cantidad==null)plato.cantidad=cant;
      _cart.add(plato);
    }
    cart[0].printPlato();
    notifyListeners();
  }

  void removeFromCatalog(Product plato) {
    _cart.remove(plato);
    notifyListeners();
  }

}