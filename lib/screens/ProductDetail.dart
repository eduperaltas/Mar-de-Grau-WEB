import 'package:line_icons/line_icons.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/Providers/cart_provider.dart';
import 'package:mardegrau/Providers/product_provider.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:mardegrau/widgets/CLIENT/ContadorProd.dart';
import 'package:mardegrau/widgets/CLIENT/bottom_bar.dart';
import 'package:mardegrau/widgets/CLIENT/cart_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/explore_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/list-buttons.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:flutter/material.dart';
import 'package:mardegrau/widgets/CLIENT/top_bar_contents.dart';
import 'package:provider/provider.dart';


class Products extends StatefulWidget {
  Products({
    Key key,
    this.screenSize,
    this.plato,
  }) : super(key: key);
  final Size screenSize;
  final Product plato;
  @override
  _ProductState createState() => _ProductState();
}


class _ProductState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _scrollController;

  double _scrollPosition = 0;
  double _opacity = 0;
  String _comentario;
  final myController = TextEditingController();
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
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

  Widget opciones(){
    final _ProducProvider =
    Provider.of<ProductProvider>(context, listen: false);
    _ProducProvider.platoinicial(widget.plato);
    return StreamBuilder(
        stream: CloudFirestoreAPI(pid: widget.plato.id).opcionesdata,
        builder:(context, snapshot){
          if(!snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(child: CircularProgressIndicator(color: Colors.white,)),
              ),
            );
          }

          List<radioButton> lstopciones=snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 5,left: 50),
            child: Column(
              children: [
                lstopciones.length >0 ?lstopciones[0]:Container(),
                lstopciones.length >1 ?lstopciones[1]:Container(),
                lstopciones.length >2 ?lstopciones[2]:Container(),
                lstopciones.length >3 ?lstopciones[3]:Container(),
                lstopciones.length >4 ?lstopciones[4]:Container(),
                lstopciones.length >5 ?lstopciones[5]:Container(),
                lstopciones.length >6 ?lstopciones[6]:Container(),
                lstopciones.length >7 ?lstopciones[7]:Container(),
                lstopciones.length >8 ?lstopciones[8]:Container(),
              ],
            ),
          );
        }
    );
  }

  Widget product(){
    final _CartProvider =
    Provider.of<CartProvider>(context, listen: false);
    var screenSize = MediaQuery.of(context).size;
    final _ProducProvider =
    Provider.of<ProductProvider>(context, listen: false);
    return Container(
      width: 1100,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 60,
        ),
        child:Padding(
            padding: const EdgeInsets.all(10.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: screenSize.height/3,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(
                            widget.plato.Pphoto
                        ),
                      )
                  ),
                ),
                Container(
                  width: screenSize.width/2>=700?700:screenSize.width/2,
                  child: Column(
                    children: [
                      Container(
                        width: screenSize.width/2,
                        child: Padding(
                          padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.plato.Pname,
                              style: TextStyle(
                                  fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(221, 220, 210, 1.0)
                              ),
                            ),

                            Text(
                              'S/. '+widget.plato.Pprice.toString(),
                              style: TextStyle(
                                  fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(221, 220, 210, 1.0)
                              ),
                            ),
                          ],
                        ),
                      )),
                      Container(
                        width: screenSize.width/2,
                        child: Padding(
                          padding: const EdgeInsets.only(left:55.0,right: 130,bottom: 5),
                          child: Text(
                            widget.plato.Pdescription,
                            style: TextStyle(
                                fontSize: screenSize.width/70>=18?18:screenSize.width/70,
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(221, 220, 210, 1.0)
                            ),
                          ),),
                      ),
                      //DIVIDER
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          color:Color.fromRGBO(223, 222, 211, 1.0),
                          width: screenSize.width/2.4,
                          height: 0.7,
                        ),
                      ),

                      //SECCION ELECCION
                      opciones(),
                      //Seccion COMENTARIO
                      Container(
                        //color: Colors.green,
                        width: screenSize.width/2,
                        child: Padding(
                          padding: const EdgeInsets.only(left:50.0,right: 150,bottom: 5),
                          child: Text(
                            'Comentario (Opcional)',
                            style: TextStyle(
                                fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(221, 220, 210, 1.0)
                            ),
                          ),),
                      ),
                      Container(
                        //color: Colors.black,
                        width: screenSize.width/2,
                        child: Padding(
                          padding: const EdgeInsets.only(left:50.0,right: 100,bottom: 5),
                          child: Text(
                            'Indicanos si quiere hacer alguna modificación a tu plato',
                            style: TextStyle(
                                fontSize: screenSize.width/78>=18?18:screenSize.width/78,
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(221, 220, 210, 1.0)
                            ),
                          ),),
                      ),
                      Container(
                        width: screenSize.width/2,
                        child: Padding(
                          padding: const EdgeInsets.only(left:50.0,right: 40),
                          child: Container(
                            child: TextField(
                                controller: myController,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                maxLines: 6,
                                style: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0)),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 4.0),
                                  ),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 1.0),),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                                ),
                                onChanged: (input) {
                                  setState(() {
                                    _comentario=input;
                                  });
                                }
                            ),
                          ),),
                      ),

                      //DEVIDER
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          color:Color.fromRGBO(223, 222, 211, 1.0),
                          width: screenSize.width/2.4,
                          height: 0.7,
                        ),
                      ),
                      //Contador
                      Padding(
                        padding: const EdgeInsets.only(left:50.0,right: 40),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Contador(),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                  hoverElevation: 1.5,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                                  color: Color.fromRGBO(80, 182, 187, 1.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Agregar a mi ",style:
                                        TextStyle(
                                            color: Color.fromRGBO(223, 222, 211, 1.0),
                                            fontSize: screenSize.width/50>=14?14:screenSize.width/50
                                        ),),
                                        Icon(Icons.add_shopping_cart_outlined,color: Color.fromRGBO(223, 222, 211, 1.0),),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.plato.comentarios=_comentario;
                                    });
                                    _scaffoldKey.currentState.openEndDrawer();
                                    Product pedido =_ProducProvider.plato;
                                    _CartProvider.addToCatalog(pedido,Contador().getcont());
                                  }),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  Widget smallscreenproduct(){
    final _CartProvider =
    Provider.of<CartProvider>(context, listen: false);

    final _ProducProvider =
    Provider.of<ProductProvider>(context, listen: false);

    var screenSize = MediaQuery.of(context).size;
    int cantidad=1;
    return Container(
      width: 1100,
      /*height: 650,*/
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 0,
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width/1,
              height: screenSize.width/2.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:NetworkImage(
                          widget.plato.Pphoto
                      ),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Container(
              /*height: screenSize.height/1.7,*/
              child: Column(
                children: [
                 Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left:0.0,bottom: 5,top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.plato.Pname,
                          style: TextStyle(
                              fontSize: screenSize.width/30,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(221, 220, 210, 1.0)
                          ),
                        ),

                        Text(
                          'S/. '+widget.plato.Pprice.toString(),
                          style: TextStyle(
                              fontSize: screenSize.width/30,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(221, 220, 210, 1.0)
                          ),
                        ),
                      ],
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: screenSize.width/1.3,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            widget.plato.Pdescription,
                            style: TextStyle(
                                fontSize: screenSize.width/50<9?9:screenSize.width/50,
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(221, 220, 210, 1.0)
                            ),
                          ),),
                      ),
                    ],
                  ),
                  //DIVIDER
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: Container(
                      color:Color.fromRGBO(223, 222, 211, 1.0),
                      height: 0.7,
                    ),
                  ),

                  //SECCION ELECCION
                  opciones(),
                  //Seccion COMENTARIO
                  Container(
                    width: screenSize.width/1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        'Comentario (Opcional)',
                        style: TextStyle(
                            fontSize: screenSize.width/30,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(221, 220, 210, 1.0)
                        ),
                      ),),
                  ),
                  Container(
                    width: screenSize.width/1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Indicanos si quiere hacer alguna modificación a tu plato',
                        style: TextStyle(
                            fontSize: screenSize.width/50<9?9:screenSize.width/50,
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(221, 220, 210, 1.0)
                        ),
                      ),),
                  ),
                  Container(
                    child: Container(
                      height: screenSize.height/6<70?screenSize.height/6:70,
                      child: TextField(
                          controller: myController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                          maxLines: 6,
                          style: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0)),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 4.0),
                            ),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 1.0),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                          )
                      ),
                    ),
                  ),
                  //DEVIDER
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: Container(
                      color:Color.fromRGBO(223, 222, 211, 1.0),
                      height: 0.7,
                    ),
                  ),
                  //Contador
                  screenSize.width<500
                      ?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Contador(size: ''),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: screenSize.width/2.5,
                        child: RaisedButton(
                            hoverElevation: 1.5,
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                            color: Color.fromRGBO(80, 182, 187, 1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Agregar a mi ",style:
                                  TextStyle(
                                      color: Color.fromRGBO(223, 222, 211, 1.0),
                                      fontSize: screenSize.width/25
                                  ),),
                                  Icon(Icons.add_shopping_cart_outlined,
                                    color: Color.fromRGBO(223, 222, 211, 1.0),
                                  size: screenSize.width/23,),
                                ],
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                widget.plato.comentarios=_comentario;
                              });
                              _scaffoldKey.currentState.openEndDrawer();
                              Product pedido =_ProducProvider.plato;
                              _CartProvider.addToCatalog(pedido,Contador().getcont());
                            }),
                      ),
                    ],
                  ):
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Contador(size: ''),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                          hoverElevation: 1.5,
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                          color: Color.fromRGBO(80, 182, 187, 1.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Agregar a mi ",style:
                                TextStyle(
                                    color: Color.fromRGBO(223, 222, 211, 1.0),
                                    fontSize: 16
                                ),),
                                Icon(Icons.add_shopping_cart_outlined,color: Color.fromRGBO(223, 222, 211, 1.0),),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              widget.plato.comentarios=_comentario;
                            });
                            _scaffoldKey.currentState.openEndDrawer();
                            Product pedido =_ProducProvider.plato;
                            _CartProvider.addToCatalog(pedido,Contador().getcont());
                          }),
                    ],
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      key: _scaffoldKey,
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
            height: 100,
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
                          child: Column(
                            children: [
                              Image.asset('assets/images/barco.png',
                                  width: 70,
                                  height: 50,
                                  fit:BoxFit.fill  ),
                            ],
                          ))
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
          SizedBox(height: screenSize.height * 0.15,),
          Container(
              child: ResponsiveWidget.isSmallScreen(context)
                  ?smallscreenproduct():product()
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: BottomBar(),
          ),
        ],
      ),
    ),
    );

  }
}



