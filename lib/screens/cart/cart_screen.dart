import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';
import 'package:interiorx/screens/checkout/checkout_screen.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/theme.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kSecondaryColor,
        leading: buildBackIconButton(context),
        // title: const Text('Your Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(10),
        //   child: Text('${cartProvider.cartItems.length}  items'),
        // ),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_rounded,
                    color: kPrimaryColor,
                    size: 80,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to the shop page
                      },
                      child: const Text('Shop', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12.0),
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return Dismissible(
                    key: ValueKey(item.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      cartProvider.removeProduct(item.id);
                    },
                    background: Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(top: 28, right: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 203, 88, 88),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(1, 1))
                        ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: 75,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                height: 75,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.category,
                                          style:
                                              const TextStyle(fontSize: 12),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color:
                                            Color.fromARGB(255, 203, 88, 88)),
                                    onPressed: () {
                                      cartProvider.removeProduct(item.id);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: InkWell(
                                          onTap: () {
                                            if (item.quantity > 1) {
                                              cartProvider.updateQuantity(
                                                  item.id, item.quantity - 1);
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: const Icon(Icons.remove,
                                              color: Colors.white, size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Text('${item.quantity}'),
                                      const SizedBox(width: 14),
                                      Container(
                                        height: 28,
                                        width: 28,
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: InkWell(
                                          onTap: () {
                                            cartProvider.updateQuantity(
                                                item.id, item.quantity + 1);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: const Icon(Icons.add,
                                              color: Colors.white, size: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 65),
                                  const Text(
                                    '\$ ',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    (item.price * item.quantity)
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 14);
              },
            ),
      bottomNavigationBar: cartProvider.cartItems.isNotEmpty? Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow( 
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, -1)
            )
          ]
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomAppBar(
          elevation: 0.0,
          height: 130,
          padding: const EdgeInsets.only(
              top: 18.0, bottom: 18.0, left: 26.0, right: 26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cartProvider.cartItems.length} items',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text('Total: \$ ${cartProvider.totalPrice.toStringAsFixed(3)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                            Navigator.pushNamed(
                                context, CheckoutScreen.routeName);
                          },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      )
      : null
    );
  }
}
