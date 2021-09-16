import 'package:mardegrau/screens/Admin.dart';
import 'package:mardegrau/screens/inicio.dart';
import 'package:mardegrau/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';

import 'google_sign_in_button.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
   TextEditingController textControllerEmail;
   FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;

   TextEditingController textControllerPassword;
   FocusNode textFocusNodePassword;
  bool _isEditingPassword = false;

  bool _isRegistering = false;
  bool _isLoggingIn = false;

  String loginStatus;
  Color loginStringColor = Colors.green;

  String _validateEmail(String value) {
    value = value.trim();

    if (textControllerEmail.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'ingresa un e-mail valido';
      }
    }

    return null;
  }

  String _validatePassword(String value) {
    value = value.trim();

    if (textControllerEmail.text.isNotEmpty) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      } else if (value.length < 6) {
        return 'la contraseña debe tener por lo menos 6 caracteres';
      }
    }

    return null;
  }

  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textControllerPassword = TextEditingController();
    textControllerEmail.text = '';
    textControllerPassword.text = '';
    textFocusNodeEmail = FocusNode();
    textFocusNodePassword = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ResponsiveWidget.isSmallScreen(context)
        ?Dialog(
      backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
            color: Color.fromRGBO(80, 182, 187, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('*Para Comprar necesitas iniciar sesión',
                    style:TextStyle(color:Color.fromRGBO(223, 222, 211, 1.0), fontSize: 12)),
                  ),
                ),
                Center(
                  child: Container(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/promo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Text(
                    'Correo electronico',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 18,
                      // fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 3,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 10,
                  ),
                  child: TextField(
                    focusNode: textFocusNodeEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: textControllerEmail,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingEmail = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodeEmail.unfocus();
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
                    },
                    style: TextStyle(color: Color.fromRGBO(223, 222, 211, 1.0)),
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:  Color.fromRGBO(223, 222, 211, 1.0),
                          width: 3,
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Color.fromRGBO(223, 222, 211, 0.6),
                      ),
                      hintText: "ejemplo@mail.com",
                      fillColor: Color.fromRGBO(80, 182, 187, 1.0),
                      errorText: _isEditingEmail
                          ? _validateEmail(textControllerEmail.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Text(
                    'Contraseña',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 3,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    bottom: 10
                  ),
                  child: TextField(
                    focusNode: textFocusNodePassword,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: textControllerPassword,
                    obscureText: true,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingPassword = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodePassword.unfocus();
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800],
                          width: 3,
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Color.fromRGBO(223, 222, 211, 0.6),
                      ),
                      hintText: "******",
                      fillColor: Color.fromRGBO(80, 182, 187, 1.0),
                      errorText: _isEditingPassword
                          ? _validatePassword(textControllerPassword.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Container(
                        width: 170,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(223, 222, 211, 1.0),
                              width: 3,
                            ),
                            borderRadius:  BorderRadius.circular(15.0)
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.blueGrey.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoggingIn = true;
                              textFocusNodeEmail.unfocus();
                              textFocusNodePassword.unfocus();
                            });
                            if (_validateEmail(textControllerEmail.text) ==
                                null &&
                                _validatePassword(
                                    textControllerPassword.text) ==
                                    null) {
                              await signInWithEmailPassword(
                                  textControllerEmail.text,
                                  textControllerPassword.text)
                                  .then((result) {
                                if (result != null) {
                                  print(result);
                                  setState(() {
                                    loginStatus =
                                    'Iniciaste sesión';
                                    loginStringColor = Colors.green;
                                  });
                                  Future.delayed(Duration(milliseconds: 500),
                                          () {
                                        Navigator.of(context).pop();
                                      });
                                }
                              }).catchError((error) {
                                print('Login Error: $error');
                                setState(() {
                                  loginStatus =
                                  'Error al iniciar sesión';
                                  loginStringColor = Colors.red;
                                });
                              });
                            } else {
                              setState(() {
                                loginStatus = 'Por favor entra tu e-mail y contraseña';
                                loginStringColor = Colors.red;
                              });
                            }
                            setState(() {
                              _isLoggingIn = false;
                              textControllerEmail.text = '';
                              textControllerPassword.text = '';
                              _isEditingEmail = false;
                              _isEditingPassword = false;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                              bottom: 15.0,
                            ),
                            child: _isLoggingIn
                                ? SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                new AlwaysStoppedAnimation<Color>(
                                  Color.fromRGBO(223, 222, 211, 1.0),
                                ),
                              ),
                            )
                                : Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(223, 222, 211, 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 170,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(223, 222, 211, 1.0),
                              width: 3,
                            ),
                            borderRadius:  BorderRadius.circular(15.0)
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.blueGrey.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isRegistering = true;
                            });
                            await registerWithEmailPassword(
                                textControllerEmail.text,
                                textControllerPassword.text)
                                .then((result) {
                              if (result != null) {
                                setState(() {
                                  loginStatus =
                                  'Registro exitoso';
                                  loginStringColor = Colors.green;
                                });
                                print(result);
                              }
                            }).catchError((error) {
                              print('Registration Error: $error');
                              setState(() {
                                loginStatus =
                                'Error en el registro';
                                loginStringColor = Colors.red;
                              });
                            });

                            setState(() {
                              _isRegistering = false;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                              bottom: 15.0,
                            ),
                            child: _isRegistering
                                ? SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                new AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(223, 222, 211, 1.0)
                                ),
                              ),
                            )
                                : Text(
                              'Registrate',
                              style: TextStyle(
                                  fontSize: 14,
                                  color:Color.fromRGBO(223, 222, 211, 1.0)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                loginStatus != null
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: Text(
                      loginStatus,
                      style: TextStyle(
                        color: loginStringColor,
                        fontSize: 14,
                        // letterSpacing: 3,
                      ),
                    ),
                  ),
                )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 40.0,
                    right: 40.0,
                  ),
                  child: Container(
                    height: 2,
                    width: double.maxFinite,
                    color: Color.fromRGBO(223, 222, 211, 1.0),
                  ),
                ),
                SizedBox(height: 10),
                Center(child: GoogleButton()),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Al registrar, aceptas las condiciones de nuestros terminos de uso, no olvides leer nuestras politica de privacidad',
                    maxLines: 2,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      // letterSpacing: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        :Dialog(
      backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(38.0),
       ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400,
           color: Color.fromRGBO(80, 182, 187, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text('* Para Comprar necesitas iniciar sesión',
                        style:TextStyle(color:Color.fromRGBO(223, 222, 211, 1.0), fontSize:12)),
                  ),
                ),
                Center(
                  child: Container(
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset(
                        'assets/images/promo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Text(
                    'Correo electronico',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 18,
                      // fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 3,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: TextField(
                    focusNode: textFocusNodeEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: textControllerEmail,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingEmail = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodeEmail.unfocus();
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800],
                          width: 3,
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Colors.blueGrey[300],
                      ),
                      hintText: "Correo electronico",
                      fillColor: Colors.white,
                      errorText: _isEditingEmail
                          ? _validateEmail(textControllerEmail.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 8,
                  ),
                  child: Text(
                    'Contraseña',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 3,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: TextField(
                    focusNode: textFocusNodePassword,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: textControllerPassword,
                    obscureText: true,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingPassword = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodePassword.unfocus();
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800],
                          width: 3,
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Colors.blueGrey[300],
                      ),
                      hintText: "Contraseña",
                      fillColor: Colors.white,
                      errorText: _isEditingPassword
                          ? _validatePassword(textControllerPassword.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(223, 222, 211, 1.0),
                                width: 3,
                              ),
                              borderRadius:  BorderRadius.circular(15.0)
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueGrey.shade800,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isLoggingIn = true;
                                textFocusNodeEmail.unfocus();
                                textFocusNodePassword.unfocus();
                              });
                              if (_validateEmail(textControllerEmail.text) ==
                                      null &&
                                  _validatePassword(
                                          textControllerPassword.text) ==
                                      null) {
                                await signInWithEmailPassword(
                                        textControllerEmail.text,
                                        textControllerPassword.text)
                                    .then((result) {
                                  if (result != null) {
                                    print(result);
                                    setState(() {
                                      loginStatus =
                                          'Iniciaste sesión';
                                      loginStringColor = Colors.green;
                                    });
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      Navigator.of(context).pop();
                                      if(uid=='RpkFN86vSBc6UJKyv3HlUs6jaO03'){
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) => adminHome(),
                                        ));
                                      }
                                    });
                                  }
                                }).catchError((error) {
                                  print('Login Error: $error');
                                  setState(() {
                                    loginStatus =
                                        'Error al iniciar sesión';
                                    loginStringColor = Colors.red;
                                  });
                                });
                              } else {
                                setState(() {
                                  loginStatus = 'Por favor entra tu e-mail y contraseña';
                                  loginStringColor = Colors.red;
                                });
                              }
                              setState(() {
                                _isLoggingIn = false;
                                textControllerEmail.text = '';
                                textControllerPassword.text = '';
                                _isEditingEmail = false;
                                _isEditingPassword = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: _isLoggingIn
                                  ? SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                              Color.fromRGBO(223, 222, 211, 1.0),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Iniciar sesión',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(223, 222, 211, 1.0),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(223, 222, 211, 1.0),
                                width: 3,
                              ),
                              borderRadius:  BorderRadius.circular(15.0)
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueGrey.shade800,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _isRegistering = true;
                              });
                              await registerWithEmailPassword(
                                      textControllerEmail.text,
                                      textControllerPassword.text)
                                  .then((result) {
                                if (result != null) {
                                  setState(() {
                                    loginStatus =
                                        'Registro exitoso';
                                    loginStringColor = Colors.green;
                                  });
                                  print(result);
                                }
                              }).catchError((error) {
                                print('Registration Error: $error');
                                setState(() {
                                  loginStatus =
                                      'Error en el registro';
                                  loginStringColor = Colors.red;
                                });
                              });

                              setState(() {
                                _isRegistering = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: _isRegistering
                                  ? SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Color.fromRGBO(223, 222, 211, 1.0)
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Registrate',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:Color.fromRGBO(223, 222, 211, 1.0)
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                loginStatus != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: Text(
                            loginStatus,
                            style: TextStyle(
                              color: loginStringColor,
                              fontSize: 14,
                              // letterSpacing: 3,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                  ),
                  child: Container(
                    height: 2,
                    width: double.maxFinite,
                    color: Color.fromRGBO(223, 222, 211, 1.0),
                  ),
                ),
                SizedBox(height: 20),
                Center(child: GoogleButton()),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Al registrar, aceptas las condiciones de nuestros terminos de uso, no olvides leer nuestras politica de privacidad',
                    maxLines: 2,
                    style: TextStyle(
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      // letterSpacing: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
