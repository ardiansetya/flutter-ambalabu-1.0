import 'package:flutter/material.dart';
import 'product.dart';
import 'product_description.dart';
import 'cart.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Map<String, dynamic>> cartItems = [];
  final List<Product> products = [
    Product(
      name: 'Es Teh Ajib',
      description:
          '"Es Teh Ajib" adalah minuman es teh segar yang terkenal di Indonesia.',
      price: 5000,
      imageUrl: 'assets/images/esteh.jpg',
    ),
    Product(
      name: 'Lumpia',
      description:
          '"Lumpia" adalah makanan ringan berisi sayuran atau daging yang dibungkus kulit tipis.',
      price: 8000,
      imageUrl: 'assets/images/lumpia.jpeg',
    ),
    Product(
      name: 'Cilok',
      description:
          '"Cilok" adalah jajanan berbentuk bulat yang terbuat dari tepung tapioka.',
      price: 3000,
      imageUrl: 'assets/images/cilok.webp',
    ),
    Product(
      name: 'Batagor',
      description: '"Batagor" adalah bakso tahu goreng khas Bandung.',
      price: 10000,
      imageUrl: 'assets/images/batagor.jpg',
    ),
    Product(
      name: 'Risoles',
      description:
          '"Risoles" adalah makanan ringan isi sayur atau daging dengan lapisan tepung roti.',
      price: 7000,
      imageUrl: 'assets/images/risole.jpg',
    ),
  ];

  // Menginisialisasi quantities dengan jumlah produk yang ada
  List<int> quantities = List.filled(8, 0);

  @override
  void initState() {
    super.initState();
    quantities = List.filled(products.length, 0); // Inisialisasi quantities
  }

  void addToCart(Product product, int quantity) {
    for (var item in cartItems) {
      if (item['product'] == product) {
        item['quantity'] += quantity;
        return;
      }
    }
    cartItems.add({'product': product, 'quantity': quantity});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                product.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Rp ${product.price}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantities[index] > 0) quantities[index]--;
                          });
                        },
                      ),
                      Text(quantities[index].toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantities[index]++;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (quantities[index] > 0) {
                        addToCart(product, quantities[index]);
                        setState(() {
                          quantities[index] = 0;
                        });
                        // Menggunakan TopSnackBar custom
                        TopSnackBar.show(context, 'Added to cart');
                      }
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
              leading: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDescription(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(cartItems: cartItems),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                'Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget dan fungsi untuk TopSnackBar custom
class TopSnackBar {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 70,
        left: 0,
        right: 0,
        child: TopSnackBarWidget(message: message),
      ),
    );

    // Menambahkan Overlay Entry ke layar
    overlay.insert(overlayEntry);

    // Menghapus Overlay setelah 1 detik
    Future.delayed(Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }
}

class TopSnackBarWidget extends StatefulWidget {
  final String message;

  TopSnackBarWidget({required this.message});

  @override
  _TopSnackBarWidgetState createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
