import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mardegrau/Model/products.dart';
import 'package:mardegrau/screens/Admin.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:mardegrau/widgets/CLIENT/list-buttons.dart';
import 'package:flutter/material.dart';

import 'AdminProduct.dart';


class ProductsAdmin extends StatefulWidget {
  ProductsAdmin({
    Key key,
    this.screenSize, this.action,this.plato
  }) : super(key: key);
  String action;
  ProductModel plato;
  final Size screenSize;
  @override
  _ProductsAdmintate createState() => _ProductsAdmintate();
}

bool tabla = false;
class _ProductsAdmintate extends State<ProductsAdmin> {

  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;
  String _nombre,_descrip,_imagen,_precio,optitulo,_categoria,_op1,_op2,_op3,_op4,_op5,_op6,_op7,_op8;
  bool enombre=false,eDescrip=false,ePrecio=false,Eopciones=false,eImagen=false;
   List<radioButton> Woptionlist=[];List<DropdownMenuItem> categoriasitems=[];
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  var selectedCurrency;
  String sd="Selecciona";

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    // if (widget.action=="edita"){
    //   enombre=true;
    //   eDescrip=true;
    //   ePrecio=true;
    //   Eopciones=true;
    //   eImagen=true;
    // }

    super.setState(fn);
  }

  final myController = TextEditingController();
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  Widget editoptbtn(radioButton opcion){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 120,
      child: RaisedButton(
          hoverElevation: 1.5,
          shape: StadiumBorder(
              side: BorderSide(
                  color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
          color: Color.fromRGBO(80, 182, 187, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Editar",style:
                TextStyle(
                    color: Color.fromRGBO(223, 222, 211, 1.0),
                    fontSize:16
                ),),
                Icon(Icons.edit,color: Color.fromRGBO(223, 222, 211, 1.0),),
              ],
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => UPTProductoptionDialog(opcion),
            );
          }),
    ),
  );
}

  Widget opciones(){
    return StreamBuilder(
        stream: CloudFirestoreAPI(pid: widget.plato.id).opcionesdata,
        builder:(context, snapshot){
          if(!snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Container(child: CircularProgressIndicator(color: Colors.white,)),
              ),
            );
          }
          List<radioButton>Woptionlistbd=snapshot.data;
          // return Container();
          return Padding(
            padding: const EdgeInsets.only(bottom: 5,left: 50),
            child: Column(
              children: [
                Woptionlistbd.length>0?Woptionlistbd[0]:Container(),
                Woptionlistbd.length>0?editoptbtn(Woptionlistbd[0]):Container(),
                Woptionlistbd.length>1?Woptionlistbd[1]:Container(),
                Woptionlistbd.length>1?editoptbtn(Woptionlistbd[1]):Container(),
                Woptionlistbd.length>2?Woptionlistbd[2]:Container(),
                Woptionlistbd.length>2?editoptbtn(Woptionlistbd[2]):Container(),
                Woptionlistbd.length>3?Woptionlistbd[3]:Container(),
                Woptionlistbd.length>3?editoptbtn(Woptionlistbd[3]):Container(),
                Woptionlistbd.length>4?Woptionlistbd[4]:Container(),
                Woptionlistbd.length>4?editoptbtn(Woptionlistbd[4]):Container(),
                Woptionlistbd.length>5?Woptionlistbd[5]:Container(),
                Woptionlistbd.length>5?editoptbtn(Woptionlistbd[5]):Container(),
                Woptionlistbd.length>6?Woptionlistbd[6]:Container(),
                Woptionlistbd.length>6?editoptbtn(Woptionlistbd[6]):Container(),
              ],
            ),
          );
        }
    );
  }

  Widget SETNewProductoptionDialog(){
    List<String> opciones=[];
    return Dialog(
      backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 300,
            color: Color.fromRGBO(80, 182, 187, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Nuevas opciones',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(223, 222, 211, 1.0),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 15),
                    Expanded(child: Container(
                      alignment: Alignment.center,
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      height: 7,
                    ),),
                  ],
                ),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Titulo',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => optitulo = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 1',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op1 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 2',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op2 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 3',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op3 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 4',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op4 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 5',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op5 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 6',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op6 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 7',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op7 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 8',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op8 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 120,
                    child: RaisedButton(
                        hoverElevation: 1.5,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                        color: Color.fromRGBO(80, 182, 187, 1.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Guardar",style:
                              TextStyle(
                                  color: Color.fromRGBO(223, 222, 211, 1.0),
                                  fontSize:16
                              ),),
                              Icon(Icons.save,color: Color.fromRGBO(223, 222, 211, 1.0),),
                            ],
                          ),
                        ),
                        onPressed: () {
                          if(_op1!=null)opciones.add(_op1);
                          if(_op2!=null)opciones.add(_op2);
                          if(_op3!=null)opciones.add(_op3);
                          if(_op4!=null)opciones.add(_op4);
                          if(_op5!=null)opciones.add(_op5);
                          if(_op6!=null)opciones.add(_op6);
                          if(_op7!=null)opciones.add(_op7);
                          if(_op8!=null)opciones.add(_op8);
                          radioButton rd = radioButton(title: optitulo,opciones: opciones,);
                          setState(() { Woptionlist.add(rd); });
                          Navigator.of(context).pop();
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget UPTProductoptionDialog(radioButton opcion){
    List<String> opciones=[];
    return Dialog(
      backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 300,
            color: Color.fromRGBO(80, 182, 187, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Actualizar opciones',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(223, 222, 211, 1.0),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 15),
                    Expanded(child: Container(
                      alignment: Alignment.center,
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      height: 7,
                    ),),
                  ],
                ),

                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 1',
                          hintText: opcion.opciones.length>0?opcion.opciones[0]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op1 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 2',
                          hintText: opcion.opciones.length>1?opcion.opciones[1]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op2 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 3',
                          hintText: opcion.opciones.length>2?opcion.opciones[2]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op3 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 4',
                          hintText: opcion.opciones.length>3?opcion.opciones[3]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op4 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 5',
                          hintText: opcion.opciones.length>4?opcion.opciones[4]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op5 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 6',
                          hintText: opcion.opciones.length>5?opcion.opciones[5]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op6 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 7',
                          hintText: opcion.opciones.length>6?opcion.opciones[6]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op7 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(child: Container(
                  width:300,
                  child: Center(
                    child: TextFormField(
                        maxLines: 1,
                        cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                        decoration: InputDecoration(
                          labelText: 'Opcion 8',
                          hintText: opcion.opciones.length>6?opcion.opciones[7]:'',
                          labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                              )
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide()
                          ),
                        ),
                        validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                        onChanged: (input) {
                          setState(() => _op8 = input);
                        }
                    ),
                  ),
                )),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: RaisedButton(
                            hoverElevation: 1.5,
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                            color: Colors.red.withOpacity(0.7),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Eliminar",style:
                                  TextStyle(
                                      color: Color.fromRGBO(223, 222, 211, 1.0),
                                      fontSize:16
                                  ),),
                                  Icon(Icons.delete,color: Color.fromRGBO(223, 222, 211, 1.0),),
                                ],
                              ),
                            ),
                            onPressed: () {
                              CloudFirestoreAPI().deleteopcion(widget.plato.id,opcion.title);
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        width: 120,
                        child: RaisedButton(
                            hoverElevation: 1.5,
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                            color: Color.fromRGBO(80, 182, 187, 1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Guardar",style:
                                  TextStyle(
                                      color: Color.fromRGBO(223, 222, 211, 1.0),
                                      fontSize:16
                                  ),),
                                  Icon(Icons.save,color: Color.fromRGBO(223, 222, 211, 1.0),),
                                ],
                              ),
                            ),
                            onPressed: () {
                              if(_op1==null) if(opcion.opciones.length>0)opciones.add(opcion.opciones[0]);
                              if(_op1!=null)opciones.add(_op1);
                              if(_op2==null)if(opcion.opciones.length>1)opciones.add(opcion.opciones[1]);
                              if(_op2!=null)opciones.add(_op2);
                              if(_op3==null)if(opcion.opciones.length>2)opciones.add(opcion.opciones[2]);
                              if(_op3!=null)opciones.add(_op3);
                              if(_op4==null)if(opcion.opciones.length>3)opciones.add(opcion.opciones[3]);
                              if(_op4!=null)opciones.add(_op4);
                              if(_op5==null)if(opcion.opciones.length>4)opciones.add(opcion.opciones[4]);
                              if(_op5!=null)opciones.add(_op5);
                              if(_op6==null)if(opcion.opciones.length>5)opciones.add(opcion.opciones[5]);
                              if(_op6!=null)opciones.add(_op6);
                              if(_op7==null)if(opcion.opciones.length>6)opciones.add(opcion.opciones[6]);
                              if(_op7!=null)opciones.add(_op7);
                              if(_op8==null)if(opcion.opciones.length>7)opciones.add(opcion.opciones[7]);
                              if(_op8!=null)opciones.add(_op8);

                              radioButton rd = new radioButton(title: opcion.title,opciones: opciones,);
                              CloudFirestoreAPI().updateopcion(widget.plato.id,rd);
                              Navigator.of(context).pop();
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eproduct(){
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //IMAGEN
                Container(
                  width: screenSize.height/3,
                  height: 650,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child:  Column(
                      children: [
                        Card(
                          color: Colors.transparent,
                          child:  new Container(
                            height: 250,
                            width: screenSize.height/3,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Color.fromRGBO(43, 43, 44, 1.0),
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                                  image: new NetworkImage(
                                      widget.plato.picture
                                  ),
                                )
                            ),
                          child: InkWell(
                            onHover: (value) {
                              setState(() {
                                value
                                    ? _isHovering[1] = true
                                    : _isHovering[1] = false;
                              });
                            },
                            onTap: (){
                              setState(() {
                                eImagen=true;
                              });
                            },
                            child: Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: !_isHovering[1],
                              child: Container(
                                height: 250,
                                width: screenSize.height/3,
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                          widget.plato.picture
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                  ),
                        eImagen?Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Container(
                            width:(screenSize.height/3)-10,
                            child: Center(
                              child: TextFormField(
                                  maxLines: 1,
                                  cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                  decoration: InputDecoration(
                                    labelText: 'URL Imagen',
                                    labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                    hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                    //hintText: data['nombre'],
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(221, 220, 210, 1.0),
                                        )
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide()
                                    ),
                                  ),
                                  validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                  onChanged: (input) {
                                    setState(() => _imagen = input);
                                    _imagen = input;
                                  }
                              ),
                            ),)
                        )
                            :Container()
                      ],
                    ))),
                Container(/*
                  color: Colors.red,*/
                  width: screenSize.width*0.6>=750?750:screenSize.width*0.6,

                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Container(
                          /*width: screenSize.width/2,*/
                          child: Padding(
                            padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              enombre?Container(
                                width:250,
                                child: Center(
                                  child: TextFormField(
                                      maxLines: 2,
                                      cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                      decoration: InputDecoration(
                                        labelText: widget.plato.name,
                                        labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                        hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                        //hintText: data['nombre'],
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(221, 220, 210, 1.0),
                                            )
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide()
                                        ),
                                      ),
                                      validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                      onChanged: (input) {
                                        setState(() => _nombre = input);
                                        _nombre = input;
                                      }
                                  ),
                                ),):
                              Row(
                                children: [
                                  Text(
                                    widget.plato.Pname,
                                    style: TextStyle(
                                        fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(221, 220, 210, 1.0)
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          enombre=true;
                                        });print(enombre);}, icon: Icon(Icons.edit))
                                ],
                              ),

                              ePrecio?Container(
                                width:250,
                                child: Center(
                                  child: TextFormField(
                                      maxLines: 1,
                                      cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                      decoration: InputDecoration(
                                        labelText: 'Precio',
                                        labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                        hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                        hintText: widget.plato.price.toStringAsFixed(2),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(221, 220, 210, 1.0),
                                            )
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide()
                                        ),
                                      ),
                                      validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                      onChanged: (input) {
                                        setState(() => _precio = input);
                                        _precio = input;
                                      }
                                  ),
                                ),):
                              Row(
                                children: [
                                  Text(
                                    'S/. '+widget.plato.price.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(221, 220, 210, 1.0)
                                      // color: Color.fromRGBO(
                                      //     221, 220, 210, 1.0)
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          ePrecio=true;
                                        });print(ePrecio);}, icon: Icon(Icons.edit))
                                ],
                              ),
                            ],
                          ),
                        )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            /*width: screenSize.width/2,*/
                            child: Padding(
                              padding: const EdgeInsets.only(left:55.0,right: 130,bottom: 5),
                              child: eDescrip?Container(
                                width:screenSize.width/4,
                                child: Center(
                                  child: TextFormField(
                                      maxLines: 3,
                                      cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                      decoration: InputDecoration(
                                        labelText: 'descripcion',
                                        labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                        hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                        hintText: widget.plato.description,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(221, 220, 210, 1.0),
                                            )
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide()
                                        ),
                                      ),
                                      validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                      onChanged: (input) {
                                        setState(() => _descrip = input);
                                        _descrip = input;
                                      }
                                  ),
                                ),):
                              Row(
                                children: [
                                  Container(
                                    width: screenSize.width/4,
                                    child: Text(
                                      widget.plato.Pdescription,
                                      style: TextStyle(
                                          fontSize: screenSize.width/70>=18?18:screenSize.width/70,
                                          fontFamily: 'Montserrat',
                                          color: Color.fromRGBO(221, 220, 210, 1.0)
                                        // color: Color.fromRGBO(
                                        //     221, 220, 210, 1.0)
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          eDescrip=true;
                                        });print(eDescrip);}, icon: Icon(Icons.edit))
                                ],
                              )),

                          ),
                        ),
                        //DIVIDER
                        Padding(
                          padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                          child: Container(
                            color:Color.fromRGBO(223, 222, 211, 1.0),
                            height: 0.7,
                          ),
                        ),
                        opciones(),
                        //SECCION ELECCION
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 50),
                              child:Woptionlist.length>0?Woptionlist[0]:Container(),
                            )),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 50),
                              child:Woptionlist.length>1?Woptionlist[1]:Container(),
                            )),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 50),
                              child:Woptionlist.length>2?Woptionlist[2]:Container(),
                            )),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 50),
                              child:Woptionlist.length>3?Woptionlist[3]:Container(),
                            )),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 50),
                              child:Woptionlist.length>4?Woptionlist[4]:Container(),
                            )),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 50),
                              child:Woptionlist.length>5?Woptionlist[5]:Container(),
                            )),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5,left: 50),
                              child:Woptionlist.length>6?Woptionlist[6]:Container(),
                            )),
                        FloatingActionButton(
                          backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
                          onPressed: () => setState(() {
                            List<String> opciones;
                            String titulo;
                            showDialog(
                              context: context,
                              builder: (context) => SETNewProductoptionDialog(),
                            );
                          }),
                          tooltip: 'Agregar lista de opciones',
                          child: Icon(Icons.add,size:30,color: Colors.white,),
                        ),

                        //Seccion COMENTARIO
                        Padding(
                          padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                          child: Column(
                            children: [
                              Container(
                                width: screenSize.width/2,
                                child: Text(
                                  'Comentario (Opcional)',
                                  style: TextStyle(
                                      fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(221, 220, 210, 1.0)
                                  ),
                                ),
                              ),
                              Container(
                                //color: Colors.black,
                                width: screenSize.width/2,
                                child: Text(
                                  'Indicanos si quiere hacer alguna modificación a tu plato',
                                  style: TextStyle(
                                      fontSize: screenSize.width/78>=18?18:screenSize.width/78,
                                      fontFamily: 'Montserrat',
                                      color: Color.fromRGBO(221, 220, 210, 1.0)
                                    // color: Color.fromRGBO(
                                    //     221, 220, 210, 1.0)
                                  ),
                                ),
                              ),
                              Container(
                                width: screenSize.width/2,
                                child: Container(
                                  child: TextField(
                                      controller: myController,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                      maxLines: 6,
                                      style: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0)),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 4.0),
                                        ),
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 1.0),),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                                      )
                                  ),
                                ),
                              ),
                              //DEVIDER
                              Padding(
                                padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                                child: Container(
                                  color:Color.fromRGBO(223, 222, 211, 1.0),
                                  height: 0.7,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Contador
                        Padding(
                          padding: const EdgeInsets.only(top:10,/*left:50.0*/right: 40),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 240,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RaisedButton(
                                      hoverElevation: 1.5,
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                                      color: Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Eliminar",style:
                                            TextStyle(
                                                color: Color.fromRGBO(223, 222, 211, 1.0),
                                                fontSize: screenSize.width/50>=14?14:screenSize.width/50
                                            ),),
                                            Icon(Icons.delete,color: Color.fromRGBO(223, 222, 211, 1.0),),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        CloudFirestoreAPI().deleteproduct(widget.plato.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => adminHome(screen: 'Productos',)),
                                        );
                                      }),
                                  RaisedButton(
                                      hoverElevation: 1.5,
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                                      color: Color.fromRGBO(80, 182, 187, 1.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Guardar",style:
                                            TextStyle(
                                                color: Color.fromRGBO(223, 222, 211, 1.0),
                                                fontSize: screenSize.width/50>=14?14:screenSize.width/50
                                            ),),
                                            Icon(Icons.save,color: Color.fromRGBO(223, 222, 211, 1.0),),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                                //GUARDAR EN BD
                                                // Woptionlist
                                                setState(() {
                                                  if(_precio.toString()=='null')   _precio=widget.plato.price.toStringAsFixed(2);
                                                  if(_imagen.toString()=='null'   )_imagen=widget.plato.picture;
                                                  if(_nombre.toString()=='null'   )_nombre=widget.plato.name;
                                                  if(_descrip.toString()=='null'  )_descrip=widget.plato.description;
                                                  if(_categoria.toString()=='null')_categoria=widget.plato.categoria;

                                                });

                                                ProductModel plato=ProductModel(
                                                    Pprice: double.parse(_precio),
                                                    Ppicture: _imagen,
                                                    Pname: _nombre,
                                                    Pdescription: _descrip,
                                                    Pcategoria: _categoria,
                                                    Pid: widget.plato.id,
                                                    lopciones: Woptionlist
                                                );
                                                CloudFirestoreAPI().updateProduct(plato);
                                                Woptionlist.clear();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => adminHome(screen: 'Productos',)),
                                                );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  Widget categorias(){
    return Form(
      key: _formKeyValue,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("categories").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(child: Text("Loading....."));
            else {
              List<DropdownMenuItem> currencyItems = [];
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                DocumentSnapshot snap = snapshot.data.docs[i];
                currencyItems.add(
                  DropdownMenuItem(
                    child: Text(
                      snap['titulo'],
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                    value: "${snap.id}",
                  ),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                    items: currencyItems,
                    onChanged: (currencyValue) {
                      final snackBar = SnackBar(
                        content: Text(
                          'Selected Currency value is $currencyValue',
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                      setState(() {
                        selectedCurrency = currencyValue;
                        _categoria = currencyValue;
                      });
                    },
                    value: selectedCurrency,
                    isExpanded: false,
                    hint: new Text(
                      sd,
                      style: TextStyle(color: Color(0xff11b719)),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget nproduct(){
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //IMAGEN
                Container(
                  width: screenSize.height/3,
                  height: 650,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child:  Column(
                      children: [
                        Center(
                          child: Row(
                            children: [
                              Text('Categoria: '),
                              categorias()
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              color: Colors.black12,
                            ),
                            Container(
                              height: 250,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.image, color: Colors.white,size: 80,)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                            child:Container(
                              width:(screenSize.height/3)-10,
                              child: Center(
                                child: TextFormField(
                                    maxLines: 1,
                                    cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                    decoration: InputDecoration(
                                      labelText: 'URL Imagen',
                                      labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                      hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                      //hintText: data['nombre'],
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(221, 220, 210, 1.0),
                                          )
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()
                                      ),
                                    ),
                                    validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                    onChanged: (input) {
                                      setState(() => _imagen = input);
                                      _imagen = input;
                                    }
                                ),
                              ),)

                        )
                      ],
                    ))),
                Container(/*
                  color: Colors.red,*/
                  width: screenSize.width*0.6>=750?750:screenSize.width*0.6,
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                            width:250,
                            child: Center(
                              child: TextFormField(
                                  maxLines: 2,
                                  cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                  decoration: InputDecoration(
                                    labelText: 'Nombre',
                                    labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                    hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                    //hintText: data['nombre'],
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(221, 220, 210, 1.0),
                                        )
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide()
                                    ),
                                  ),
                                  validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                  onChanged: (input) {
                                    setState(() => _nombre = input);
                                    _nombre = input;
                                  }
                              ),
                            ),),
                            Container(
                              width:250,
                              child: Center(
                                child: TextFormField(
                                    maxLines: 2,
                                    cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                    decoration: InputDecoration(
                                      labelText: 'Precio',
                                      labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                      hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                      //hintText: data['nombre'],
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(221, 220, 210, 1.0),
                                          )
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()
                                      ),
                                    ),
                                    validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                    onChanged: (input) {
                                      setState(() => _precio = input);
                                      _precio = input;
                                    }
                                ),
                              ),)
                          ],
                        ),
                      )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          /*width: screenSize.width/2,*/
                          child: Padding(
                            padding: const EdgeInsets.only(left:55.0,right: 130,bottom: 5),
                            child:  Container(
                              width:250,
                              child: Center(
                                child: TextFormField(
                                    maxLines: 3,
                                    cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                    decoration: InputDecoration(
                                      labelText: 'descrip',
                                      labelStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                      hintStyle: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0),),
                                      //hintText: data['nombre'],
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(221, 220, 210, 1.0),
                                          )
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()
                                      ),
                                    ),
                                    validator: (input)=> input.length==0 ? 'Dato incompleto' : null,
                                    onChanged: (input) {
                                      setState(() => _descrip = input);
                                      _descrip = input;
                                    }
                                ),
                              ),),

                          )
                        ),
                      ),
                      //DIVIDER
                      Padding(
                        padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                        child: Container(
                          color:Color.fromRGBO(223, 222, 211, 1.0),
                          height: 0.7,
                        ),
                      ),

                      //SECCION ELECCION
                      Padding(
                        padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                        child: Column(
                          children: [
                            Container(
                              width: screenSize.width/2,
                              child: Text(
                                'Opciones del plato',
                                style: TextStyle(
                                    fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                  // color: Color.fromRGBO(
                                  //     221, 220, 210, 1.0)
                                ),
                              ),
                            ),
                            Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5,left: 50),
                                  child:Woptionlist.length>0?Woptionlist[0]:Container(),
                                )),
                            Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5,left: 50),
                                  child:Woptionlist.length>1?Woptionlist[1]:Container(),
                                )),
                            Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5,left: 50),
                                  child:Woptionlist.length>2?Woptionlist[2]:Container(),
                                )),
                            Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5,left: 50),
                                  child:Woptionlist.length>3?Woptionlist[3]:Container(),
                                )),
                            Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5,left: 50),
                                  child:Woptionlist.length>4?Woptionlist[4]:Container(),
                                )),
                            Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5,left: 50),
                                  child:Woptionlist.length>5?Woptionlist[5]:Container(),
                                )),
                            Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5,left: 50),
                                  child:Woptionlist.length>6?Woptionlist[6]:Container(),
                                )),
                          ],
                        ),
                      ),

                      FloatingActionButton(
                        backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
                        onPressed: () => setState(() {
                          List<String> opcion;
                          String titulo;
                          showDialog(
                            context: context,
                            builder: (context) => SETNewProductoptionDialog(),
                          );
                        }),
                        tooltip: 'Agregar lista de opciones',
                        child: Icon(Icons.add,size:30,color: Colors.white,),
                      ),
                      SizedBox(height: 100,),
                      //Seccion COMENTARIO
                      Padding(
                        padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                        child: Column(
                          children: [
                            Container(
                              width: screenSize.width/2,
                              child: Text(
                                'Comentario (Opcional)',
                                style: TextStyle(
                                    fontSize: screenSize.width/50>=28?28:screenSize.width/50,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                  // color: Color.fromRGBO(
                                  //     221, 220, 210, 1.0)
                                ),
                              ),
                            ),
                            Container(
                              //color: Colors.black,
                              width: screenSize.width/2,
                              child: Text(
                                'Indicanos si quiere hacer alguna modificación a tu plato',
                                style: TextStyle(
                                    fontSize: screenSize.width/78>=18?18:screenSize.width/78,
                                    fontFamily: 'Montserrat',
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                  // color: Color.fromRGBO(
                                  //     221, 220, 210, 1.0)
                                ),
                              ),
                            ),
                            Container(
                              width: screenSize.width/2,
                              child: Container(
                                child: TextField(
                                    controller: myController,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                                    maxLines: 6,
                                    style: TextStyle(color: Color.fromRGBO(221, 220, 210, 1.0)),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 4.0),
                                      ),
                                      border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(221, 220, 210, 1.0), width: 1.0),),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                                    )
                                ),
                              ),
                            ),
                            //DEVIDER
                            Padding(
                              padding: const EdgeInsets.only(left:50.0,bottom: 5,right:50.0),
                              child: Container(
                                color:Color.fromRGBO(223, 222, 211, 1.0),
                                height: 0.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Contador
                      Padding(
                        padding: const EdgeInsets.only(top:10,left:50.0,right: 40),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 120,
                            child: RaisedButton(
                                hoverElevation: 1.5,
                                shape: StadiumBorder(
                                    side: BorderSide(
                                        color: Color.fromRGBO(223, 222, 211, 1.0) , width: 4)),
                                color: Color.fromRGBO(80, 182, 187, 1.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Guardar",style:
                                      TextStyle(
                                          color: Color.fromRGBO(223, 222, 211, 1.0),
                                          fontSize: screenSize.width/50>=14?14:screenSize.width/50
                                      ),),
                                      Icon(Icons.save,color: Color.fromRGBO(223, 222, 211, 1.0),),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  //GUARDAR EN BD
                                  // Woptionlist
                                  ProductModel plato=ProductModel(
                                    Pprice: double.parse(_precio),
                                    Ppicture: _imagen,
                                    Pname: _nombre,
                                    Pdescription: _descrip,
                                    Pcategoria: _categoria,
                                    lopciones: Woptionlist
                                  );
                                   CloudFirestoreAPI().createProduct(plato);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => adminHome(screen: 'Productos',)),
                                  );
                                }),
                          ),
                        ),
                      )

                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
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

    return Container(
         child: widget.action=="edita"?eproduct():nproduct()
    );

  }
}



