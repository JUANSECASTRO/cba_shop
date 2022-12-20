import 'package:flutter/material.dart';
import 'package:proyecto_sena/pages/Categorias.dart';
import 'package:proyecto_sena/pages/pedido_lista.dart';
import 'models/productos_modal.dart';
import 'pages/otra_pagina.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'CBA APP STORE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = <ProductosModel>[];

  List<ProductosModel> _listaCarro = <ProductosModel>[];

  @override
  void initState() {
    super.initState();

    _categorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(padding:
          const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Icon(Icons.person, size: 40),
                ],
              ),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute
                    (builder: (BuildContext context) => const LoginPage(),
                  ),
                  );
                }
            ),
          ),
          Padding(padding:
          const EdgeInsets.only(right: 36.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Icon(Icons.shopping_cart_sharp, size: 38,),
                  if(_listaCarro.length > 0)
                    Padding(padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _listaCarro.length.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (_listaCarro.isNotEmpty)
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Cart(_listaCarro),
                  ),
                  );
              },
            ),
          )
        ],
      ),


      drawer: Container(
        width: 200.0,
        child: Drawer(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            color: Colors.white,
            child: new ListView(
              padding: EdgeInsets.only(top: 50.0),
              children: [
                Container(
                  height: 120,
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text(""),
                    accountEmail: new Text(""),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage("images/api.png"),
                            fit: BoxFit.fill)
                    ),
                  ),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    "Home", style: TextStyle(color: Colors.black),),
                  trailing: new Icon(
                    Icons.home, size: 30.0, color: Colors.black,),
                  onTap: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => MyApp()
                      )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    "Perfil", style: TextStyle(color: Colors.black),),
                  trailing: new Icon(
                    Icons.person, size: 30.0, color: Colors.black,),
                  onTap: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()
                      )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    "Categorias", style: TextStyle(color: Colors.black),),
                  trailing: new Icon(
                    Icons.calendar_view_day_sharp, size: 30.0, color: Colors.black,),
                  onTap: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Categorias(title: 'categorias',)
                      )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    "Mis Productos", style: TextStyle(color: Colors.black),),
                  trailing: new Icon(Icons.shopping_basket_sharp, size: 30.0,
                    color: Colors.black,),
                  onTap: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Cart(_listaCarro)
                      )),
                ),
                new Divider(),
              ],
            ),
          ),
        ),
      ),
      body: _cuadroProductos(),
    );
  }


  GridView _cuadroProductos() {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemCount: _productosModel.length,
      itemBuilder: (context, index) {
        final String image = _productosModel[index].image;
        var item = _productosModel[index];
        return Card(
            elevation: 4.0,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: new Image.asset("images/$image",
                        fit: BoxFit.contain),),
                    Text(item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(item.cantidad.toString(), style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0,
                            color: Colors.black
                        ),),
                        Text(item.price.toString(), style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0,
                            color: Colors.black
                        ),),
                        Padding(padding: const EdgeInsets.only(
                          right: 8.0,
                          bottom: 8.0,
                        ),
                          child: Align(alignment: Alignment.bottomLeft,
                            child: GestureDetector(
                              child: (!_listaCarro.contains(item))
                                  ? Icon(
                                Icons.shopping_cart_sharp,
                                color: Colors.green,
                                size: 38,
                              ) :
                              Icon(
                                Icons.shopping_cart_sharp,
                                color: Colors.red,
                                size: 38,
                              ),
                              onTap: () {
                                setState(() {
                                  if (!_listaCarro.contains(item))
                                    _listaCarro.add(item);
                                  else
                                    _listaCarro.remove(item);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            )
        );
      },
    );
  }

  void _categorias() {
    var list = <ProductosModel>[
      ProductosModel(
        name: "Aguacate",
        image: "food1.jpg",
        cantidad: "libra:",
        price: 7000,
        color: Colors.black,
      ),
      ProductosModel(
        name: "Astromelias Rosadas",
        image: "food2.jpg",
        cantidad: "Ramo:",
        price: 2000,
        color: Colors.black,
      ),
      ProductosModel(
        name: "Granadilla",
        image: "food3.jpg",
        cantidad: "libra:",
        price: 7000,
        color: Colors.black,
      ),
      ProductosModel(
        name: "Huevos A",
        image: "food4.jpg",
        cantidad: "Cubeta:",
        price: 11000,
        color: Colors.black,
      ),
      ProductosModel(
        name: "Huevos AA",
        image: "food5.jpg",
        cantidad: "Cubeta:",
        price: 13000,
        color: Colors.black,
      ),
      ProductosModel(
        name: "Huevos AAA",
        image: "food6.jpg",
        cantidad: "Cubeta:",
        price: 15000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Huevos jumbo",
        image: "food7.jpg",
        cantidad: "Cubeta:",
        price: 18000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Leche",
        image: "food8.jpg",
        cantidad: "Litro:",
        price: 6000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Lechuga crespa",
        image: "food9.jpg",
        cantidad: "libra:",
        price: 4000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Lechuga",
        image: "food10.jpg",
        cantidad: "Libra:",
        price: 4000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Miel",
        image: "food11.jpg",
        cantidad: "Tarro:",
        price: 12000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Mora",
        image: "food12.jpg",
        cantidad: "Libra:",
        price: 1500,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Papa",
        image: "food13.jpg",
        cantidad: "Bulto:",
        price: 70000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Pimenton",
        image: "food14.jpg",
        cantidad: "Libra:",
        price: 3000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Polen",
        image: "food15.jpg",
        cantidad: "Tarro:",
        price: 18000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Queso",
        image: "food16.jpg",
        cantidad: "Libra:",
        price: 10000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Rosas",
        image: "food17.jpg",
        cantidad: "Ramo:",
        price: 3000,
        color: Colors.white,
      ),
      ProductosModel(
        name: "Yogurt",
        image: "food18.jpg",
        cantidad: "Litro:",
        price: 5000,
        color: Colors.white,
      ),
    ];

    setState(() {
      _productosModel = list;
    });
  }
}

