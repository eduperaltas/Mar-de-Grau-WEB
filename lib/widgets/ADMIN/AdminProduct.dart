
import 'dart:convert';

import 'package:mardegrau/Model/products.dart';
import 'package:mardegrau/Providers/tables_provider.dart';
import 'package:flutter/material.dart';
import 'package:mardegrau/widgets/ADMIN/ProductDetail_Admin.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
class admin_producto extends StatefulWidget {
  admin_producto({
    Key key,
     this.screenSize,
  }) : super(key: key);
  final Size screenSize;
  @override
  _admin_productoState createState() => _admin_productoState();
}

class _admin_productoState extends State<admin_producto> {

  String action;
  bool tabla;
  void initState() {
    tabla = true;
    action = '';
  }


  ProductModel plato;
  @override
  Widget build(BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
    return Column(
      children: [
        Container(
          width: widget.screenSize.width,
          color: Color.fromRGBO(80, 182, 187, 1.0),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 60,
            ),
            child: Column(
              children: [
                // SizedBox(height: widget.screenSize.height * 0.25,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          'Productos',
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
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(
                    minHeight: 750,
                  ),
                  child: Card(
                    elevation: 1,
                    shadowColor: Colors.black,
                    clipBehavior: Clip.none,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: tabla?ResponsiveDatatable(
                        title: !tablesProvider.isSearch
                            ? RaisedButton.icon(
                            onPressed: () {
                              setState(() {
                                action="nuevo";
                                tabla=false;
                              });

                            },
                            icon: Icon(Icons.add),
                            label: Text("Nuevo Producto"))
                            : null,
                        actions: [
                          if (tablesProvider.isSearch)
                            Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              tablesProvider.isSearch = false;
                                            });
                                          }),
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.search), onPressed: () {})),
                                )),
                          if (!tablesProvider.isSearch)
                            IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  setState(() {
                                    tablesProvider.isSearch = true;
                                  });
                                })
                        ],
                        headers: tablesProvider.productsTableHeader,
                        source: tablesProvider.productsTableSource,
                        selecteds: tablesProvider.selecteds,
                        showSelect: tablesProvider.showSelect,
                        autoHeight: true,
                        onTabRow: (data) {
                          setState(() {
                            action="edita";
                            tabla=false;
                            plato=ProductModel(
                              Pcategoria: data['categoria'].toString(),
                              Pname: data['nombre'].toString(),
                              Pdescription: data['descripcion'].toString(),
                              Pprice: data['precio'],
                              Ppicture: data['foto'].toString(),
                              Pid: data['id'].toString(),
                            );

                          });
                          print(data);
                        },
                        onSort: tablesProvider.onSort,
                        sortAscending: tablesProvider.sortAscending,
                        sortColumn: tablesProvider.sortColumn,
                        isLoading: tablesProvider.isLoading,
                        onSelect: tablesProvider.onSelected,
                        onSelectAll: tablesProvider.onSelectAll,
                        footers: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Filas por página:"),
                          ),
                          if (tablesProvider.perPages != null)
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: DropdownButton(
                                  value: tablesProvider.currentPerPage,
                                  items: tablesProvider.perPages
                                      .map((e) => DropdownMenuItem(
                                    child: Text("$e"),
                                    value: e,
                                  ))
                                      .toList(),
                                  onChanged: (value) {}),
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                                "${tablesProvider.currentPage} - ${tablesProvider.currentPage} of ${tablesProvider.total}"),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                            ),
                            onPressed: tablesProvider.previous,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios, size: 16),
                            onPressed: tablesProvider.next,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh, size: 20),
                            onPressed: tablesProvider.refresh,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          )
                        ],
                      ):
                      ProductsAdmin(screenSize: widget.screenSize,action: action,plato: plato,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



