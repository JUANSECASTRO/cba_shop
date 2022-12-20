import 'package:flutter/material.dart';
import 'package:proyecto_sena/models/productos_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class Cart extends StatefulWidget {
  final List<ProductosModel> _cart;

  Cart(this._cart);

  @override
  State<Cart> createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);

  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;
  List<ProductosModel> _cart;

  Container pagoTotal(List<ProductosModel> _cart){
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.green[200],
      child: Row(
        children: [
          Text(
            "TOTAL: \$${valorTotal(_cart)}",
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }

  String valorTotal(List<ProductosModel> listaProductos){
    double total =  0.0;
    for ( int i = 0; i < listaProductos.length; i++){
      total = total + listaProductos[i].price * listaProductos[i].quantity;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: null,
            color: Colors.white,
          )
        ],
        title: Text(
          "Detalle",
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details){
          if(_enabled && _firstScroll){
            _scrollController.jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
      onVerticalDragEnd: (_){
          if (_enabled) _firstScroll = false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _cart.length,
              itemBuilder: (context, index){
                final String image = _cart[index].image;
                var item = _cart[index];
                return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: new Image.asset("images/$image",
                                      fit: BoxFit.contain),
                                    )),
                                  Column(
                                    children: [
                                      Text(
                                        item.name,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Colors.black
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.green[600],
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6.0,
                                                  color: Colors.blue,
                                                  offset: Offset(0.0, 1.0),
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              )
                                            ),
                                            margin: EdgeInsets.only(top: 20.0),
                                            padding: EdgeInsets.all(2.0),
                                            child: new Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: (){
                                                    _removeProduct(index);
                                                    valorTotal(_cart);
                                                  },
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                  "${_cart[index].quantity}",
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 22.0,
                                                      color: Colors.white
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: (){
                                                    _addProduct(index);
                                                    valorTotal(_cart);
                                                  },
                                                  color: Colors.yellow,
                                                ),
                                                SizedBox(height: 8.0,)
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 38.0,),
                                  Text(
                                    item.price.toString(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ]
                );
              },
            ),
            SizedBox(width: 10.0,),
            pagoTotal(_cart),
            SizedBox(width: 10.0,),
            Container(
              child: ElevatedButton(
                
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: const Text("ACEPTA PAGAR LA COMPRA"),
                        contentPadding: const EdgeInsets.all(20.0),
                        children: [
                          Text("Esta seguro de comprar estos productos"),
                          TextButton(
                            onPressed: (){
                              msgListaPedido();
                            },
                            child: const Text("Comprar"),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text("Close"),
                          )
                        ],
                      )
                  );
                },
                child: const Text("COMPRAR"),

              ),
            )
          ]
        ),
      ),),
    );
  }
  _addProduct(int index){
    setState(() {
      _cart[index].quantity++;
    });
  }
  _removeProduct(int index){
    setState(() {
      _cart[index].quantity--;
    });
  }
  void msgListaPedido() async {
    String pedido = "";
    String fecha = DateTime.now().toString();
    pedido = pedido + "FECHA:" + fecha.toString();
    pedido = pedido + "\n";
    pedido = pedido + "\n";
    pedido = pedido + "CLIENTE: JUAN CASTRO";
    pedido = pedido + "\n";
    pedido = pedido + "_____________";
    pedido = pedido + "Puedes pasar por tu pedido en tres dias habiles";

    for (int i = 0; i < _cart.length; i++) {
      pedido = '$pedido' +
          "\n"
          "Producto : " +
          _cart[i].name +
          "\n"
          "Cantidad: " +
          _cart[i].quantity.toString() +
          "\n"
          "Precio : " +
          _cart[i].price.toString() +
          "\n"
          "\_________________________\n";
    }
    pedido = pedido + "TOTAL:" + valorTotal(_cart);

    await launch("https://wa.me/${573245504803}?text=$pedido");

  }
}
