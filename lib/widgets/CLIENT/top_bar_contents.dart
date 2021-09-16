import 'package:mardegrau/Providers/cart_provider.dart';
import 'package:mardegrau/screens/Admin.dart';
import 'package:mardegrau/screens/MisPedidos.dart';
import 'package:mardegrau/screens/inicio.dart';
import 'package:mardegrau/utils/authentication.dart';
import 'package:mardegrau/widgets/CLIENT/auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_drawer.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
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

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final _CartProvider =
    Provider.of<CartProvider>(context, listen: false);
    var screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Color.fromRGBO(80, 182, 187, widget.opacity),
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SizedBox(
                  height: 120,
                  width: 130,
                  child: Image.asset(
                    'assets/images/promo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 55),
                    InkWell(
                      hoverColor: Colors.transparent,
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => inicio(),
                        ),
                      );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Nuestra carta',
                            style: TextStyle(
                              color: _isHovering[0]
                                  ? Colors.blue[200]
                                  :  Color.fromRGBO(223, 222, 211, 1.0),
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 2,
                              width: 20,
                              color:  Color.fromRGBO(223, 222, 211, 1.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      hoverColor: Colors.transparent,
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[1] = true
                              : _isHovering[1] = false;
                        });
                      },
                      onTap: () {
                        if(uid=='RpkFN86vSBc6UJKyv3HlUs6jaO03'){
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => adminHome(),
                          ));
                        }
                        else{
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => MisPedidos(),
                              ),
                            );

                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            uid=='RpkFN86vSBc6UJKyv3HlUs6jaO03'?'Administrador':'Mis Pedidos',
                            style: TextStyle(
                              color: _isHovering[1]
                                  ? Colors.blue[200]
                                  :  Color.fromRGBO(223, 222, 211, 1.0),
                            ),
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[1],
                            child: Container(
                              height: 2,
                              width: 20,
                              color:  Color.fromRGBO(223, 222, 211, 1.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenSize.width / 50,
              ),
              InkWell(
                hoverColor: Colors.transparent,
                onHover: (value) {
                  setState(() {
                    value ? _isHovering[3] = true : _isHovering[3] = false;
                  });
                },
                onTap: userEmail == null
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => AuthDialog(),
                        );
                      }
                    : null,
                child: userEmail == null
                    ? Text(
                        'Iniciar sesion',
                        style: TextStyle(
                          color: _isHovering[3] ?  Color.fromRGBO(223, 222, 211, 1.0) : Colors.white70,
                        ),
                      )
                    : Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: imageUrl != null
                                ? NetworkImage(imageUrl)
                                : null,
                            child: imageUrl == null
                                ? Icon(
                                    Icons.account_circle,
                                    size: 30,
                                  )
                                : Container(),
                          ),
                          SizedBox(width: 5),
                          Text(
                            name ?? userEmail,
                            style: TextStyle(
                              color: _isHovering[3]
                                  ?  Color.fromRGBO(223, 222, 211, 1.0)
                                  : Colors.white70,
                            ),
                          ),
                          SizedBox(width: 10),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: _isProcessing
                                ? null
                                : () async {
                                    setState(() {
                                      _isProcessing = true;
                                    });
                                    await signOut().then((result) {
                                      print(result);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => inicio(),
                                        ),
                                      );
                                    }).catchError((error) {
                                      print('Sign Out Error: $error');
                                    });
                                    setState(() {
                                      _isProcessing = false;
                                    });
                                  },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: _isProcessing
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'cerrar sesión',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:  Color.fromRGBO(223, 222, 211, 1.0),
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: InkWell(
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                value ? _isHovering[4] = true : _isHovering[3] = false;
              });
            },
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child:  Stack(
              children: [
                new Positioned(
                  child: Container(
                    width: 30,
                    height: 25,
                    child: Center(
                      child: Text(
                        '${context.watch<CartProvider>().cart.length}',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(221, 220, 210, 1.0)
                        // color: Color.fromRGBO(
                        //     221, 220, 210, 1.0)
                      ),),
                    ),
                  ),
                  top: 26.0,
                  left: 36.0,
                ),
                Container(

                    child: Image.asset('assets/images/barco.png',
                                        width: 100,
                                        height: 60,
                                        fit:BoxFit.fill  ))
              ],
            ),
            ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
