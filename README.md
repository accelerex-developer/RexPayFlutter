# :credit_card: Repay Plugin for Flutter



A Flutter plugin for making payments via RexPay Payment Gateway. Fully
supports Android and iOS
## :rocket: Installation
To use this plugin, add `rexpay` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Then initialize the plugin preferably in the `initState` of your widget.

``` dart
import 'package:rexpay/rexpay.dart';

class _PaymentPageState extends State<PaymentPage> {
  String password = 'Your RexPay username';
  String username = 'Your RexPay username';
  String publicKey = 'Your RexPay generated public key';
  String privateKey = 'Your RexPay generated private key';
  String passPhrase = 'Your RexPay generated passphrase';
  String rexpayPublicKey = 'Rexpay public key, Which is available on RexPay documentation';
  Mode mode = Mode.test 'This can either be [Mode.test] when you app in the development phase or [Mode.live] when you are in been build for production. This is set Mode.test by default';

  final plugin = RexpayPlugin();

  @override
  void initState() {
    plugin.initialize(
      authKeys: AuthKeys(
        publicKey: publicKey,
        privateKey: privateKey,
        username: username,
        password: password,
        passPhrase: passPhrase,
        rexPayPublicKey: rexpayPublicKey,
        mode: mode,
      ),
    );
  }
}
```

No other configuration required&mdash;the plugin works out of the box.

## :heavy_dollar_sign: Making Payments
There are two ways of making payment with the plugin.
1.  **Checkout**: This is the easy way; as the plugin handles all the
    processes involved in making a payment (except transaction
    initialization and verification which should be done from your
    backend).
2.  **Charge Card**: This is a longer approach; you handle all callbacks
    and UI states.

### 1. :star2: Checkout (Recommended)
 You initialize a charge object with an amount, customer email  & reference.
 

 ```dart
 Charge charge = Charge()
       ..amount = 10000
       ..reference = 'Generated reference number'
       ..email = 'customer@email.com';

     CheckoutResponse response = await plugin.checkout(
       context context,
       method: CheckoutMethod.selectable,
       charge: charge,
     );
 ```

 `plugin.checkout()` returns the state and details of the
 payment in an instance of `CheckoutResponse` .
 

