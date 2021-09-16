import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBarColumn extends StatelessWidget {
  final String heading;
  final String s1;
  final String s2;
  final String s3;
  final String l1;
  final String l2;
  final String l3;
  final IconData i1;
  final IconData i2;
  final IconData i3;

  BottomBarColumn({
    this.heading,
    this.s1,
    this.s2,
    this.s3,
    this.i1,
    this.i2,
    this.i3,
    this.l1,
    this.l2,
    this.l3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Color.fromRGBO(223, 222, 211, 1.0),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            hoverColor: Colors.transparent,
              onTap: () => l1==null?null:launch(l1.toString()),
              child:Row(
            children: [
              i1==null?SizedBox(width: 0,):Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Icon(i1,
                  size: 20,
                  color: Color.fromRGBO(223, 222, 211, 1.0),),
              ),
              Text(
                s1,
                style: TextStyle(
                  color: Color.fromRGBO(223, 222, 211, 1.0),
                  fontSize: 14,
                ),
              ),
            ],
          )),
          SizedBox(height: 5),
          InkWell(
              hoverColor: Colors.transparent,
              onTap: () => l2==null?null:launch(l2.toString()),
              child:Row(
            children: [
              i2==null?SizedBox(width: 0,):Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Icon(i2,
                  size: 20,
                  color: Color.fromRGBO(223, 222, 211, 1.0),),
              ),
              Text(
                s2,
                style: TextStyle(
                  color: Color.fromRGBO(223, 222, 211, 1.0),
                  fontSize: 14,
                ),
              ),
            ],
          )),
          SizedBox(height: 5),
          InkWell(
              hoverColor: Colors.transparent,
              onTap: () => l3==null?null:launch(l3.toString()),
              child:Row(
            children: [
              i3==null?SizedBox(width: 0,):Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Icon(i3,
                  size: 20,
                  color: Color.fromRGBO(223, 222, 211, 1.0),),
              ),
              Text(
                s3,
                style: TextStyle(
                  color: Color.fromRGBO(223, 222, 211, 1.0),
                  fontSize: 14,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
