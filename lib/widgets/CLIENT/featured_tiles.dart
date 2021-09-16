import 'package:mardegrau/Model/categories.dart';
import 'package:mardegrau/screens/Products.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:mardegrau/widgets/CLIENT/responsive.dart';
import 'package:flutter/material.dart';


class FeaturedTiles extends StatefulWidget {
  FeaturedTiles({
    Key key,
    this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  _FeaturedTilesState createState() => _FeaturedTilesState();
}


class _FeaturedTilesState extends State<FeaturedTiles> {

  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Widget tile(CategoriesModel tile, String size,int index ) {
    var screenSize = MediaQuery.of(context).size;
    return new InkWell(
      onHover: (value) {
        setState(() {
          value
              ? _isHovering[index] = true
              : _isHovering[index] = false;
        });
      },
      onTap: () {
         Navigator.of(context).pushReplacement(
           MaterialPageRoute(
             fullscreenDialog: true,
             builder: (context) => categorias(tile.titulo,tile.uid),
           ),
         );
      },
      child:new Card(
        color: Colors.transparent,
          child:  new Container(
          decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Color.fromRGBO(43, 43, 44, 1.0),
          image: new DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
          image: new NetworkImage(tile.img),
          )

          ),
        height: 10,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Visibility(
                maintainAnimation: true,
                maintainState: true,
                maintainSize: true,
                visible: !_isHovering[index],
                child: SizedBox(
              height: size=='normal' ?screenSize.width / 4.5 : screenSize.width / 1.5,
              width: size=='normal' ?screenSize.width / 1.5:screenSize.width / 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: Image.network(tile.img, fit: BoxFit.cover,),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                tile.titulo,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(
                        221, 220, 210, 1.0)
                    // color: Color.fromRGBO(
                    //     221, 220, 210, 1.0)
                ),
              ),
            ),
            Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: _isHovering[index],
              child: Padding(
                padding: size=='normal' ?const EdgeInsets.only(bottom: 10,right: 10):const EdgeInsets.only(bottom: 0,right: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Ver mas',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(
                                  221, 220, 210, 1.0)
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 50,
                          color:  Color.fromRGBO(223, 222, 211, 1.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
   return StreamBuilder(
       stream: CloudFirestoreAPI().catoriesdata,
    builder:(context, snapshot){
      if(!snapshot.hasData){
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(child: CircularProgressIndicator(color: Colors.white,)),
          ),
        );
      }
      List<CategoriesModel> choices=snapshot.data;
      return ResponsiveWidget.isSmallScreen(context)
          ? Padding(
        padding: EdgeInsets.only(
          left: widget.screenSize.width / 25,
          right: widget.screenSize.width / 25,
          bottom: widget.screenSize.width / 15,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              new GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  childAspectRatio: (2 / 1),
                ),
                itemCount: choices.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return tile(choices[index],'small', index);
                },
              ),
            ],
          ),
        ),
      )
          : Padding(
        padding: EdgeInsets.only(
          left: widget.screenSize.width / 20,
          right: widget.screenSize.width / 20,
          bottom: widget.screenSize.width / 15,
        ),
        child: Column(
          children: [
            new GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).orientation ==
                    Orientation.landscape ? 4: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: (1.5 / 1),
              ),
              itemCount: choices.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return tile(choices[index],'normal',index);
              },
            ),

          ],
        ),
      );
    });

  }
}

