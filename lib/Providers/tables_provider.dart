// @dart=2.9
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mardegrau/Model/categories.dart';
import 'package:mardegrau/Model/products.dart';
import 'package:mardegrau/services/categories_services.dart';
import 'package:mardegrau/services/products_services.dart';
import 'package:responsive_table/DatatableHeader.dart';

class TablesProvider with ChangeNotifier {
  // ANCHOR table headers
  //List<DatatableHeader> usersTableHeader = [
  //  DatatableHeader(
  //      text: "ID",
  //      value: "id",
  //      show: true,
  //      sortable: true,
  //      textAlign: TextAlign.left),
  //  DatatableHeader(
  //      text: "Name",
  //      value: "name",
  //      show: true,
  //      flex: 2,
  //      sortable: true,
  //      textAlign: TextAlign.left),
  //  DatatableHeader(
  //      text: "Email",
  //      value: "email",
  //      show: true,
  //      sortable: true,
  //      textAlign: TextAlign.left),
  //];
//
  /*List<DatatableHeader> ordersTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "User Id",
        value: "userId",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Description",
        value: "description",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Created At",
        value: "createdAt",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Total",
        value: "total",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];*/

  List<DatatableHeader> productsTableHeader = [
    DatatableHeader(
        text: "Categoria",
        value: "categoria",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Nombre",
        value: "nombre",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Descripcion",
        value: "descripcion",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Precio",
        value: "precio",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Foto",
        value: "foto",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  //List<DatatableHeader> brandsTableHeader = [
  //  DatatableHeader(
  //      text: "ID",
  //      value: "id",
  //      show: true,
  //      sortable: true,
  //      textAlign: TextAlign.left),
  //  DatatableHeader(
  //      text: "Brand",
  //      value: "brand",
  //      show: true,
  //      flex: 2,
  //      sortable: true,
  //      textAlign: TextAlign.left),
  //];

  List<DatatableHeader> categoriesTableHeader = [
    DatatableHeader(
        text: "Titulo",
        value: "titulo",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Img",
        value: "img",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<int> perPages = [5, 10, 15, 100];
  int total = 100;
  int currentPerPage;
  int currentPage = 1;
  bool isSearch = false;
  /*List<Map<String, dynamic>> usersTableSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> ordersTableSource = List<Map<String, dynamic>>();*/
  List<Map<String, dynamic>> productsTableSource = List<Map<String, dynamic>>();
  // ignore: deprecated_member_use
  List<Map<String, dynamic>> categoriesTableSource = List<Map<String, dynamic>>();
  /*List<Map<String, dynamic>> brandsTableSource = List<Map<String, dynamic>>();*/

  // ignore: deprecated_member_use
  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = false;

  /*UserServices _userServices = UserServices();
  List<UserModel> _users = <UserModel>[];
  List<UserModel> get users => _users;

  OrderServices _orderServices = OrderServices();
  List<OrderModel> _orders = <OrderModel>[];
  List<OrderModel> get orders => _orders;
*/
  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> _products = <ProductModel>[];
  List<ProductModel> get products => _products;

  CategoriesServices _categoriesServices = CategoriesServices();
  List<CategoriesModel> _categories = <CategoriesModel>[];

  /*BrandsServices _brandsServices = BrandsServices();
  List<BrandModel> _brands = <BrandModel>[];*/

  Future _loadFromFirebase() async {
    /*_users = await _userServices.getAllUsers();
    _orders = await _orderServices.getAllOrders();

    _brands = await _brandsServices.getAll();*/
    _products = await _productsServices.getAllProducts();
    _categories = await _categoriesServices.getAll();
  }

/*  List<Map<String, dynamic>> _getUsersData() {
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    var i = _users.length;
    print(i);
    for (UserModel userData in _users) {
      temps.add({
        "id": userData.id,
        "email": userData.email,
        "name": userData.name,
      });
      i++;
    }
    isLoading = false;
    notifyListeners();
    return temps;
  }

  List<Map<String, dynamic>> _getBrandsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (BrandModel brand in _brands) {
      temps.add({
        "id": brand.id,
        "brand": brand.brand,
      });
    }
    return temps;
  }*/

  List<Map<String, dynamic>> _getCategoriesData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (CategoriesModel category in _categories) {
      temps.add({
        "titulo": category.titulo,
        "img": category.img,
        "uid": category.uid,
      });
    }
    return temps;
  }

  /*List<Map<String, dynamic>> _getOrdersData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (OrderModel order in _orders) {
      temps.add({
        "id": order.id,
        "userId": order.userId,
        "description": order.description,
        "createdAt": DateFormat.yMMMd()
            .format(DateTime.fromMillisecondsSinceEpoch(order.createdAt)),
        "total": "\$${order.total}",
      });
    }
    return temps;
  }*/

  List<Map<String, dynamic>> _getProductsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (ProductModel product in _products) {
      temps.add({
        "categoria": product.categoria,
        "nombre": product.name,
        "descripcion": product.description,
        "precio": product.price,
        "foto": product.picture,
        "id":product.id
      });
    }
    return temps;
  }

  _initData() async {
    isLoading = true;
    notifyListeners();
    await _loadFromFirebase();
   /* usersTableSource.addAll(_getUsersData());
    ordersTableSource.addAll(_getOrdersData());*/
    productsTableSource.addAll(_getProductsData());
    categoriesTableSource.addAll(_getCategoriesData());
   /* brandsTableSource.addAll(_getBrandsData());*/

    isLoading = false;
    notifyListeners();
  }

  onSort(dynamic value) {
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      productsTableSource
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      productsTableSource
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    notifyListeners();
  }

  onSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      selecteds.add(item);
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      //selecteds = usersTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int value) {
    currentPerPage = value;
    notifyListeners();
  }

  previous() {
    currentPage = currentPage >= 2 ? currentPage - 1 : 1;
    notifyListeners();
  }

  next() {
    currentPage++;
    notifyListeners();
  }

  refresh(){
    productsTableSource.clear();
    categoriesTableSource.clear();
    _initData();
    notifyListeners();
  }

  TablesProvider.init() {
    _initData();
  }
}
