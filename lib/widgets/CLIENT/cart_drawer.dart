import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/Providers/cart_provider.dart';
import 'package:mardegrau/screens/ProductDetail.dart';
import 'package:flutter/material.dart';
import 'package:mardegrau/screens/Resume.dart';
import 'package:provider/provider.dart';

import 'ContadorProd.dart';
import 'auth_dialog.dart';

class CartDrawer extends StatefulWidget {
  const CartDrawer({
    Key key,
  }) : super(key: key);

  @override
  _CartDrawerState createState() => _CartDrawerState();
}
final List _isHovering = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];

class _CartDrawerState extends State<CartDrawer> {

Widget txtwdgop(String txt){
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        txt,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(221, 220, 210, 1.0)
        ),
      ),
    );
  }

Widget descripOop(Product plato){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Container(
      alignment: Alignment.topLeft,
      width: 400,
      height: 60,
      child: plato.Pop1!=null?Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          txtwdgop(plato.op1.Oname+': '+plato.op1.Oselect),
          plato.Pop2!=null?txtwdgop(plato.op2.Oname+': '+plato.op2.Oselect):Container(),
          plato.Pop3!=null?txtwdgop(plato.op3.Oname+': '+plato.op3.Oselect):Container(),
          plato.Pop4!=null?txtwdgop(plato.op4.Oname+': '+plato.op4.Oselect):Container(),
          plato.Pop5!=null?txtwdgop(plato.op5.Oname+': '+plato.op5.Oselect):Container(),
          plato.Pop6!=null?txtwdgop(plato.op6.Oname+': '+plato.op6.Oselect):Container(),
          plato.Pop7!=null?txtwdgop(plato.op7.Oname+': '+plato.op7.Oselect):Container(),
          plato.Pop8!=null?txtwdgop(plato.op8.Oname+': '+plato.op8.Oselect):Container(),
        ],
      ):
      txtwdgop(plato.descripcion),
    ),
  );
}

  Widget productcard(Product plato, int index) {
    final _CartProvider =
    Provider.of<CartProvider>(context, listen: false);
    var screenSize = MediaQuery.of(context).size;
    return Card(
      color:  Color.fromRGBO(80, 182, 187, 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Container(
            //color: Colors.black,
            height: 120,
            width:  90,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.network(
                plato.Pphoto,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[index] = true
                              : _isHovering[index] = false;
                        });
                      },
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => Products(screenSize: screenSize,plato: plato,),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              plato.Pname,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(221, 220, 210, 1.0)
                              ),
                            ),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[index],
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 2,
                                    width: 45,
                                    color:  Color.fromRGBO(223, 222, 211, 1.0),
                                  ),
                                ],
                              ),)
                          ],
                        ),
                      ),),

                    InkWell(
                      onTap: (){
                        _CartProvider.removeFromCatalog(plato);
                      },
                      child: Icon( LineIcons.trash,
                        size: 16,
                        color: Colors.red),
                    )
                  ],
                ),
                descripOop(plato),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Contador(size: 'cart',plato: plato.name,),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        'S/.'+(plato.Pprice*plato.cantidad).toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(221, 220, 210, 1.0)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

  }


  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    final _CartProvider =
    Provider.of<CartProvider>(context, listen: false);
    var screenSize = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Color.fromRGBO(80, 182, 187, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Mis pedidos',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 22,
                      // fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: Container(
                      color:Color.fromRGBO(223, 222, 211, 1.0),
                      height: 0.7,
                    ),
                  ),
                ],
              ),
              _CartProvider.cart.length>0?Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _CartProvider.cart.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return productcard(_CartProvider.cart[index],index);
                  },
                ),
              )
                  :Column(
                children: [
                  Center(
                      child:Container(
                          height: screenSize.height*0.4,
                          child: Image(image: AssetImage('assets/images/empty_cart.png')))
                  ),
                  Text(
                    'Aún no has agregado un plato',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 16,
                      // fontFamily: 'Montserrat',
                      // letterSpacing: 3,
                    ),
                  ),
                ],
              ),

              _CartProvider.cart.length>0?Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: Container(
                      color:Color.fromRGBO(223, 222, 211, 1.0),
                      height: 0.7,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: const Icon( LineIcons.receipt,
                              size: 16,
                              color: Color.fromRGBO(223, 222, 211, 1.0),),
                          ),
                          Text('Total: ${context.watch<CartProvider>().total()}',style: TextStyle(
                            color: Color.fromRGBO(223, 222, 211, 1.0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: Container(
                      color:Color.fromRGBO(223, 222, 211, 1.0),
                      height: 0.7,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(80, 182, 187, 0.6),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => DatosCompra(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Pagar', style:
                            TextStyle(
                              color: Color.fromRGBO(223, 222, 211, 1.0),
                              fontSize: 18,
                              // fontFamily: 'Montserrat',
                              // letterSpacing: 3,
                            ),),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: const Icon( LineIcons.shoppingCart,
                                size: 20,
                                color: Color.fromRGBO(223, 222, 211, 1.0),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
