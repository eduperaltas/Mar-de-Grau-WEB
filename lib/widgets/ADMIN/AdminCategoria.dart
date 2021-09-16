import 'dart:html';
import 'dart:async';

// import 'package:image_picker_web/image_picker_web.dart';
import 'package:mardegrau/Model/categories.dart';
import 'package:mardegrau/Providers/tables_provider.dart';
// import 'package:firebase/firebase.dart' as fb;
import 'package:mardegrau/screens/Admin.dart';
import 'package:mardegrau/utils/FirestoreAPI.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class admin_categorias extends StatefulWidget {
  admin_categorias({
    Key key,
     this.screenSize,
  }) : super(key: key);
  final Size screenSize;
  @override
  _admin_categoriasState createState() => _admin_categoriasState();
}
class _admin_categoriasState extends State<admin_categorias> {
  String _titulo,_img;

  Widget NewCategoryDialog(){
    return Dialog(
      backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: Container(
        width: 400,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/promo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          'Nueva Categoria',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(223, 222, 211, 1.0),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 15),
                    Container(
                      alignment: Alignment.center,
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      height: 7,
                      width: 210,
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Center(
                      child: TextFormField(
                          cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            labelText: 'Título',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                            ),
                            //hintText: 'Enter a Phone Number',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(221, 220, 210, 1.0),
                                )
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide()
                            ),
                          ),
                          validator: (input)=> input.length==0 ? 'Introduce Titulo' : null,
                          onChanged: (input) {
                            setState(() => _titulo = input);
                          }
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Center(
                      child: TextFormField(
                          cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            labelText: 'URL de Imagen',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(221, 220, 210, 1.0),
                            ),
                            //hintText: 'Enter a Phone Number',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(221, 220, 210, 1.0),
                                )
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide()
                            ),
                          ),
                          validator: (input)=> input.length==0 ? 'Ingresa el URL de la imagen' : null,
                          onChanged: (input) {
                            setState(() => _img = input);
                          }
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: catimg(_img),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        child: RaisedButton(
                          color:  Color.fromRGBO(80, 182, 187, 0.6),
                          onPressed: (){
                            // uploadImageFile(tempImage,'add','','','');
                            CategoriesModel newcategory= new CategoriesModel(Ctitulo: _titulo,Cimg: _img);
                            CloudFirestoreAPI().createCategory(newcategory);
                            _img=null;
                            Navigator.of(context).pop(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => adminHome(),
                              ),
                            );
                            // tempImage=null;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Crear Categoria',style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(221, 220, 210, 1.0)
                              // color: Color.fromRGBO(
                              //     221, 220, 210, 1.0)
                            ),),
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget catimg(String url){
      return  Center(
        child: Container(
          height: 200,
          width: 350,
          child: new Container(
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromRGBO(43, 43, 44, 1.0),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  image:_img!=null?new NetworkImage(_img) :new AssetImage('assets/images/promo.png'),
                )
            ),
            alignment: Alignment.center,
            child: Stack(
              children: [
                  Center(child: Icon(url!=null?Icons.edit:Icons.add, color: Colors.black54,),)
              ],
            ),
          ),
        ),
      );
  }

  // imagePicker() async {
  //   tempImage = await ImagePickerWeb.getImage(outputType: ImageType.file);
  // }
  //
  // Future<Uri> uploadImageFile(File image, String action,String tit,String img,String uid) async {
  //   fb.StorageReference storageRef = fb.storage().ref('categorias/$_titulo');
  //   fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(image).future;
  //
  //   Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
  //   if(action=='add'){
  //     CategoriesModel newcategory= new CategoriesModel(Ctitulo: _titulo,Cimg: imageUri.toString());
  //     CloudFirestoreAPI().createCategory(newcategory);
  //   }
  //   if(action=='edit'){
  //     CategoriesModel category=
  //     new CategoriesModel(
  //         Ctitulo: _titulo!=null?_titulo:tit,
  //         Cimg: _img!=null?_img:img,
  //         uid: uid);
  //     CloudFirestoreAPI().updateCategory(category);
  //   }
  //
  //   return imageUri;
  // }

  Widget UpdateCategoryDialog(String tit, String img,String uid){
    return Dialog(
      backgroundColor: Color.fromRGBO(80, 182, 187, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(38.0),
      ),
      child: Container(
        width: 400,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/promo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          'Editar Categoria',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(223, 222, 211, 1.0),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 15),
                    Container(
                      alignment: Alignment.center,
                      color: Color.fromRGBO(223, 222, 211, 1.0),
                      height: 7,
                      width: 210,
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Center(
                      child: TextFormField(
                          cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            labelText: tit,
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(221, 220, 210, 1.0),
                            ),
                            //hintText: 'Enter a Phone Number',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(221, 220, 210, 1.0),
                                )
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide()
                            ),
                          ),
                          validator: (input)=> input.length==0 ? 'Introduce Titulo' : null,
                          onChanged: (input) {
                            setState(() => _titulo = input);
                          }
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Center(
                      child: TextFormField(
                          cursorColor: Color.fromRGBO(221, 220, 210, 1.0),
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            labelText: img,
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(221, 220, 210, 1.0),
                            ),
                            //hintText: 'Enter a Phone Number',
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(221, 220, 210, 1.0),
                                )
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide()
                            ),
                          ),
                          validator: (input)=> input.length==0 ? 'Ingresa el URL de la imagen' : null,
                          onChanged: (input) {
                            setState(() => _img = input);
                          }
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: catimg(img),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            RaisedButton(
                              color:  Color.fromRGBO(80, 182, 187, 0.6),
                              onPressed: (){
                                // uploadImageFile(tempImage,'edit',tit,img,uid);
                                CategoriesModel category=
                                new CategoriesModel(
                                    Ctitulo: _titulo!=null?_titulo:tit,
                                    Cimg: _img!=null?_img:img,
                                    uid: uid);
                                CloudFirestoreAPI().updateCategory(category);
                                Navigator.of(context).pop(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => adminHome(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Guardar',style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                  // color: Color.fromRGBO(
                                  //     221, 220, 210, 1.0)
                                ),),
                              ),
                            ),
                            RaisedButton(
                              color:  Color.fromRGBO(80, 182, 187, 0.6),
                              onPressed: (){
                                CategoriesModel category=
                                new CategoriesModel(Ctitulo: _titulo,Cimg: _img,uid: uid);
                                 CloudFirestoreAPI().deleteCategory(category);
                                Navigator.of(context).pop(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => adminHome(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Eliminar',style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 220, 210, 1.0)
                                  // color: Color.fromRGBO(
                                  //     221, 220, 210, 1.0)
                                ),),
                              ),
                            ),
                          ]

                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                SizedBox(height: widget.screenSize.height * 0.05,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          'Categorias',
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
                      child: ResponsiveDatatable(
                        title: RaisedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => NewCategoryDialog(),
                              );
                            },
                            icon: Icon(Icons.add),
                            label: Text("Nueva Categoria")),
                        headers: tablesProvider.categoriesTableHeader,
                        source: tablesProvider.categoriesTableSource,
                        selecteds: tablesProvider.selecteds,
                        showSelect: tablesProvider.showSelect,
                        autoHeight: true,
                        onTabRow: (data) {
                          showDialog(
                            context: context,
                            builder: (context) => UpdateCategoryDialog(data['titulo'],data['img'],data['uid'])
                          );
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
                                  onChanged: (value) {
                                  setState(() {
                                    tablesProvider.currentPerPage=value;
                                  });
                                  }),
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
                      ),
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



