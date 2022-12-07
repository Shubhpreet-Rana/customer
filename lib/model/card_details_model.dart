class CardDetailsModel {
  CardDetailsModel({
    required this.id,
    required this.object,
    required this.billingDetails,
    required this.card,
    required this.created,
    required this.customer,
    required this.liveMode,
    required this.metadata,
    required this.type,
  });

  final String id;
  final String object;
  final BillingDetails billingDetails;
  final Card card;
  final int created;
  final String customer;
  final bool liveMode;
  final List<dynamic> metadata;
  final String type;

  factory CardDetailsModel.fromJson(Map<String, dynamic> json) => CardDetailsModel(
        id: json["id"],
        object: json["object"],
        billingDetails: BillingDetails.fromJson(json["billing_details"]),
        card: Card.fromJson(json["card"]),
        created: json["created"],
        customer: json["customer"],
        liveMode: json["livemode"],
        metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
        type: json["type"],
      );
}

class BillingDetails {
  BillingDetails({
    required this.address,
    required this.email,
    required this.name,
    required this.phone,
  });

  final Address address;
  final dynamic email;
  final String name;
  final dynamic phone;

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
        address: Address.fromJson(json["address"]),
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
      );
}

class Address {
  Address({
    required this.city,
    required this.country,
    required this.line1,
    required this.line2,
    required this.postalCode,
    required this.state,
  });

  final String city;
  final String country;
  final dynamic line1;
  final dynamic line2;
  final String postalCode;
  final String state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"],
        country: json["country"],
        line1: json["line1"],
        line2: json["line2"],
        postalCode: json["postal_code"],
        state: json["state"],
      );
}

class Card {
  Card({
    required this.brand,
    required this.checks,
    required this.country,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    required this.generatedFrom,
    required this.last4,
    required this.networks,
    required this.threeDSecureUsage,
    required this.wallet,
  });

  final String brand;
  final Checks checks;
  final String country;
  final int expMonth;
  final int expYear;
  final String fingerprint;
  final String funding;
  final dynamic generatedFrom;
  final String last4;
  final Networks networks;
  final ThreeDSecureUsage threeDSecureUsage;
  final dynamic wallet;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        brand: json["brand"],
        checks: Checks.fromJson(json["checks"]),
        country: json["country"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        funding: json["funding"],
        generatedFrom: json["generated_from"],
        last4: json["last4"],
        networks: Networks.fromJson(json["networks"]),
        threeDSecureUsage: ThreeDSecureUsage.fromJson(json["three_d_secure_usage"]),
        wallet: json["wallet"],
      );
}

class Checks {
  Checks({
    required this.addressLine1Check,
    required this.addressPostalCodeCheck,
    required this.cvcCheck,
  });

  final dynamic addressLine1Check;
  final String addressPostalCodeCheck;
  final String cvcCheck;

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
        addressLine1Check: json["address_line1_check"],
        addressPostalCodeCheck: json["address_postal_code_check"],
        cvcCheck: json["cvc_check"],
      );
}

class Networks {
  Networks({
    required this.available,
    required this.preferred,
  });

  final List<String> available;
  final dynamic preferred;

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
        available: List<String>.from(json["available"].map((x) => x)),
        preferred: json["preferred"],
      );
}

class ThreeDSecureUsage {
  ThreeDSecureUsage({
    required this.supported,
  });

  final bool supported;

  factory ThreeDSecureUsage.fromJson(Map<String, dynamic> json) => ThreeDSecureUsage(
        supported: json["supported"],
      );
}
