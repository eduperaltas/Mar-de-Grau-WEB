import 'package:mardegrau/screens/inicio.dart';
import 'package:mardegrau/utils/authentication.dart';
import 'package:flutter/material.dart';

import 'auth_dialog.dart';

class ExploreDrawer extends StatefulWidget {
  const ExploreDrawer({
    Key key,
  }) : super(key: key);

  @override
  _ExploreDrawerState createState() => _ExploreDrawerState();
}

class _ExploreDrawerState extends State<ExploreDrawer> {
  bool _isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(80, 182, 187, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userEmail == null
                  ? Container(
                      width: double.maxFinite,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AuthDialog(),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: Text(
                            'Iniciar sesion',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(223, 222, 211, 1.0),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl) : null,
                          child: imageUrl == null
                              ? Icon(
                                  Icons.account_circle,
                                  size: 40,
                                )
                              : Container(),
                        ),
                        SizedBox(width: 10),
                        Text(
                          name ?? userEmail,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(223, 222, 211, 1.0),
                          ),
                        )
                      ],
                    ),
              SizedBox(height: 20),
              userEmail != null
                  ? Container(
                      width: double.maxFinite,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.black,
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
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          child: _isProcessing
                              ? CircularProgressIndicator()
                              : Text(
                                  'Cerrar sesion',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(223, 222, 211, 1.0),
                                  ),
                                ),
                        ),
                      ),
                    )
                  : Container(),
              userEmail != null ? SizedBox(height: 20) : Container(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => inicio(),
                    ),
                  );
                },
                child: Text(
                  'Nuestra carta',
                  style: TextStyle(color: Color.fromRGBO(223, 222, 211, 1.0), fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Color.fromRGBO(223, 222, 211, 1.0),
                  thickness: 2,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Contactanos',
                  style: TextStyle(color:Color.fromRGBO(223, 222, 211, 1.0), fontSize: 22),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2020 | Meteora Tech Solution',
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
