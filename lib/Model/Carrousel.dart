import 'package:equatable/equatable.dart';

class Carrousel extends Equatable {

   // final String img;
   // final String img2;
   // final String img3;
   // final String img4;
   // final String img5;
   // final String img6;
    final List<String> imgs;
  // const Carrousel(this.img,this.img2,this.img3,this.img4,this.img5,this.img6);
  const Carrousel(this.imgs);

  factory Carrousel.fromSnapshot(Map data) {

    List<String> BDimgs = <String>[];
    int cont=0;

    data.forEach((key, value) {
      if(data["img$cont"]!=null && data["img$cont"]!='')BDimgs.add(data["img$cont"]);
      cont++;

    });

    // BDimgs.add(data["img1"]);
    // BDimgs.add(data["img2"]);
    // return Carrousel(data["img1"],data["img2"],data["img3"],data["img4"],data["img5"],data["img6"]);
    return Carrousel(BDimgs);
  }

  @override
  List<Object> get props => [imgs];
}