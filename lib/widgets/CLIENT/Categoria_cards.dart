import 'package:line_icons/line_icons.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/screens/ProductDetail.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:flutter/material.dart';

class Categoria_cards extends StatefulWidget {
  Categoria_cards({
    Key key,
    this.screenSize,
    this.catid
  }) : super(key: key);
  final Size screenSize;
  final String catid;
  @override
  _Categoria_cardsState createState() => _Categoria_cardsState();
}

class _Categoria_cardsState extends State<Categoria_cards> {

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

  Widget tile(Product plato, String size,int index ) {
    var screenSize = MediaQuery.of(context).size;
    return new Card(
        color: Colors.transparent,
        child:  new  Row(
            children: [
              SizedBox(
                height: 260,
                width: 190,
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
              SizedBox(
                  height: 260,
                  width: 210,
                  child:Container(
                //width: 194.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top:10.0,left:10.0),
                        child: Text(
                          plato.Pname,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(221, 220, 210, 1.0)
                            // color: Color.fromRGBO(
                            //     221, 220, 210, 1.0)
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          plato.Pdescription,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              //fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(221, 220, 210, 1.0)
                            // color: Color.fromRGBO(
                            //     221, 220, 210, 1.0)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(
              height: 260,
              width: 108,
              child:Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 400,
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:20.0,left:5.0,right:5.0),
                              child: Text(
                                'S/. '+plato.Pprice.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                  // color: Color.fromRGBO(
                                  //     221, 220, 210, 1.0)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        child:
                      Container(
                        width: 200,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Ordenar',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(221, 220, 210, 1.0)
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Icon(LineIcons.shoppingCart, size: 20, color: Color.fromRGBO(221, 220, 210, 1.0),),
                                      ),
                                    ],
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
                                      Padding(
                                        padding: const EdgeInsets.only(left:15.0),
                                        child: Container(
                                          height: 2,
                                          width: 60,
                                          color:  Color.fromRGBO(223, 222, 211, 1.0),
                                        ),
                                      ),
                                    ],
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),)
                    ],
                  ),
                ],
              )),

            ],
          ),

    );

  }

  Widget tilesmall(Product plato, String size,int index ) {
    var screenSize = MediaQuery.of(context).size;
    return new Card(
      color: Colors.transparent,
      child: Container(
        child: Row(
          children: [
            Container(
              //color: Colors.black,
              height: screenSize.height/2,
              width:  screenSize.width/3,
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
            Container(
              height: screenSize.height/1.8,
              width:  screenSize.width/2.5,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                child: Padding(
                padding: const EdgeInsets.only(top:10.0,left:5.0),
                child: Text(
                  plato.Pname,
                  style: TextStyle(
                      fontSize: screenSize.width/30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(221, 220, 210, 1.0)
                    // color: Color.fromRGBO(
                    //     221, 220, 210, 1.0)
                  ),
                ),),
              ),
                  Align(
                    alignment: Alignment.centerLeft,
            child: Container(
              height: screenSize.width/3.6,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    plato.Pdescription,
                    style: TextStyle(
                        fontSize: screenSize.width/80<=9?9:screenSize.width/80,
                        fontFamily: 'Montserrat',
                        //fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(221, 220, 210, 1.0)
                      // color: Color.fromRGBO(
                      //     221, 220, 210, 1.0)
                    ),
                  ),
                ),
              ),),
          )
                ],
              )
            ),
            Container(
              height: screenSize.height/2,
              width:  screenSize.width/6.2,
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:20.0,left:5.0,right:5.0),
                  child: Text(
                    'S/. '+plato.Pprice.toString(),
                    style: TextStyle(
                        fontSize: screenSize.width/32,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(221, 220, 210, 1.0)
                      // color: Color.fromRGBO(
                      //     221, 220, 210, 1.0)
                    ),
                  ),
                ),

                Container(
                  height: screenSize.width/5.5,
                ),
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
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ordenar',
                                  style: TextStyle(
                                      fontSize: screenSize.width/35,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(221, 220, 210, 1.0)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Icon(LineIcons.shoppingCart, size: screenSize.width/26, color: Color.fromRGBO(221, 220, 210, 1.0),),
                                ),
                              ],
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
                                    width: screenSize.width/75,
                                  ),
                                  Container(
                                      height: 2,
                                      width: screenSize.width/10,
                                      color:  Color.fromRGBO(223, 222, 211, 1.0),
                                    ),

                                ],
                              ),)

                    ],
                  ),
                )

              ],
              ),
            )
          ],
        ),
      ),
    );

  }

  Widget newtile(Product plato, String size,int index ) {
    var screenSize = MediaQuery.of(context).size;
    return new Card(
      color: Colors.transparent,
      child: Container(
        child: Row(
          children: [
            Container(
              //color: Colors.black,
              height: screenSize.width/4.25,
              width:  screenSize.width/5.3,
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: screenSize.width/4.25,
                width:  screenSize.width/5.5,
                child: Column(
                  children: [
                Padding(
                padding: const EdgeInsets.only(top:10.0,left:10.0),
                child: Text(
                  plato.Pname,
                  style: TextStyle(
                      fontSize: screenSize.width/58,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(221, 220, 210, 1.0)
                    // color: Color.fromRGBO(
                    //     221, 220, 210, 1.0)
                  ),
                ),),
                    Align(
                      alignment: Alignment.centerLeft,
            child: Container(
                height: screenSize.width/6.5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      plato.Pdescription,
                      style: TextStyle(
                          fontSize: screenSize.width/80,
                          fontFamily: 'Montserrat',
                          //fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(221, 220, 210, 1.0)
                        // color: Color.fromRGBO(
                        //     221, 220, 210, 1.0)
                      ),
                    ),
                  ),
                ),),
          )
                  ],
                )
              ),
            ),
            Container(
              height: screenSize.width/3,
              width:  screenSize.width/11,
              child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:20.0,left:5.0,right:5.0),
                  child: Text(
                    'S/. '+plato.Pprice.toString(),
                    style: TextStyle(
                        fontSize: screenSize.width/62,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(221, 220, 210, 1.0)
                      // color: Color.fromRGBO(
                      //     221, 220, 210, 1.0)
                    ),
                  ),
                ),
                Container(
                  height: screenSize.width/7,
                ),
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
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ordenar',
                                  style: TextStyle(
                                      fontSize: screenSize.width/62,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(221, 220, 210, 1.0)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(LineIcons.shoppingCart, size: screenSize.width/57, color: Color.fromRGBO(221, 220, 210, 1.0),),
                                ),
                              ],
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
                                    width: screenSize.width/135,
                                  ),
                                  Container(
                                      height: 2,
                                      width: screenSize.width/12,
                                      color:  Color.fromRGBO(223, 222, 211, 1.0),
                                    ),

                                ],
                              ),)

                    ],
                  ),
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
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CloudFirestoreAPI(cat: widget.catid).platosdata,
        builder:(context, snapshot){
          if(!snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(child: CircularProgressIndicator(color: Colors.white,)),
              ),
            );
          }
          List<Product> Carta=snapshot.data;

          return ResponsiveWidget.isSmallScreen(context)
              ? Padding(
            padding: EdgeInsets.only(
              left: widget.screenSize.width / 25,
              right: widget.screenSize.width / 25,
              bottom: widget.screenSize.width / 15,
            ),
            child: Column(
              children: [
                new GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 15,
                    childAspectRatio: (2.2 / 1),
                  ),
                  itemCount: Carta.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return tilesmall(Carta[index],'small', index);
                  },
                ),
              ],
            ),

          )
              :ResponsiveWidget.isMediumScreenCategory(context)? Container(
            width: 1100,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 60,
              ),
              child: Column(
                children: [
                  new GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: (2 / 1),
                    ),
                    itemCount: Carta.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return newtile(Carta[index],'normal',index);
                    },
                  ),
                ],
              ),
            ),
          ):
          Container(
            width: 1100,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 60,
              ),
              child: Column(
                children: [
                  new GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: (2 / 1),
                    ),
                    itemCount: Carta.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return tile(Carta[index],'normal',index);
                    },
                  ),
                ],
              ),
            ),
          );

        }
    );
    
  }
}



