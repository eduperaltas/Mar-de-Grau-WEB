// @dart=2.9
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:mardegrau/widgets/CLIENT/Carousel.dart';
import 'package:flutter/material.dart';

class admin_carrousel extends StatefulWidget {
  admin_carrousel({
    Key key,
    this.screenSize,
  }) : super(key: key);
  final Size screenSize;
  @override
  _admin_carrouselState createState() => _admin_carrouselState();
}
class _admin_carrouselState extends State<admin_carrousel> {
  String _url1,_url2,_url3,_url4,_url5,_url6;
  Widget formulario(){
    return  Padding(
      padding: const EdgeInsets.all( 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PROMOCIONES:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    // fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 3,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Carrouseltxtbox(1,_url1),
                      IconButton(onPressed: (){CloudFirestoreAPI().deletecarrouselData(1);}, icon: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                  Row(
                    children: [
                      Carrouseltxtbox(2,_url2),
                      IconButton(onPressed: (){CloudFirestoreAPI().deletecarrouselData(2);}, icon: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                  Row(
                    children: [
                      Carrouseltxtbox(3,_url3),
                      IconButton(onPressed: (){CloudFirestoreAPI().deletecarrouselData(3);}, icon: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                  Row(
                    children: [
                      Carrouseltxtbox(4,_url4),
                      IconButton(onPressed: (){CloudFirestoreAPI().deletecarrouselData(4);}, icon: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                  Row(
                    children: [
                      Carrouseltxtbox(5,_url5),
                      IconButton(onPressed: (){CloudFirestoreAPI().deletecarrouselData(5);}, icon: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                  Row(
                    children: [
                      Carrouseltxtbox(6,_url6),
                      IconButton(onPressed: (){CloudFirestoreAPI().deletecarrouselData(6);}, icon: Icon(Icons.delete, color: Colors.red,))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child:ElevatedButton(
                        onPressed: () {
                          CloudFirestoreAPI().createCarrouselData(_url1,
                              _url2, _url3, _url4, _url5, _url6);
                        },
                        child: Text('Guardar',style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(80, 182, 187, 1.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Carrouseltxtbox(int num, String val){
    return Container(
      width: widget.screenSize.width*0.85,
      padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
      child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: val,
            labelText: 'URL de la imagen $num',
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                )
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide()
            ),
          ),
          validator: (input)=> input!=null ? 'Introduce URL' : null,
          onChanged: (input) {
            setState(() => val = input);
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.screenSize.width,
          color: Color.fromRGBO(80, 182, 187, 1.0),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 60,
            ),
            child: Column(
              children: [
                SizedBox(height: widget.screenSize.height * 0.05,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          'Carrousel',
                          style: TextStyle(
                            fontSize: 40,
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
                SizedBox(
                    height: 300,
                    width: widget.screenSize.width,
                    child: PromoCarousel()
                ),

                StreamBuilder(
                    stream: CloudFirestoreAPI().carrouselData,
                    builder: (context, snapshot) {
                      carrousel=snapshot.data;
                      if(!snapshot.hasData)
                        return Center(
                          child: Container(child: CircularProgressIndicator(color: Colors.white,)),
                        );
                      else
                          _url1=carrousel.img1;
                          _url2=carrousel.img2;
                          _url3=carrousel.img3;
                          _url4=carrousel.img4;
                          _url5=carrousel.img5;
                          _url6=carrousel.img6;
                        print('CAR IMG 1: '+carrousel.img1);
                        return formulario();
                  }
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}



