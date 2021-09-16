
import 'package:mardegrau/Model/Product.dart';

class Pedido{

  List<Product> ordenes;
  String ruc;
  String razSoc;
  String direccion;
  String detdir;
  String name;
  String apellidos;
  String dni;
  String telefono;
  String email;
  String metPago;
  String efectivo;
  String metFact;
  String Total;
  String id;
  String fecha;
  String estado;
  Pedido({this.ordenes,this.direccion,this.email,this.name,this.razSoc,
    this.apellidos,this.detdir,this.dni,this.ruc,this.telefono,this.metPago,
    this.efectivo,this.metFact,this.Total,this.id,this.fecha,this.estado});
  
}