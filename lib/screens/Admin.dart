import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mardegrau/widgets/ADMIN/AdminCarrousel.dart';
import 'package:mardegrau/widgets/ADMIN/AdminCategoria.dart';
import 'package:mardegrau/widgets/ADMIN/AdminPedidos.dart';
import 'package:mardegrau/widgets/ADMIN/AdminProduct.dart';
import 'package:mardegrau/widgets/CLIENT/bottom_bar.dart';
import 'package:mardegrau/widgets/CLIENT/explore_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:mardegrau/utils/authentication.dart';
import 'package:mardegrau/widgets/CLIENT/top_bar_contents.dart';

class adminHome extends StatefulWidget {
  @override
  final String screen;
  adminHome({this.screen});
  _adminHome createState() => _adminHome();
}

class _adminHome extends State<adminHome> {
  String adminscreen;
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
    adminscreen=widget.screen.toString()!='null'?widget.screen:'Pedidos';
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }
  Widget option(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: InkWell(
        onTap: (){
          setState(() {
            adminscreen=title;
          });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,0,16,0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(223, 222, 211, 1.0),
                  ),
                ),
              ),
            ),
            Container(
              color:Color.fromRGBO(223, 222, 211, 1.0),
              width: 1,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
  Widget menu(){
    return Container(
      color: Colors.black12,
      // width: 250,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: imageUrl != null
                          ? NetworkImage(imageUrl)
                          : null,
                      child: imageUrl == null
                          ? Icon(
                        Icons.account_circle,
                        size: 40,
                        // color: Color.fromRGBO(223, 222, 211, 1.0),
                      )
                          : Container(),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Administrador',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color:Color.fromRGBO(223, 222, 211, 1.0),
            width: 2,
            height: 60,
          ),
          option('Pedidos'),
          option('Carrousel'),
          option('Categorias'),
          option('Productos'),
        ],
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
      )
          : PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(_opacity),
      ),
      drawer: ExploreDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.13,),
            menu(),
            Row(
              children: [

                adminscreen=='Categorias'?admin_categorias(screenSize: screenSize):Container(),
                adminscreen=='Carrousel'?admin_carrousel(screenSize: screenSize):Container(),
                adminscreen=='Pedidos'?admin_Pedidos(screenSize: screenSize):Container(),
                adminscreen=='Productos'?admin_producto(screenSize: screenSize):Container(),
              ],
            ),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
