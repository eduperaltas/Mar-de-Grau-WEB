import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mardegrau/Model/Pedido.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/Providers/cart_provider.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:mardegrau/utils/authentication.dart';
import 'package:mardegrau/widgets/CLIENT/ProcessTimeline.dart';
import 'package:mardegrau/widgets/CLIENT/bottom_bar.dart';
import 'package:mardegrau/widgets/CLIENT/cart_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/explore_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/featured_heading.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:mardegrau/widgets/CLIENT/top_bar_contents.dart';
import 'package:provider/provider.dart';

class MisPedidos extends StatefulWidget {
  @override
  _MisPedidos createState() => _MisPedidos();
}

class _MisPedidos extends State<MisPedidos> {
  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Widget miCardPedido(Pedido p) {
    int est;
    if(p.estado=='Pendiente') est=0;
    if(p.estado=='Preparando') est=1;
    if(p.estado=='Enviado') est=2;
    if(p.estado=='Finalizado') est=3;
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Column(
          children: <Widget>[
            Center(
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: p.estado!='Finalizado'?ProcessTimeline(estado: est):Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ID: '+p.id),
                    Text('Fecha: '+p.fecha),
                  ],
                ),
                subtitle:  StreamBuilder(
                  stream: CloudFirestoreAPI(pid: p.id).pedidosopcionesdata,
                  builder: (context, snapshot){
                    List<Product> lstplatos = snapshot.data;
                    if(!snapshot.hasData){
                      return Container();
                    }
                    if(snapshot.hasData) {
                      return Container(
                        child: Column(
                          children: [
                            Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Dirección: '+p.direccion),
                            )),
                            Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Platos:'),
                            )),
                            for (var element in lstplatos)
                              platos(element),

                            Align(alignment: Alignment.centerRight,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Total:  '+p.Total),
                            )),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                leading: Image.asset(
                  'assets/images/status${est+1}.png',
                  color: Colors.grey,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget platos(Product lstplatos){
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft,child: Text('  '+lstplatos.cantidad.toString() +'X '+lstplatos.name)),
        if (lstplatos.get_op1!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op1),)),
        if (lstplatos.get_op2!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op2),)),
        if (lstplatos.get_op3!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op3),)),
        if (lstplatos.get_op4!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op4),)),
        if (lstplatos.get_op5!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op5),)),
        if (lstplatos.get_op6!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op6),)),
        if (lstplatos.get_op7!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op7),)),
        if (lstplatos.get_op8!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op8),)),
        if (lstplatos.comentarios!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text('Coment: '+lstplatos.comentarios),)),
      ],
    );
  }
  Widget Historial(){
    return  Padding(
      padding: const EdgeInsets.all( 15.0),
      child: StreamBuilder(
          stream: CloudFirestoreAPI().Hispedidosdata,
          builder:(context, snapshot){
            if(!snapshot.hasData){
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Container(child: Column(
                    children: [
                      CircularProgressIndicator(color: Colors.grey,),
                    ],
                  )),
                ),
              );
            }
            List<Pedido> lstpedidos=snapshot.data;
            if(snapshot.hasData) {
                    print('TAMAÑO user historial: '+lstpedidos.length.toString());
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width*0.94,
              child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: ResponsiveWidget.isSmallScreen(context)?1:int.parse((MediaQuery.of(context).size.width/650).toStringAsPrecision(1)),
                      children: <Widget>[
                        for(int i=0;i<lstpedidos.length;i++)
                          miCardPedido(lstpedidos[i]),
                      ],
                    ),
                  ),
                ],
              ),
            );

          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
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
            SizedBox(height: screenSize.height * 0.09,),
            Column(
              children: [
                Container(
                  color: Color.fromRGBO(80, 182, 187, 1.0),
                  child: Column(
                    children: [
                      FeaturedHeading(screenSize: screenSize,title: 'Mis Pedidos',subtitle: 'Historial de pedidos',),
                      // Historial()
                      uid!=null?Historial():
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Image.asset('assets/images/Login.png',
                                  width: 70,
                                  height: 50,
                                  fit:BoxFit.fill  )),
                          Text(
                            'Inicia sesion para ver tus pedidos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(223, 222, 211, 1.0),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
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
