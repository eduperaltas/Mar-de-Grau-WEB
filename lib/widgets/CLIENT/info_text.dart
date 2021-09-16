import 'package:flutter/material.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoText extends StatelessWidget {
  final String type;
  final String text;
  final String link;

  InfoText({this.type, this.text, this.link});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ?Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$type: ',
          style: TextStyle(
            color: Color.fromRGBO(223, 222, 211, 1.0),
            fontSize: 16,
          ),
        ),
        InkWell(
            hoverColor: Colors.transparent,
            onTap: () => link==null?null:launch(link.toString()),
            child:Text(
              text,
              style: TextStyle(
                color: Color.fromRGBO(223, 222, 211, 1.0),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ))
      ],
    ):Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$type: ',
          style: TextStyle(
            color: Color.fromRGBO(223, 222, 211, 1.0),
            fontSize: 16,
          ),
        ),
        InkWell(
            hoverColor: Colors.transparent,
            onTap: () => link==null?null:launch(link.toString()),
            child:Text(
              text,
              style: TextStyle(
                color: Color.fromRGBO(223, 222, 211, 1.0),
                fontSize: 16,
              ),
            ))
      ],
    );
  }
}
