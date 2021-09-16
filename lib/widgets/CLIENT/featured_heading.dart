import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key key,
    this.title,
    this.subtitle,
    this.screenSize,
  }) : super(key: key);

  final Size screenSize;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        //top: screenSize.height * 0.05,
        left: screenSize.width / 15,
        right: screenSize.width / 15,
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ?  Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container(
            color: Color.fromRGBO(223, 222, 211, 1.0),
            height: 4,
          ),),
          SizedBox(width: 5),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(223, 222, 211, 1.0),
                ),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(223, 222, 211, 1.0),
                ),
              ),

            ],
          ),
          SizedBox(width: 5),
          Expanded(child: Container(
            alignment: Alignment.center,
            color: Color.fromRGBO(223, 222, 211, 1.0),
            height: 4,
          ),),
        ],
      )
          : Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container(
                  color: Color.fromRGBO(223, 222, 211, 1.0),
                  height: 7,
                ),),
                SizedBox(width: 15),
                Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(223, 222, 211, 1.0),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                        subtitle,
                        textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(223, 222, 211, 1.0),
                        fontSize: 20,
                      ),
                      ),

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
    );
  }
}
