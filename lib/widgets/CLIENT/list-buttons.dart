import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/Providers/product_provider.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:provider/provider.dart';

opcion opc;
// int numopcion;
class radioButton extends StatefulWidget {
  final String title;
  final List<String> opciones;
  final int numopcion;
  radioButton({Key key,this.title,this.opciones,this.numopcion}) : super(key: key);
  @override
  _radioButtonState createState() => _radioButtonState();

}

class _radioButtonState extends State<radioButton> {


  Widget build(BuildContext context) {
  final _ProducProvider =
  Provider.of<ProductProvider>(context, listen: false);

  var screenSize = MediaQuery.of(context).size;
    return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: ResponsiveWidget.isSmallScreen(context)
                          ?screenSize.width/30:screenSize.width/55>=28?28:screenSize.width/55,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(221, 220, 210, 1.0)
                  ),)
              ],
            ),
            Container(
              child: ResponsiveWidget.isSmallScreen(context)
                  ?CustomRadioButton(
                      unSelectedBorderColor: Color.fromRGBO(221, 220, 210, 1.0),
                      enableShape: true,
                      horizontal: false,
                      enableButtonWrap: true,
                      wrapAlignment: WrapAlignment.center,
                      spacing: 0.0,
                      height: screenSize.width/15<35?35:screenSize.width/15,
                      width: screenSize.width/5<80?80:screenSize.width/5,
                      unSelectedColor: Color.fromRGBO(80, 182, 187, 1),
                      buttonLables: widget.opciones,
                      buttonValues: widget.opciones,
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Color.fromRGBO(221, 220, 210, 1.0),
                          unSelectedColor: Color.fromRGBO(221, 220, 210, 1.0),
                          textStyle: TextStyle(fontSize: screenSize.width/50<10?10:screenSize.width/50)),
                      radioButtonValue: (value) {
                        setState(() {
                          opc= opcion(Oname: widget.title,Oselect: value);
                        });
                        _ProducProvider.selectopcion(opc,widget.numopcion);
                      },
                      selectedColor: Color.fromRGBO(80, 182, 187, 0.3),
                    )
                  :CustomRadioButton(
                unSelectedBorderColor: Colors.transparent,
                enableShape: true,
                horizontal: false,
                enableButtonWrap: true,
                wrapAlignment: WrapAlignment.center,
                spacing: 0.0,
                height: screenSize.width/22>=60?60:screenSize.width/22,
                width: screenSize.width/8>=200?200:screenSize.width/8,
                unSelectedColor: Color.fromRGBO(80, 182, 187, 1),
                buttonLables: widget.opciones,
                buttonValues: widget.opciones,
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: Color.fromRGBO(221, 220, 210, 1.0),
                    unSelectedColor: Color.fromRGBO(221, 220, 210, 1.0),
                    textStyle: TextStyle(fontSize: screenSize.width/70>=18?18:screenSize.width/70)),
                radioButtonValue: (value) {
                  print(value);
                  setState(() {
                    opc= opcion(Oname: widget.title,Oselect: value);
                  });
                  _ProducProvider.selectopcion(opc,widget.numopcion);
                },
                selectedColor: Color.fromRGBO(80, 182, 187, 0.3),
              ),
            ),
          ],
        ),
    );
  }
}
