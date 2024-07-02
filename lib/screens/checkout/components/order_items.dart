import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/providers/cart_provider.dart';
import 'package:interiorx/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class OrderItemsSection extends StatelessWidget {
  final CartProvider cartProvider;
  const OrderItemsSection({super.key, required this.cartProvider});

  @override
  Widget build(BuildContext context) {

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Order Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Container(
                child: cartProvider.cartItems.length > 2
                    ? GestureDetector(
                        onTap: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: AllItemsModal(cartProvider: cartProvider,),
                            )
                          );
                        },
                        child: const Text('View All',
                            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500)),
                      )
                    : null,
              )
            ],
          ),
          const SizedBox(height: 10,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              final item = cartProvider.cartItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CartItemWidget(imageUrl: item.imageUrl, name: item.name, price: item.price, quantity: item.quantity,));
            })
        ],
      ),
    );
  }
}


class AllItemsModal extends StatelessWidget {
  final CartProvider cartProvider;
  const AllItemsModal({super.key, required this.cartProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600) ,),
        leading: buildBackIconButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: cartProvider.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartProvider.cartItems[index];
              return CustomCard(
                child: CartItemWidget(
                  imageUrl: item.imageUrl,
                  name: item.name,
                  price: item.price,
                  quantity: item.quantity,
                ),
              );
          }, 
          separatorBuilder: (context, index) {
            return const SizedBox(height: 4.0,);
          }, 
          
        ),
      )
    );
  }
}


class CartItemWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final int quantity;

  const CartItemWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.w500);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(children: [
                const Text("\$ ", style: textStyle),
                Text("$price ", style: const TextStyle(color: kTextColor, fontSize: 15, fontWeight: FontWeight.w500),),
                const Text(" x ", style: textStyle,),
                Text(" $quantity ", style: const TextStyle(color: kTextColor, fontSize: 15, fontWeight: FontWeight.w500),),
              ],)
              
            ],
          ),
        ),
      ],
    );
  }
}
