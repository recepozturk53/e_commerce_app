import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Color(0xFFFF9900),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Color(0xFFFF9900),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Color(0xFFFF9900),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
            ),
          ],
        ),
      ),
    );
  }
}
