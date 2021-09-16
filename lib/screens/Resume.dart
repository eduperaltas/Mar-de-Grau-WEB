import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mardegrau/Model/Pedido.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/Providers/cart_provider.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:mardegrau/widgets/CLIENT/FrmFacturacion.dart';
import 'package:mardegrau/widgets/CLIENT/FrmPago.dart';
import 'package:mardegrau/widgets/CLIENT/bottom_bar.dart';
import 'package:mardegrau/widgets/CLIENT/cart_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/explore_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/featured_heading.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:mardegrau/widgets/CLIENT/top_bar_contents.dart';
import 'package:provider/provider.dart';
import 'package:mardegrau/utils/authentication.dart';
import 'package:mardegrau/widgets/CLIENT/auth_dialog.dart';

class DatosCompra extends StatefulWidget {
  @override
  _DatosCompra createState() => _DatosCompra();
}

class _DatosCompra extends State<DatosCompra> {


  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;
  final _formKey = GlobalKey<FormState>();
  String _direccion,_nro,_detdirec,_name,_apellidos,_dni,_telefono,_email,_distrito;
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }
  var _currentSelectedValue;
  var _currencies = [
    "Santiago de Surco",
    "Surquillo",
    "Miraflores",
    "San Borja",
    "San Isidro"
  ];

  Widget drop() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Center(
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelText: 'DISTRITO',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'DISTRITO',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              isEmpty: _currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _currentSelectedValue = newValue;
                      state.didChange(newValue);
                      print(_currentSelectedValue.toString());
                      _distrito=_currentSelectedValue.toString();
                    });
                  },
                  items: _currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }
  Widget txtwdgop(String txt){
    return  Container(
      alignment: Alignment.topLeft,
      child: Text(txt,
          style: TextStyle(
              color: Colors.black,
              fontSize: 12)),
    );
  }
  Widget opcionesresumen(Product pedido){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
          alignment: Alignment.topLeft,
        child:pedido.Pop1!=null?Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            txtwdgop(pedido.op1.Oname+': '+pedido.op1.Oselect),
            pedido.Pop2!=null?txtwdgop(pedido.op2.Oname+': '+pedido.op2.Oselect):Container(),
            pedido.Pop3!=null?txtwdgop(pedido.op3.Oname+': '+pedido.op3.Oselect):Container(),
            pedido.Pop4!=null?txtwdgop(pedido.op4.Oname+': '+pedido.op4.Oselect):Container(),
            pedido.Pop5!=null?txtwdgop(pedido.op5.Oname+': '+pedido.op5.Oselect):Container(),
            pedido.Pop6!=null?txtwdgop(pedido.op6.Oname+': '+pedido.op6.Oselect):Container(),
            pedido.Pop7!=null?txtwdgop(pedido.op7.Oname+': '+pedido.op7.Oselect):Container(),
            pedido.Pop8!=null?txtwdgop(pedido.op8.Oname+': '+pedido.op8.Oselect):Container(),
          ],
        ): Container()
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final _CartProvider =
    Provider.of<CartProvider>(context, listen: false);
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    String _chosenValue;

    return Scaffold(
      backgroundColor:  Color.fromRGBO(80, 182, 187, 1.0),
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(80, 182, 187, _opacity),
        elevation: 0,
        centerTitle: true,
        title: Container(
          child: SizedBox(
            height: 120,
            width: 130,
            child: Image.asset(
              'assets/images/promo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (context){
              return Padding(
                padding: const EdgeInsets.all( 8.0),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child:  Stack(
                    children: [
                      new Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            width: 20,
                            height: 25,
                            child: Center(
                              child: Text(
                                '${context.watch<CartProvider>().cart.length}',
                                style: TextStyle(
                                  fontSize: 10,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                ),),
                            ),
                          ),
                        ),
                        top: 18.0,
                        left: 25.0,
                      ),
                      Container(

                          child: Image.asset('assets/images/barco.png',
                              width: 70,
                              height: 50,
                              fit:BoxFit.fill  ))
                    ],
                  ),
                ),
              );
            },
          )
        ],
      )
          : PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(_opacity),
      ),
      drawer: ExploreDrawer(),
      endDrawer: CartDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: screenSize.height  * 0.15),
            FeaturedHeading(screenSize: screenSize,title: 'Resumen de Compra',subtitle: ' ',),
            Stack(
              children: [
                ResponsiveWidget.isSmallScreen(context)?
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 60,
                  ),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child:Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'DIRECCION DE ENTREGA:',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  // fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  // letterSpacing: 3,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.streetAddress,
                                                        decoration: InputDecoration(
                                                          labelText: 'Dirección de calle',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          //hintText: 'Enter a Phone Number',
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        validator: (input)=> input!=null ? 'Introduce dirección' : null,
                                                        onChanged: (input) {
                                                          setState(() => _direccion = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                                drop(),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                          labelText: 'Nro./Mz',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          //hintText: 'Enter a Phone Number',
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        validator: (input)=> input!=null ? 'Introduce numero' : null,
                                                        onChanged: (input) {
                                                          setState(() => _nro = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.streetAddress,
                                                        decoration: InputDecoration(
                                                          labelText: 'Mas detalles de la direccion',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          //hintText: 'Enter a Phone Number',
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        //validator: (input)=> input!=null ? 'Introduce numero' : null,
                                                        onChanged: (input) {
                                                          setState(() => _detdirec = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'INGRESA INFROMACIÓN ADICIONAL:',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  // fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  // letterSpacing: 3,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.name,
                                                        decoration: InputDecoration(
                                                          labelText: 'Nombre',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          //hintText: 'Enter a Phone Number',
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        validator: (input)=> input!=null ? 'Introduce tu nombre' : null,
                                                        onChanged: (input) {
                                                          setState(() => _name = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.name,
                                                        decoration: InputDecoration(
                                                          labelText: 'Apellidos',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          //hintText: 'Enter a Phone Number',
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        validator: (input)=> input!=null ? 'Introduce tus apellidos' : null,
                                                        onChanged: (input) {
                                                          setState(() => _apellidos = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                          labelText: 'DNI',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        //validator: (input)=> input!=null ? 'Introduce numero' : null,
                                                        onChanged: (input) {
                                                          setState(() => _dni = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                          labelText: 'Número de Télefono',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          //hintText: 'Enter a Phone Number',
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        validator: (input)=> input!=null ? 'Introduce tu número de telefono' : null,
                                                        onChanged: (input) {
                                                          setState(() => _telefono = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                  child: Center(
                                                    child: TextFormField(
                                                        cursorColor: Colors.black,
                                                        keyboardType: TextInputType.emailAddress,
                                                        decoration: InputDecoration(
                                                          labelText: 'Dirección de e-mail',
                                                          labelStyle: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                          //hintText: 'Enter a Phone Number',
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.black
                                                              )
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide()
                                                          ),
                                                        ),
                                                        validator: (input)=> input!=null ? 'Introduce tu e-mail' : null,
                                                        onChanged: (input) {
                                                          setState(() => _email = input);
                                                        }

                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'METODOS DE PAGO:',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  // fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  // letterSpacing: 3,
                                                ),
                                              ),
                                            ),
                                            metodosdePago()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'FACTURACION:',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  // fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  // letterSpacing: 3,
                                                ),
                                              ),
                                            ),
                                            Facturacion()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //checkBox(),
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'RESUMEN DE LA ORDEN',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                      child: Container(
                                        color:Colors.black,
                                        height: 0.7,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: _CartProvider.cart.length,
                                      itemBuilder: (BuildContext ctxt, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(_CartProvider.cart[index].cantidad.toString()+
                                                    'x   '+_CartProvider.cart[index].Pname,
                                                    style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: Text(_CartProvider.cart[index].Pprice.toString(),
                                                    style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                              ),
                                              opcionesresumen(_CartProvider.cart[index])
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                      child: Container(
                                        color:Colors.black,
                                        height: 0.7,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('TOTAL',style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        Text('${context.watch<CartProvider>().total()}',style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Color.fromRGBO(80, 182, 187, 1.0),
                              onPressed: (){
                                Pedido pedido = new Pedido(
                                  ordenes: _CartProvider.cart,
                                  name: _name,
                                  apellidos: _apellidos,
                                  dni: _dni,
                                  direccion: _direccion + ' '+_nro+', '+_distrito,
                                  detdir: _detdirec,
                                  email: _email,
                                  telefono: _telefono,
                                  metPago: metodosdePago().metodo(),
                                  efectivo:  metodosdePago().efectivoacancelar(),
                                  metFact: Facturacion().metFact(),
                                  razSoc: Facturacion().razSoc(),
                                  ruc: Facturacion().ruc(),
                                  Total: _CartProvider.total(),
                                );
                                if(uid!=null) print('UID ES: '+uid);
                                if(uid!=null)CloudFirestoreAPI(uid: uid).createPedidos(pedido);
                                if(uid==null)  showDialog(
                                  context: context,
                                  builder: (context) => AuthDialog(),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Procesar Orden',style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                  // color: Color.fromRGBO(
                                  //     221, 220, 210, 1.0)
                                ),),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ):
                Container(
                  width: 1200,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 60,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Form(
                            key: _formKey,
                            child:Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'DIRECCION DE ENTREGA:',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    // fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 3,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.streetAddress,
                                                          decoration: InputDecoration(
                                                            labelText: 'Dirección de calle',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),
                                                          validator: (input)=> input!=null ? 'Introduce dirección' : null,
                                                          onChanged: (input) {
                                                            setState(() => _direccion = input);
                                                          }
                                                      ),
                                                    ),
                                                  ),
                                                  drop(),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText: 'Nro./Mz',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),
                                                          validator: (input)=> input!=null ? 'Introduce numero' : null,
                                                          onChanged: (input) {
                                                            setState(() => _nro = input);
                                                          }

                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.streetAddress,
                                                          decoration: InputDecoration(
                                                            labelText: 'Mas detalles de la direccion',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),

                                                          onChanged: (input) {
                                                            setState(() => _detdirec = input);
                                                          }
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'INGRESA INFROMACIÓN ADICIONAL:',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    // fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 3,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.name,
                                                          decoration: InputDecoration(
                                                            labelText: 'Nombre',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            //hintText: 'Enter a Phone Number',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),
                                                          validator: (input)=> input!=null ? 'Introduce tu nombre' : null,
                                                          onChanged: (input) {
                                                            setState(() => _name = input);
                                                          }

                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.name,
                                                          decoration: InputDecoration(
                                                            labelText: 'Apellidos',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            //hintText: 'Enter a Phone Number',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),
                                                          validator: (input)=> input!=null ? 'Introduce tus apellidos' : null,
                                                          onChanged: (input) {
                                                            setState(() => _apellidos = input);
                                                          }

                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText: 'DNI',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),
                                                          //validator: (input)=> input!=null ? 'Introduce numero' : null,
                                                          onChanged: (input) {
                                                            setState(() => _dni = input);
                                                          }

                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText: 'Número de Télefono',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            //hintText: 'Enter a Phone Number',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),
                                                          validator: (input)=> input!=null ? 'Introduce tu número de telefono' : null,
                                                          onChanged: (input) {
                                                            setState(() => _telefono = input);
                                                          }

                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                                    child: Center(
                                                      child: TextFormField(
                                                          cursorColor: Colors.black,
                                                          keyboardType: TextInputType.emailAddress,
                                                          decoration: InputDecoration(
                                                            labelText: 'Dirección de e-mail',
                                                            labelStyle: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                            //hintText: 'Enter a Phone Number',
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors.black
                                                                )
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide()
                                                            ),
                                                          ),
                                                          validator: (input)=> input!=null ? 'Introduce tu e-mail' : null,
                                                          onChanged: (input) {
                                                            setState(() => _email = input);
                                                          }

                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'METODOS DE PAGO:',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    // fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 3,
                                                  ),
                                                ),
                                              ),
                                              metodosdePago()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'FACTURACION:',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    // fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 3,
                                                  ),
                                                ),
                                              ),
                                              Facturacion()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //checkBox(),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          color: Color.fromRGBO(80, 182, 187, 1.0),
                                          onPressed: (){
                                            Pedido pedido = new Pedido(
                                              ordenes: _CartProvider.cart,
                                              name: _name,
                                              apellidos: _apellidos,
                                              dni: _dni,
                                              direccion: _direccion + ' '+_nro+', '+_distrito,
                                              detdir: _detdirec,
                                              email: _email,
                                              telefono: _telefono,
                                              metPago: metodosdePago().metodo(),
                                              efectivo:  metodosdePago().efectivoacancelar(),
                                              metFact: Facturacion().metFact(),
                                              razSoc: Facturacion().razSoc(),
                                              ruc: Facturacion().ruc(),
                                              Total:  _CartProvider.total(),
                                            );
                                            if(uid==null)  showDialog(
                                              context: context,
                                              builder: (context) => AuthDialog(),
                                            );
                                            if(uid!=null)CloudFirestoreAPI(uid: uid).createPedidos(pedido);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Procesar Orden',style: TextStyle(
                                                fontSize: 22,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(221, 220, 210, 1.0)
                                              // color: Color.fromRGBO(
                                              //     221, 220, 210, 1.0)
                                            ),),
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ))),
                        Expanded(child: Container(
                          height: screenSize.height*0.7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'RESUMEN DE LA ORDEN',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                            child: Container(
                                              color:Colors.black,
                                              height: 0.7,
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: _CartProvider.cart.length,
                                            itemBuilder: (BuildContext ctxt, int index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                child: Container(
                                                  width: 200,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(_CartProvider.cart[index].cantidad.toString()+
                                                                'x '+_CartProvider.cart[index].Pname,
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16)),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: Text(_CartProvider.cart[index].Pprice.toString(),
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 16)),
                                                          ),
                                                        ],
                                                      ),
                                                      opcionesresumen(_CartProvider.cart[index])
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                            child: Container(
                                              color:Colors.black,
                                              height: 0.7,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('TOTAL',style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                // fontFamily: 'Montserrat',
                                                // letterSpacing: 3,
                                              ),),
                                              Text('${context.watch<CartProvider>().total()}',style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                // fontFamily: 'Montserrat',
                                                // letterSpacing: 3,
                                              ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),

                      ],
                    ),
                  ),
                ),
              ],
            ),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
