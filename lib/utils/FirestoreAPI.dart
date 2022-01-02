import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mardegrau/Model/Pedido.dart';
import 'package:mardegrau/Model/Product.dart';
import 'dart:io';

import 'package:mardegrau/Model/User.dart';
import 'package:mardegrau/Model/carrousel2.dart';
import 'package:mardegrau/Model/categories.dart';
import 'package:mardegrau/Model/products.dart';
import 'package:mardegrau/utils/authentication.dart' as auth;
import 'package:mardegrau/widgets/CLIENT/list-buttons.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String CATEGOIES = "categories";
  final String PRODUCT = "products";
  final String CARROUSEL = "carrousel";
  final String PEDIDOHIS = "Pedidos";
  String uid;
  String cat;
  String est;
  String pid;
  final FirebaseFirestore  _db = FirebaseFirestore .instance;
  CloudFirestoreAPI({ this.uid,this.pid,this.cat,this.est});

  void createUserData(iUser user) async{
    DocumentReference ref= _db.collection(USERS).doc(user.uid).collection('datos')
        .doc('personal');
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email' : user.email,
      'photoUrl': user.photoURL,
      'lastSingIn': DateTime.now(),
    });
  }
  //CARROUSEL
  void createCarrouselData(String i1,String i2,String i3,String i4,String i5,String i6) async{
    DocumentReference ref= _db.collection(CARROUSEL).doc('Promociones');
    return await ref.update({
      if(i1.toString()!='null') 'img1': i1,
      if(i2.toString()!='null') 'img2': i2,
      if(i3.toString()!='null') 'img3': i3,
      if(i4.toString()!='null') 'img4': i4,
      if(i5.toString()!='null') 'img5': i5,
      if(i6.toString()!='null') 'img6': i6,
    });
  }

  car2 carrouselDataFromSnapshot(DocumentSnapshot snapshot) {
    return car2(
        Cimg1: snapshot['img1'],
        Cimg2: snapshot['img2'],
        Cimg3: snapshot['img3'],
        Cimg4: snapshot['img4'],
        Cimg5: snapshot['img5'],
        Cimg6: snapshot['img6']
    );
  }

  Stream<car2> get carrouselData {
    return _db.collection(CARROUSEL).doc('Promociones').snapshots()
        .map(carrouselDataFromSnapshot);
  }

  void deletecarrouselData(int x) async{
    DocumentReference ref= _db.collection(CARROUSEL).doc('Promociones');
    return ref.update( {'img$x': '',});
  }


  //CATEGORIA
  void createCategory(CategoriesModel category) async{
    DocumentReference ref= _db.collection(CATEGOIES).doc(category.titulo);
    return await ref.set({
      'titulo': category.titulo,
      'img': category.img,
      'id':category.titulo
    });
  }
  void updateCategory(CategoriesModel category) async{
    DocumentReference ref= _db.collection(CATEGOIES).doc(category.uid);
    return await ref.update({
      'titulo': category.titulo,
      'img': category.img,
    });
  }
  void deleteCategory(CategoriesModel category) async{
    DocumentReference ref= _db.collection(CATEGOIES).doc(category.uid);

    return await ref.delete();
  }

  List<CategoriesModel> _cardListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return CategoriesModel(
        Cimg: doc['img'],
        Ctitulo: doc['titulo'],
        uid:  doc['id']
      );
    }).toList();
  }

  Stream<List<CategoriesModel>> get catoriesdata {
    return _db.collection(CATEGOIES).snapshots()
        .map(_cardListFromSnapshot);
  }

  //PRODUCTO
  void createProduct(ProductModel plato) async{
    DateTime date = DateTime.now();
    var idplato= plato.categoria.substring(0,3)+plato.name.substring(0,3)+(date.day+date.month+date.year).toString();
    DocumentReference ref= _db.collection(PRODUCT).doc(idplato);

    for(int i=0;i<plato.opciones.length;i++){
      DocumentReference opt= ref.collection('opciones').doc(plato.opciones[i].title);
      for(int j=0; j<plato.opciones[i].opciones.length;j++){
        if(j==0){
          opt.set({
            '$j':plato.opciones[i].opciones[j],
            'cant':j+1
          });
        }else{
          opt.update({
            '$j':plato.opciones[i].opciones[j],
            'cant':j+1
          });
        }
      }
    }
    // DocumentReference refcat= _db.collection(CATEGOIES).doc(plato.categoria);
    // refcat.collection('platos').doc(idplato).set({
    //   'IDplato': idplato,
    // });
    return await ref.set({
      'categoria': plato.categoria,
      'descripcion': plato.description,
      'foto': plato.picture,
      'nombre': plato.name,
      'precio': plato.price.toStringAsFixed(2),
      'idprod': idplato,
    });
  }

  void updateProduct(ProductModel plato) async{
    DateTime date = DateTime.now();
    var idplato= plato.id;
    DocumentReference ref= _db.collection(PRODUCT).doc(idplato);

    for(int i=0;i<plato.opciones.length;i++){
      DocumentReference opt= ref.collection('opciones').doc(plato.opciones[i].title);
      for(int j=0; j<plato.opciones[i].opciones.length;j++){
        if(j==0){
          opt.set({
            '$j':plato.opciones[i].opciones[j],
            'cant':j+1
          });
        }else{
          opt.update({
            '$j':plato.opciones[i].opciones[j],
            'cant':j+1
          });
        }
      }
    }

    DocumentReference refcat= _db.collection(CATEGOIES).doc(plato.categoria);
    refcat.collection('platos').doc(idplato).update({
      'IDplato': idplato,
    });
    return await ref.update({
      'categoria': plato.categoria,
      'descripcion': plato.description,
      'foto': plato.picture,
      'nombre': plato.name,
      'precio': plato.price.toStringAsFixed(2),
      'idprod': idplato,
    });
  }

  void deleteproduct(String id) async{
    DocumentReference ref= _db.collection(PRODUCT).doc(id);
    return ref.delete();
  }

  void updateopcion(String id, radioButton opciones) async{
    DocumentReference ref= _db.collection(PRODUCT).doc(id);
    DocumentReference opt= ref.collection('opciones').doc(opciones.title);
      for(int j=0; j<opciones.opciones.length;j++){
          opt.update({
            '$j':opciones.opciones[j],
            'cant':j+1
          });
      }
  }

  void deleteopcion(String id,String titulo) async{
    DocumentReference ref= _db.collection(PRODUCT).doc(id);

    DocumentReference opt= ref.collection('opciones').doc(titulo);
    opt.delete();
  }

  List<Product> _platosListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
          return Product(
              Pdescription: doc['descripcion'],
              Pname: doc['nombre'],
              Pphoto: doc['foto'],
              Pprice: double.parse(doc['precio']),
              Pid: doc['idprod'],
              Pcategoria: doc['categoria']
          );
        }).toList();
  }

  Stream<List<Product>> get platosdata {
    return _db.collection(PRODUCT).where('categoria',isEqualTo: cat).snapshots()
        .map(_platosListFromSnapshot);
  }

  List<radioButton> _OpcionesListFromSnapshot(QuerySnapshot snapshot) {
    int i=0;
    return snapshot.docs.map((doc){
      List<String> lstop =[];
      for(int i=0;i<doc['cant'];i++){
        if(doc['$i'].toString()!='') lstop.add(doc['$i']);
      }
      i++;
      return radioButton(
          title: doc.id,
          opciones: lstop,
          numopcion: i,
      );

    }).toList();
  }

  Stream<List<radioButton>> get opcionesdata {
    return _db.collection(PRODUCT).doc(this.pid).collection('opciones').snapshots()
        .map(_OpcionesListFromSnapshot);
  }

  Future<List<radioButton>> getopciones() async {
    var a = await _db.collection(PRODUCT).doc(this.pid).collection('opciones').get();
    return a.docs.map((doc){
      List<String> lstop =[];
      for(int i=0;i<doc['cant'];i++){
        if(doc['$i'].toString()!='') lstop.add(doc['$i']);
      }
      return radioButton(
        title: doc.id,
        opciones: lstop,
      );
    }).toList();
  }
  
  //PEDIDOS
  void createPedidos(Pedido pedido) async{
    DateTime date = DateTime.now();
    String Pnom= 'P'+date.day.toString()+date.month.toString()+date.year.toString().substring(2,4)
        +date.hour.toString()+date.minute.toString()+date.second.toString()+pedido.name.substring(0,1)+pedido.metFact.substring(0,1);
    DocumentReference ref= _db.collection(PEDIDOHIS).doc(Pnom);

    for(int i=0;i<pedido.ordenes.length;i++){
      ref.collection('Ordenes').doc(pedido.ordenes[i].name).set({
        'Cant':pedido.ordenes[i].cantidad,
        'Comentario':pedido.ordenes[i].comentarios,
        'OpCant':0,
        if(pedido.ordenes[i].Pop1!=null) 'Op1':pedido.ordenes[i].Pop1.Oname+': '+pedido.ordenes[i].Pop1.Oselect,
        if(pedido.ordenes[i].Pop2!=null) 'Op2':pedido.ordenes[i].Pop2.Oname+': '+pedido.ordenes[i].Pop2.Oselect,
        if(pedido.ordenes[i].Pop3!=null) 'Op3':pedido.ordenes[i].Pop3.Oname+': '+pedido.ordenes[i].Pop3.Oselect,
        if(pedido.ordenes[i].Pop4!=null) 'Op4':pedido.ordenes[i].Pop4.Oname+': '+pedido.ordenes[i].Pop4.Oselect,
        if(pedido.ordenes[i].Pop5!=null) 'Op5':pedido.ordenes[i].Pop5.Oname+': '+pedido.ordenes[i].Pop5.Oselect,
        if(pedido.ordenes[i].Pop6!=null) 'Op6':pedido.ordenes[i].Pop6.Oname+': '+pedido.ordenes[i].Pop6.Oselect,
        if(pedido.ordenes[i].Pop7!=null) 'Op7':pedido.ordenes[i].Pop7.Oname+': '+pedido.ordenes[i].Pop7.Oselect,
        if(pedido.ordenes[i].Pop8!=null) 'Op8':pedido.ordenes[i].Pop8.Oname+': '+pedido.ordenes[i].Pop8.Oselect,

        if(pedido.ordenes[i].Pop1!=null) 'OpCant':1,
        if(pedido.ordenes[i].Pop2!=null) 'OpCant':2,
        if(pedido.ordenes[i].Pop3!=null) 'OpCant':3,
        if(pedido.ordenes[i].Pop4!=null) 'OpCant':4,
        if(pedido.ordenes[i].Pop5!=null) 'OpCant':5,
        if(pedido.ordenes[i].Pop6!=null) 'OpCant':6,
        if(pedido.ordenes[i].Pop7!=null) 'OpCant':7,
        if(pedido.ordenes[i].Pop8!=null) 'OpCant':8,
      });
    }

    return await ref.set({
      'Pfecha':date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString() +' '+ date.hour.toString()+':'+date.minute.toString(),
      'Cnombre': pedido.name,
      'CApellido': pedido.apellidos,
      'Cdni': pedido.dni,
      'Ctelefono': pedido.telefono,
      'Cemail': pedido.email,
      'Pdireccion': pedido.direccion,
      'Pdetelle_direccion': pedido.detdir,
      'Ppago': pedido.metPago,
      if(pedido.metPago=='Efectivo') 'Pefectivo': pedido.efectivo,
      'PmetFact': pedido.metFact,
      if(pedido.metFact=='Factura') 'PfactrazSoc': pedido.razSoc,
      if(pedido.metFact=='Factura') 'Pfactruc': pedido.ruc,
      'Total': pedido.Total,
      'Pestado': 'Pendiente',
      'Cuser':uid
    });

  }

  List<Pedido> _pedidosListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Pedido(
        name: doc['Cnombre'],
        apellidos: doc['CApellido'],
        dni: doc['Cdni'],
        telefono: doc['Ctelefono'],
        email: doc['Cemail'],
        direccion: doc['Pdireccion'],
        detdir: doc['Pdetelle_direccion'],
        metPago: doc['Ppago'], 
        efectivo: doc['Ppago']=='Efectivo' ? doc['Pefectivo']:null,
        metFact: doc['PmetFact'],
        razSoc: doc['PmetFact']=='Factura' ? doc['PfactrazSoc']:null,
        ruc: doc['PmetFact']=='Factura' ? doc['Pfactruc']:null,
        Total: doc['Total'],
        id: doc.id,
        fecha: doc['Pfecha'],
        estado: doc['Pestado']
      );
    }).toList();
  }

  Stream<List<Pedido>> get pedidosdata {
    return _db.collection(PEDIDOHIS).where('Pestado',isEqualTo: est).snapshots()
        .map(_pedidosListFromSnapshot);
  }

  Stream<List<Pedido>> get Hispedidosdata {
    return _db.collection(PEDIDOHIS).where('Cuser',isEqualTo: auth.uid).snapshots()
        .map(_pedidosListFromSnapshot);
  }

  List<Product> _pedidosopcionesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Product(
          Pname: doc.id,
          cantidad: doc['Cant'],
          comentarios: doc['Comentario'],
          get_op1: doc['OpCant']>=1 ? doc['Op1'] :null,
          get_op2: doc['OpCant']>=2 ? doc['Op2'] :null,
          get_op3: doc['OpCant']>=3 ? doc['Op3'] :null,
          get_op4: doc['OpCant']>=4 ? doc['Op4'] :null,
          get_op5: doc['OpCant']>=5 ? doc['Op5'] :null,
          get_op6: doc['OpCant']>=6 ? doc['Op6'] :null,
          get_op7: doc['OpCant']>=7 ? doc['Op7'] :null,
          get_op8: doc['OpCant']>=8 ? doc['Op8'] :null,
      );
    }).toList();
  }

  Stream<List<Product>> get pedidosopcionesdata {
    return _db.collection(PEDIDOHIS).doc(pid).collection('Ordenes').snapshots()
        .map(_pedidosopcionesListFromSnapshot);
  }

  void CambioEstadoPedido(String state) async {
    DocumentReference ref = _db.collection(PEDIDOHIS).doc(pid);
    return await ref.update({
      'Pestado': state
    });
  }
  
}