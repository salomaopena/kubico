import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/cart_product/checkout_manager.dart';
import 'package:kubico/models/orders/order.dart';
import 'package:provider/provider.dart';

class PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Formas de pagamento',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFFFFA9F59),
                    Color(0xFFF3F3F3),
                    Color(0xFFF3F3F3),
                  ],
                )),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VISA',
                        style: TextStyle(
                            color: Color(0xFF00269A),
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Número',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey[900]),
                      ),
                      const SizedBox(height: 2),
                      Text('5238 9156 1612 4758',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const SizedBox(height: 8),
                      Text(
                        'Validade',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey[900]),
                      ),
                      const SizedBox(height: 2),
                      Text('09/2090',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      const SizedBox(height: 8),
                      Text(
                        'Titular',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey[900]),
                      ),
                      const SizedBox(height: 2),
                      Text('SALOMAO PENA',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Consumer<CheckoutManager>(
              builder: (_, CheckoutManager checkoutManager, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: Payment.values.map((Payment payment) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CheckboxListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide.lerp(
                                  const BorderSide(width: 1),
                                  BorderSide(
                                      width: 1,
                                      color: Colors.pink.shade100),
                                  1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          title: Text(
                            Order.getPaymentText(payment.index),
                            style: GoogleFonts.roboto(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          dense: true,
                          activeColor: Colors.pink,
                          value: checkoutManager.pymentList
                              .contains(Order.getPaymentText(payment.index)),
                          onChanged: (value) {
                            checkoutManager.setPaymentFilter(
                                payment: Order.getPaymentText(payment.index),
                                enabled: value as bool);
                            if (value) {
                              checkoutManager.getPayment(
                                  payment: Order.getPaymentText(payment.index),
                                  isValid: value);
                            }
                          },
                          secondary: const Icon(Icons.money)),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
