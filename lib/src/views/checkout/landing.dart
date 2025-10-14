import 'package:flutter/material.dart';
import 'package:rexpay/rexpay.dart';
import 'package:rexpay/src/core/common/rexpay.dart';

class CheckoutLanding extends StatefulWidget {
  final Function(CheckoutMethod) selectCheckoutMethod;

  const CheckoutLanding({
    super.key,
    required this.selectCheckoutMethod,
  });

  @override
  State<CheckoutLanding> createState() => _CheckoutLandingState();
}

class _CheckoutLandingState extends State<CheckoutLanding> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _initialUI();
  }

  Widget _initialUI() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Please select your desire payment method to continue.',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/credit-card-payment.png",
              key: const Key("card"),
              package: 'rexpay',
              width: 24.0,
            ),
            title: Text("Pay with card"),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
            onTap: () {
              widget.selectCheckoutMethod(CheckoutMethod.card);
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/bank.png",
              key: const Key("bank"),
              package: 'rexpay',
              width: 24.0,
            ),
            title: Text("Pay with bank"),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
            onTap: () {
              widget.selectCheckoutMethod(CheckoutMethod.bank);
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/ussd.png",
              key: const Key("ussd"),
              package: 'rexpay',
              width: 24.0,
            ),
            title: Text("Pay with USSD"),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
            onTap: () {
              widget.selectCheckoutMethod(CheckoutMethod.USSD);
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
