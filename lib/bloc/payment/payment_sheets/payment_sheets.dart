import 'package:flutter_stripe/flutter_stripe.dart';

class StripeServices {
  StripeServices._();

  static Stripe stripeInstance = Stripe.instance;
  static Address address = const Address(
    city: 'Houston',
    country: 'US',
    line1: '1459  Circle Drive',
    line2: '',
    state: 'Texas',
    postalCode: '77063',
  );
  static var billingDetails = BillingDetails(
    email: 'email@stripe.com',
    phone: '+48888000888',
    address: address,
  );

  static getCardToken() async {
    _createPaymentMethod();
    await stripeInstance.createToken(CreateTokenParams.card(params: cardTokenParams()));
  }

  static cardTokenParams() {
    return const CardTokenParams(address: Address(city: "Mohali", country: "India", line1: '', line2: "", postalCode: "166041", state: "Punjab"), currency: "INR", type: TokenType.Card, name: "Sahil");
  }

  static _createPaymentMethod() async {
    await Stripe.instance
        .createPaymentMethod(PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(
      billingDetails: billingDetails,
    )))
        .then((value) {
      _getCardToken();
    });
  }

  static _getCardToken() async {
    return await Stripe.instance.createToken(CreateTokenParams.card(params: CardTokenParams(name: "Sahil", type: TokenType.Card, currency: "INR", address: address))).then((value) {
    });
  }
}
