

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Cart(),
    );
  }
}

class CartItem {
  String name;
  double price;
  int quantity;
  String color;
  String size;

  CartItem({required this.name, required this.price, required this.quantity, required this.color, required this.size});
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<CartItem> cartItems = [
    CartItem(name: 'Pullover', price: 51, quantity: 1,color: 'Black', size: 'L'),
    CartItem(name: 'T-Shirt', price: 30, quantity: 1,color: 'Gray', size: 'L',),
    CartItem(name: 'Sport Dress', price: 43, quantity: 1,color: 'Black', size: 'M',),
  ];

  int getTotalQuantity() {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double getTotalPrice() {
    return cartItems.fold(
        0.0, (sum, item) => sum + (item.price * item.quantity));
  }
  mySnakeBar(contex,msg){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: 40,
              width: 500,
              child: Text('My Bag',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start),
              ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(

                    leading: CircleAvatar(foregroundImage: NetworkImage('https://easyfashion.com.bd/wp-content/uploads/2023/02/DSC00583-copy1-2-scaled-2.jpg'  ),),
                    
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItems[index].name,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                RichText(text: TextSpan(
                                  text: 'Color:',
                                  style: TextStyle(
                                    color: Colors.grey,
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                    text: cartItems[index].color as String,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15, fontWeight: FontWeight.bold),),
                                    TextSpan(
                                      text: '  ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15, fontWeight: FontWeight.bold),),
                                      TextSpan(
                                          text: 'Size:',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15, fontWeight: FontWeight.bold),),
                                        TextSpan(
                                            text: cartItems[index].size as String,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15, fontWeight: FontWeight.bold),),
                                  ]
                                ),

                                ),
                              ],
                            ),
                            const Icon(
                              Icons.more_vert,
                              size: 18.0,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  child: Icon(Icons.remove),
                                  style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide.none)),
                                  onPressed: () {
                                    setState(() {
                                      if (cartItems[index].quantity > 1) {
                                        cartItems[index].quantity--;
                                      }
                                    });
                                  },
                                ),
                                Text(cartItems[index].quantity.toString()),
                                ElevatedButton(
                                  child: Icon(Icons.add),
                                  style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide.none)),
                                  onPressed: () {
                                    setState(() {

                                      cartItems[index].quantity++;
                                      if(cartItems[index].quantity==5) {_showAlertDialog(context);}
                                    });

                                  },
                                ),

                              ],
                            ),
                            Text(cartItems[index].price.toStringAsFixed(0)+'\$')
                          ],
                        ),
                      ],
                    ),


                  ),
                );
              },
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Total Amount: ${getTotalPrice().toStringAsFixed(0)}\$'),
                ElevatedButton(
                  onPressed: () {mySnakeBar(context, 'Congratulation you have checked out');},
                  child: Text(
                    'CHECK OUT',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        title: Text('Congratulation',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        content: Text('You have added \n 5 \n T-shart on your bag',textAlign: TextAlign.center,),
        actions: [
          Center(

            child: TextButton(

              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
              },
              child:
              Text(
                'OKAY',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

