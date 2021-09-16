import 'package:flutter/material.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/Providers/cart_provider.dart';
import 'package:mardegrau/Providers/product_provider.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:provider/provider.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

int cant = 1;


class Contador extends StatelessWidget {
  Contador({
     this.size,
    this.plato
  }) ;
  final String size;
  final String plato;
  @override
  Widget build(BuildContext context) {
    return QuantitySelection(size: size,plato:plato);
  }
  int getcont(){
    return cant;
  }

}

class QuantitySelection extends StatefulWidget {
  QuantitySelection({
    this.size,
    this.plato
  }) ;
  final String size;final String plato;
  @override
  _QuantitySelectionState createState() => _QuantitySelectionState();


}

class _QuantitySelectionState extends State<QuantitySelection> {
  final int limitSelectQuantity;
  final double width;
  final double height;
  final Function onChanged;
  final Color color;
  int carcant = 1;

  _QuantitySelectionState(
      {
        this.width = 160.0,
        this.height = 42.0,
        this.limitSelectQuantity = 15,
        this.color,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final _CartProvider =
    Provider.of<CartProvider>(context, listen: false);
    Product pedido;

    final _ProducProvider =
    Provider.of<ProductProvider>(context, listen: false);

     int index =_CartProvider.cart.indexWhere((e) => e.Pname==widget.plato);
     if(widget.plato!=null && index>=0){
       pedido =_CartProvider.cart[index];
       carcant=_CartProvider.cart[index].cantidad;
     }
     if(index==-1)carcant=1;

    return widget.size =='cart'?new Container(
      height: 30,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
              child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Container(
                width:30,
                height:30,
                child: FloatingActionButton(
                  hoverElevation: 1.5,
                  shape: CircleBorder(
                      side: BorderSide(
                          color: carcant==1?Color.fromRGBO(223, 222, 211, 0.6):
                            Color.fromRGBO(223, 222, 211, 1.0) , width: 2)),
                  onPressed: () {
                    setState(() {
                      carcant--;
                      if(carcant>=1){
                      _CartProvider.modificarPedido(pedido.Pname, 'menos',1);
                      }
                    });
                  },
                  child: Text('-',style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:carcant==1?Color.fromRGBO(223, 222, 211, 0.6):
                      Color.fromRGBO(223, 222, 211, 1.0)),),
                  backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    carcant.toString(),
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color:Color.fromRGBO(223, 222, 211, 1.0) ),
                  ),
                ),
              ),

              Container(
                width:30,
                height:30,
                child: FloatingActionButton(
                  hoverElevation: 1.5,
                  shape: CircleBorder(
                      side: BorderSide(
                          color: carcant==15?Color.fromRGBO(223, 222, 211, 0.6):
                          Color.fromRGBO(223, 222, 211, 1.0) , width: 2)),
                  onPressed: () {
                    setState(() {
                      carcant++;
                      if(carcant<=15){
                        _CartProvider.modificarPedido(pedido.Pname, 'mas',1);
                      }
                    });
                  },
                  child: Text('+',style: TextStyle(fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color:carcant==15?Color.fromRGBO(223, 222, 211, 0.6):
                                                  Color.fromRGBO(223, 222, 211, 1.0)),),
                  backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
                ),
              ),

          ],
        ),
            )
      ),
    )
        :new Container(
      height: height,
      width: screenSize.width<736
          ?screenSize.width/2.5:width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: screenSize.width<736
            ?Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width:40,
                height:40,
                child: FloatingActionButton(
                  hoverElevation: 1.5,
                  shape: CircleBorder(
                      side: BorderSide(
                          color: cant==1?Color.fromRGBO(223, 222, 211, 0.6):
                          Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                  onPressed: () {
                    setState(() {
                      if(cant>1){
                        cant--;
                      }
                    });
                  },
                  child: Text('-',style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:cant==1?Color.fromRGBO(223, 222, 211, 0.6):
                      Color.fromRGBO(223, 222, 211, 1.0)),),
                  backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    cant.toString(),
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color:Color.fromRGBO(223, 222, 211, 1.0) ),
                  ),
                ),
              ),

              Container(
                width:40,
                height:40,
                child: FloatingActionButton(
                  hoverElevation: 1.5,
                  shape: CircleBorder(
                      side: BorderSide(
                          color: cant==15?Color.fromRGBO(223, 222, 211, 0.6):
                          Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                  onPressed: () {
                    setState(() {
                      if(cant<15){
                        cant++;
                      }
                    });
                  },
                  child: Text('+',style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:cant==15?Color.fromRGBO(223, 222, 211, 0.6):
                      Color.fromRGBO(223, 222, 211, 1.0)),),
                  backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
                ),
              ),

            ],
          ),
        )
            :Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              hoverElevation: 1.5,
              shape: CircleBorder(
                  side: BorderSide(
                      color: cant==1?Color.fromRGBO(223, 222, 211, 0.6):
                      Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
              onPressed: () {
                setState(() {
                  if(cant>1){
                    cant--;
                  }
                });
              },
              child: Text('-',style: TextStyle(fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color:cant==1?Color.fromRGBO(223, 222, 211, 0.6):
                  Color.fromRGBO(223, 222, 211, 1.0)),),
              backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
            ),

            Expanded(
              child: Center(
                child: Text(
                  cant.toString(),
                  style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold, color:Color.fromRGBO(223, 222, 211, 1.0) ),
                ),
              ),
            ),

            FloatingActionButton(
              hoverElevation: 1.5,
              shape: CircleBorder(
                  side: BorderSide(
                      color: cant==15?Color.fromRGBO(223, 222, 211, 0.6):
                      Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
              onPressed: () {
                setState(() {
                  if(cant<15){
                    cant++;
                  }
                });
              },
              child: Text('+',style: TextStyle(fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color:cant==15?Color.fromRGBO(223, 222, 211, 0.6):
                  Color.fromRGBO(223, 222, 211, 1.0)),),
              backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
            ),

          ],
        ),
      ),
    );
  }
}