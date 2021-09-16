import 'dart:js';

import 'package:line_icons/line_icons.dart';
import 'package:mardegrau/widgets/CLIENT/bottom_bar_column.dart';
import 'package:mardegrau/widgets/CLIENT/info_text.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.black12,
      child: ResponsiveWidget.isSmallScreen(context)
          ? Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarColumn(
                      heading:'REDES SOCIALES',
                      s1: 'Twitter',
                      i1: LineIcons.twitter,
                      l1: null,
                      s2: 'Facebook',
                      i2: LineIcons.facebook,
                      l2: 'https://www.facebook.com/MardeGrau1/',
                      s3: 'Instagram',
                      i3: LineIcons.instagram,
                      l3: 'https://www.instagram.com/mar_de_grau/?hl=es-la',
                    ),
                  ],
                ),
                Container(
                  color:Color.fromRGBO(223, 222, 211, 1.0),
                  width: double.maxFinite,
                  height: 1,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            'MÉTODOS DE PAGO',
                            style: TextStyle(
                              color: Color.fromRGBO(223, 222, 211, 1.0),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: SizedBox(
                                height: 50,
                                width: 80,
                                child: Icon(LineIcons.visaCreditCard,
                                  size: 45,
                                  color: Color.fromRGBO(223, 222, 211, 1.0),),
                              ),
                            ),
                            Container(
                              child: SizedBox(
                                height: 50,
                                width: 80,
                                child: Icon(LineIcons.mastercardCreditCard,
                                  size: 45,
                                  color: Color.fromRGBO(223, 222, 211, 1.0),),
                              ),
                            ),
                            Container(
                              child: SizedBox(
                                  height: 50,
                                  width: 80,
                                  child:Icon(LineIcons.americanExpressCreditCard,
                                    size: 45,
                                    color: Color.fromRGBO(223, 222, 211, 1.0),)
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  color:Color.fromRGBO(223, 222, 211, 1.0),
                  width: double.maxFinite,
                  height: 1,
                ),
                SizedBox(height: 20),
                InfoText(
                  type: 'Email',
                  text: 'soportemardegrau@gmail.com',
                  link: 'mailto:soportemardegrau@gmail.com',
                ),
                SizedBox(height: 5),
                InfoText(
                  type: 'Dirección',
                  text: 'Av. Benavides 202, Miraflores',
                  link: null,
                ),

              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    BottomBarColumn(
                      heading: 'REDES SOCIALES',
                      s1: 'Twitter',
                      i1: LineIcons.twitter,
                      l1: null,
                      s2: 'Facebook',
                      i2: LineIcons.facebook,
                      l2: 'https://www.facebook.com/MardeGrau1/',
                      s3: 'Instagram',
                      i3: LineIcons.instagram,
                      l3: 'https://www.instagram.com/mar_de_grau/?hl=es-la',
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: Text(
                              'MÉTODOS DE PAGO',
                              style: TextStyle(
                                color: Color.fromRGBO(223, 222, 211, 1.0),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: SizedBox(
                                  height: 50,
                                  width: 80,
                                  child: Icon(LineIcons.visaCreditCard,
                                    size: 45,
                                    color: Color.fromRGBO(223, 222, 211, 1.0),),
                                ),
                              ),
                              Container(
                                child: SizedBox(
                                  height: 50,
                                  width: 80,
                                  child: Icon(LineIcons.mastercardCreditCard,
                                    size: 45,
                                    color: Color.fromRGBO(223, 222, 211, 1.0),),
                                ),
                              ),
                              Container(
                                child: SizedBox(
                                  height: 50,
                                  width: 80,
                                  child:Icon(LineIcons.americanExpressCreditCard,
                                    size: 45,
                                    color: Color.fromRGBO(223, 222, 211, 1.0),)
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      width: 1,
                      height: 90,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoText(
                          type: 'Email',
                          text: 'soportemardegrau@gmail.com',
                          link: 'mailto:soportemardegrau@gmail.com',
                        ),
                        SizedBox(height: 5),
                        InfoText(
                          type: 'Dirección',
                          text: 'Av. Benavides 202, Miraflores',
                          link: null,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
