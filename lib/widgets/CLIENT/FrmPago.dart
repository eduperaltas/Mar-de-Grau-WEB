/// Flutter code sample for RadioListTile

// ![RadioListTile sample](https://flutter.github.io/assets-for-api-docs/assets/material/radio_list_tile.png)
//
// This widget shows a pair of radio buttons that control the `_character`
// field. The field is of the type `SingingCharacter`, an enum.

import 'package:flutter/material.dart';

enum SingingCharacter { PonlineT, PcontraentregaT,Pefectivo,RecojoTienda }
String Pmetodo;
String _efectivo;
/// This is the stateful widget that the main application instantiates.
class metodosdePago extends StatefulWidget {

  metodosdePago({Key key}) : super(key: key);
  @override
  State<metodosdePago> createState() => _metodosdePagoState();
  String metodo(){return Pmetodo;}
  String efectivoacancelar(){return _efectivo;}
}

/// This is the private State class that goes with metodosdePago.
class _metodosdePagoState extends State<metodosdePago> {
  SingingCharacter _character = SingingCharacter.PonlineT;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<SingingCharacter>(
          activeColor: Color.fromRGBO(80, 182, 187, 1.0),
          title: const Text('Pago en líne con tarjeta'),
          value: SingingCharacter.PonlineT,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              Pmetodo='Pago en líne con tarjeta';
            });
          },
        ),
        RadioListTile<SingingCharacter>(
          activeColor: Color.fromRGBO(80, 182, 187, 1.0),
          title: const Text('Pago en casa/oficina con tarjeta'),
          value: SingingCharacter.PcontraentregaT,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              Pmetodo='Pago en casa/oficina con tarjeta';
            });
          },
        ),
        RadioListTile<SingingCharacter>(
          activeColor: Color.fromRGBO(80, 182, 187, 1.0),
          title: const Text('Recojo en Tienda'),
          value: SingingCharacter.RecojoTienda,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              Pmetodo='Recojo en Tienda';
            });
          },
        ),
        RadioListTile<SingingCharacter>(
          activeColor: Color.fromRGBO(80, 182, 187, 1.0),
          title: const Text('Efectivo'),
          value: SingingCharacter.Pefectivo,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              Pmetodo='Efectivo';
            });
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 220,
          child: _character==SingingCharacter.Pefectivo?Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Center(
              child: TextFormField(
                  cursorColor: Color.fromRGBO(223, 222, 211, 1.0),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '¿Con cuanto pagaras?',
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
                  validator: (input)=> input!=null ? 'Introduce el monto con el que pagaras' : null,
                  onChanged: (input) {
                    setState(() => _efectivo = input);
                  }
              ),
            ),
          ):null,
          ),
        )
      ],
    );
  }
}
