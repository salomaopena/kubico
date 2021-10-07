import 'package:flutter/material.dart';
import 'package:kubico/models/cart_product/cart_manager.dart';
import 'package:kubico/models/users/user_address.dart';
import 'package:kubico/screens/address/components/address_input_field.dart';
import 'package:kubico/screens/address/components/search_input_field.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<CartManager>(
          builder: (_, cartManager, __) {
            final address = cartManager.address ??
                UserAddress(latitude: 1.1, longitude: 1.1);
            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Endereço de entrega',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[900],
                      fontSize: 17,
                    ),
                  ),
                  CepInputField(address: address as UserAddress),
                  AddressInpuField(address: address as UserAddress),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
