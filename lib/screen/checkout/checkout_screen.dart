import 'package:e_commerce_app/widget/widgets.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CUSTOMER INFORMATION',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            _buildTextFormField(emailController, context, 'Email'),
            _buildTextFormField(nameController, context, 'Full Name'),
            const SizedBox(height: 20),
            Text(
              'DELIVERY INFORMATION',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            _buildTextFormField(addressController, context, 'Address'),
            _buildTextFormField(cityController, context, 'City'),
            _buildTextFormField(countryController, context, 'Country'),
            _buildTextFormField(zipCodeController, context, 'ZIP Code'),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text(
                      'SELECT A PAYMENT METHOD',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'ORDER SUMMARY',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const OrderSummary()
          ],
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    TextEditingController controller,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                // labelText: labelText,
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
