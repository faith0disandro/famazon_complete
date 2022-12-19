import "package:flutter/material.dart";

class SingleProduct extends StatelessWidget {
  final String image;

  const SingleProduct({
    Key? key, 
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.black,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white, 
            width: 1.5
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: Image.network(
            image, 
            fit: BoxFit.fitHeight,
            width: 180
          ),
        ),
      ),
    );
  }
}