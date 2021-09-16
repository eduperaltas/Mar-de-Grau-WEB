import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mardegrau/Providers/cart_provider.dart';
import 'package:mardegrau/widgets/CLIENT/Carousel.dart';
import 'package:mardegrau/widgets/CLIENT/bottom_bar.dart';
import 'package:mardegrau/widgets/CLIENT/cart_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/explore_drawer.dart';
import 'package:mardegrau/widgets/CLIENT/featured_heading.dart';
import 'package:mardegrau/widgets/CLIENT/featured_tiles.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:mardegrau/widgets/CLIENT/top_bar_contents.dart';
import 'package:provider/provider.dart';

class inicio extends StatefulWidget {
  @override
  _Inicio createState() => _Inicio();
}

class _Inicio extends State<inicio> {
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
            Stack(
              children: [
               Column(
                 children: [
                   SizedBox(
                       height: 300,
                       width: screenSize.width,
                       child: PromoCarousel()
                   ),
                   Container(
                     color: Color.fromRGBO(80, 182, 187, 1.0),
                     child: Column(
                       children: [
                         FeaturedHeading(screenSize: screenSize,title: 'NUESTRA CARTA',subtitle: 'Del mar a tu mesa',),
                         FeaturedTiles(screenSize: screenSize),
                       ],
                     ),
                   ),
                 ],
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
