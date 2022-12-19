import 'package:famazon/common/widgets/loader.dart';
import 'package:famazon/features/home/services/home_services.dart';
import 'package:famazon/features/product_details/screens/product_details_screen.dart';
import 'package:famazon/models/product.dart';
import "package:flutter/material.dart";

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      child: const Text(
                        'Deal of the Day',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 15,
                      ),
                      child: Text(
                        product!.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 5,
                          right: 40,
                          bottom: 15
                        ),
                        child: Text(
                          style: const TextStyle(color: Colors.white),
                          
                          '\$${product!.price}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: product!.images
                            .map(
                              (e) =>
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.fitHeight,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'See all deals',
                        style: TextStyle(
                          color:
                              Color.fromRGBO(143, 38, 0, 1), //Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
