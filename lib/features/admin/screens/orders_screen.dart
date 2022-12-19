import 'package:famazon/common/widgets/loader.dart';
import 'package:famazon/features/account/widgets/single_product.dart';
import 'package:famazon/features/admin/services/admin_services.dart';
import 'package:famazon/features/order_details/screens/orders_details.dart';
import 'package:famazon/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return orders == null ? const Loader() : GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: orders!.length,
      itemBuilder: (context, index) {
        final orderData = orders![index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: orderData);
          },
          child: SizedBox(
            height: 140,
            child: SingleProduct(image: orderData.products[0].images[0]),
          ),
        );
      },
    );
  }
}
