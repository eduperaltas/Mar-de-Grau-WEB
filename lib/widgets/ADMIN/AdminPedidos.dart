// @dart=2.9
import 'package:line_icons/line_icons.dart';
import 'package:mardegrau/Model/Pedido.dart';
import 'package:mardegrau/Model/Product.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class admin_Pedidos extends StatefulWidget {
  admin_Pedidos({
    Key key,
     this.screenSize,
  }) : super(key: key);
  final Size screenSize;
  @override
  _admin_PedidosState createState() => _admin_PedidosState();
}
class _admin_PedidosState extends State<admin_Pedidos> {

  Widget miCardComanda(Pedido p, String est) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Column(
          children: <Widget>[
            Center(
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: Text(p.metPago),
                subtitle:  StreamBuilder(
                  stream: CloudFirestoreAPI(pid: p.id).pedidosopcionesdata,
                  builder: (context, snapshot){
                    List<Product> lstplatos = snapshot.data;
                    print('plato id: '+lstplatos[0].name);
                    if(!snapshot.hasData){
                      return Container();
                    }
                    if(snapshot.hasData) {
                      return Container(
                        child: Column(
                          children: [
                            Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('ID: '+p.id),
                            )),
                            Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Fecha: '+p.fecha),
                            )),
                            Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Cliente: '+p.name+' '+p.apellidos),
                            )),
                            Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Telefono: '+p.telefono),
                            )),
                            if(est=='Enviado')Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Dirección: '+p.direccion),
                            )),
                            if(est=='Enviado')Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Detalle dir: '+p.detdir),
                            )),
                            if(est=='Preparando'||est=='Enviado')Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Comprobante: '+p.metFact),
                            )),
                            if(est=='Preparando'||est=='Enviado')if (p.metFact=='Factura') Align(alignment: Alignment.centerLeft,child: Text('   RUC: '+p.ruc)),
                            if(est=='Preparando'||est=='Enviado')if (p.metFact=='Factura') Align(alignment: Alignment.centerLeft,child: Text('   Razón Social: '+p.razSoc)),
                            Align(alignment: Alignment.centerLeft,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Platos:'),
                            )),
                            for (var element in lstplatos)
                             platos(element),

                            Align(alignment: Alignment.centerRight,child: Padding(
                              padding: EdgeInsets.only(top: 5),child: Text('Total:  '+p.Total),
                            )),

                            if(est=='Preparando'||est=='Enviado')if(p.metPago=='Efectivo')Align(alignment: Alignment.centerRight,child: Text('Cancela:  '+'S/. '+ double.parse(p.efectivo).toStringAsFixed(2))),

                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                leading: Icon(p.metPago =='Recojo en Tienda'?Icons.home:Icons.delivery_dining),
              ),
            ),

            // Usamos una fila para ordenar los botones del card
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if(est=='Pendiente')FlatButton(onPressed: () => {CloudFirestoreAPI(pid: p.id).CambioEstadoPedido('Preparando')}, child: Text('Aceptar',style: TextStyle(fontWeight: FontWeight.bold))),
                if(est=='Pendiente') FlatButton(onPressed: () => {CloudFirestoreAPI(pid: p.id).CambioEstadoPedido('Cancelado')}, child: Text('Cancelar',style: TextStyle(fontWeight: FontWeight.bold))),
                if(est=='Preparando')FlatButton(onPressed: () => {CloudFirestoreAPI(pid: p.id).CambioEstadoPedido('Enviado')}, child: Text('Enviar',style: TextStyle(fontWeight: FontWeight.bold))),
                if(est=='Enviado')FlatButton(onPressed: () => {CloudFirestoreAPI(pid: p.id).CambioEstadoPedido('Finalizado')}, child: Text('Finalizar',style: TextStyle(fontWeight: FontWeight.bold),)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget platos(Product lstplatos){
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft,child: Text('  '+lstplatos.cantidad.toString() +'X '+lstplatos.name)),
        if (lstplatos.get_op1!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op1),)),
        if (lstplatos.get_op2!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op2),)),
        if (lstplatos.get_op3!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op3),)),
        if (lstplatos.get_op4!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op4),)),
        if (lstplatos.get_op5!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op5),)),
        if (lstplatos.get_op6!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op6),)),
        if (lstplatos.get_op7!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op7),)),
        if (lstplatos.get_op8!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text(lstplatos.get_op8),)),
        if (lstplatos.comentarios!=null)
          Align(alignment: Alignment.centerLeft,child: Padding(padding: const EdgeInsets.only(left: 26.0),child: Text('Coment: '+lstplatos.comentarios),)),
      ],
    );
  }

  Widget Comanda(String estado){
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
        child: StreamBuilder(
        stream: CloudFirestoreAPI(est: estado).pedidosdata,
          builder:(context, snapshot){
            if(!snapshot.hasData){
              return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                    child: Container(child: Column(
                      children: [
                        CircularProgressIndicator(color: Colors.grey,),
                      ],
                    )),
                    ),
              );
            }
            List<Pedido> lstpedidos=snapshot.data;
            return CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      for(int i=0;i<lstpedidos.length;i++)
                        miCardComanda(lstpedidos[i],estado),
                    ],
                  ),
                ),
              ],
            );
        }
        ),
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
          constraints: BoxConstraints(
            minHeight: 850,
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
                        'Pedidos',
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

              Padding(
                padding: const EdgeInsets.all( 15.0),
                child: Container(
                  // width: 400,
                  height: 650,
                  constraints: BoxConstraints(
                    minHeight: 650,
                  ),
                  child: ContainedTabBarView(
                    tabs: [
                      Row(children: [Text('Pendientes '),Icon(Icons.access_time),],),
                      Row(children: [Text('Preparando '),Icon(Icons.kitchen),],),
                      Row(children: [Text('Enviado '),Icon(Icons.delivery_dining),],),
                    ],
                    tabBarProperties: TabBarProperties(
                      height: 32.0,alignment: TabBarAlignment.start,
                      indicatorColor: Color.fromRGBO(223, 222, 211, 1.0),
                      width: 400,
                      indicatorWeight: 3.0,
                      labelColor: Color.fromRGBO(223, 222, 211, 1.0),
                      unselectedLabelColor: Colors.grey[400],
                    ),
                    views: [
                      Comanda('Pendiente'),
                      Comanda('Preparando'),
                      Comanda('Enviado')
                    ],
                  ),
                ),
              )
              // Comanda(),
            ],
          ),
        ),
      ],
    );
  }
}



