import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mardegrau/Model/carrousel2.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';

car2 carrousel;
class PromoCarousel extends StatefulWidget {
  @override
  _PromoCarouselState createState() => _PromoCarouselState();
  car2 getcarrousel(){return carrousel;}
}

class _PromoCarouselState extends State<PromoCarousel> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CloudFirestoreAPI().carrouselData,
        builder: (context, snapshot){
          carrousel=snapshot.data;

          if(!snapshot.hasData){
            return Center(
                child: Container(child: CircularProgressIndicator(color: Colors.white,)),
              );}
          else{
            List<Widget> cimgs =[];
            carrousel.img1!=""?cimgs.add(Image.network(carrousel.img1)):null;
            carrousel.img2!=""?cimgs.add(Image.network(carrousel.img2)):null;
            carrousel.img3!=""?cimgs.add(Image.network(carrousel.img3)):null;
            carrousel.img4!=""?cimgs.add(Image.network(carrousel.img4)):null;
            carrousel.img5!=""?cimgs.add(Image.network(carrousel.img5)):null;
            carrousel.img6!=""?cimgs.add(Image.network(carrousel.img6)):null;
            return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                initialPage: 1,
                autoPlay: true,
              ),
              items: cimgs,
            );}

        });

  }

}