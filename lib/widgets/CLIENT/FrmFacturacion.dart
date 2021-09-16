/// Flutter code sample for RadioListTile

// ![RadioListTile sample](https://flutter.github.io/assets-for-api-docs/assets/material/radio_list_tile.png)
//
// This widget shows a pair of radio buttons that control the `_character`
// field. The field is of the type `SingingCharacter`, an enum.

import 'package:flutter/material.dart';

enum SingingCharacter { Boleta, Factura }
String _ruc,_razSoc,_metFact;
/// This is the stateful widget that the main application instantiates.
class Facturacion extends StatefulWidget {

  Facturacion({Key key}) : super(key: key);
  @override
  State<Facturacion> createState() => _FacturacionState();
  String metFact(){return _metFact;}
  String ruc(){return _ruc;}
  String razSoc(){return _razSoc;}

}

/// This is the private State class that goes with Facturacion.
class _FacturacionState extends State<Facturacion> {

  SingingCharacter _character = SingingCharacter.Boleta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<SingingCharacter>(
          activeColor: Color.fromRGBO(80, 182, 187, 1.0),
          title: const Text('Boleta de Venta'),
          value: SingingCharacter.Boleta,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              _metFact='Boleta';
            });
          },
        ),
        RadioListTile<SingingCharacter>(
          activeColor: Color.fromRGBO(80, 182, 187, 1.0),
          title: const Text('Factura'),
          value: SingingCharacter.Factura,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              _metFact= 'Factura';
            });
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Center(
            child: Container(
            child: _character==SingingCharacter.Factura?Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Center(
                    child: TextFormField(
                        cursorColor: Color.fromRGBO(223, 222, 211, 1.0),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'RUC',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          //hintText: 'Enter a Phone Number',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(223, 222, 211, 1.0)
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input!=null ? 'Introduce ruc' : null,
                        onChanged: (input) {
                          setState(() => _ruc = input);
                        }

                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Center(
                    child: TextFormField(
                        cursorColor: Color.fromRGBO(223, 222, 211, 1.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Razón Social',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          //hintText: 'Enter a Phone Number',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(223, 222, 211, 1.0)
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input!=null ? 'Introduce razón soacil' : null,
                        onChanged: (input) {
                          setState(() => _razSoc = input);
                        }

                    ),
                  ),
                ),
              ],
            ):null,
            ),
          ),
        )
      ],
    );
  }
}
