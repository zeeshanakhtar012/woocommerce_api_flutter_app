import 'package:flutter/material.dart';

class PaymentGateway extends StatelessWidget {
  final String amount;

  const PaymentGateway({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Text("Payment Amount", style: textStyle()),
              amountInput(),
              embeddedCardView(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      paymentMethodsList(),
                      btn("Execute Payment", () {
                        // Payment execution logic goes here
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget embeddedCardView() {
    return Column(
      children: [
        SizedBox(height: 180, child: Container(color: Colors.grey)), // Placeholder for card view
        Row(
          children: [
            const SizedBox(width: 2),
            elevatedButton("Pay", () {
              // Payment logic goes here
            }),
            const SizedBox(width: 2),
            elevatedButton("Reload", () {
              // Reload logic goes here
            }),
          ],
        ),
      ],
    );
  }

  Widget paymentMethodsList() {
    return Column(
      children: [
        Text("Select payment method", style: textStyle()),
        SizedBox(
          height: 85,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Replace with actual number of methods
            itemBuilder: (BuildContext ctxt, int index) {
              return paymentMethodsItem(ctxt, index);
            },
          ),
        ),
      ],
    );
  }

  Widget paymentMethodsItem(BuildContext ctxt, int index) {
    return SizedBox(
      width: 70,
      height: 75,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.payment, size: 35), // Placeholder icon
              Text(
                "Method ${index + 1}", // Replace with actual method name
                style: TextStyle(fontSize: 8.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btn(String title, Function onPressed) {
    return SizedBox(
      width: double.infinity,
      child: elevatedButton(title, onPressed),
    );
  }

  Widget elevatedButton(String title, Function onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      child: Text(title, style: textStyle()),
      onPressed: () => onPressed(),
    );
  }

  Widget amountInput() {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      controller: TextEditingController(text: amount),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color(0xFF000000),
        hintText: "0.00",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, color: Colors.white);
  }
}
