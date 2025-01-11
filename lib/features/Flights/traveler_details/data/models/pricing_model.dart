import '../../../offers/data/models/offers_model.dart';

class PricingModel {
  String? message;
  Data? data;
  List<dynamic>? errors;
  int? state;
  bool? success;

  PricingModel({
    this.message,
    this.data,
    this.errors,
    this.state,
    this.success,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]!.map((x) => x)),
        state: json["state"],
        success: json["success"],
      );
}

class Data {
  DataClass? data;
  Included? included;
  Dictionaries? dictionaries;

  Data({
    this.data,
    this.included,
    this.dictionaries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null ? null : DataClass.fromJson(json["data"]),
        included: json["included"] == null
            ? null
            : Included.fromJson(json["included"]),
        dictionaries: json["dictionaries"] == null
            ? null
            : Dictionaries.fromJson(json["dictionaries"]),
      );
}

class DataClass {
  String? type;
  List<FlightOffer>? flightOffers;
  BookingRequirements? bookingRequirements;

  DataClass({
    this.type,
    this.flightOffers,
    this.bookingRequirements,
  });

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
        type: json["type"],
        flightOffers: json["flightOffers"] == null
            ? []
            : List<FlightOffer>.from(
                json["flightOffers"]!.map((x) => FlightOffer.fromJson(x))),
        bookingRequirements: json["bookingRequirements"] == null
            ? null
            : BookingRequirements.fromJson(json["bookingRequirements"]),
      );
}

class DurationData {
  String? hours;
  String? minutes;

  DurationData({
    this.hours,
    this.minutes,
  });

  factory DurationData.fromJson(Map<String, dynamic> json) => DurationData(
        hours: json["hours"],
        minutes: json["minutes"],
      );
}

class IncludedCheckedBags {
  int? quantity;

  IncludedCheckedBags({
    this.quantity,
  });

  factory IncludedCheckedBags.fromJson(Map<String, dynamic> json) =>
      IncludedCheckedBags(
        quantity: json["quantity"],
      );
}

class BookingRequirements {
  bool? emailAddressRequired;
  bool? mobilePhoneNumberRequired;
  bool? postalCodeRequired;
  bool? countryCodeRequired;
  bool? mailingAddressRequired;
  bool? invoiceRequired;
  bool? phoneNumberRequired;

  BookingRequirements({
    this.emailAddressRequired,
    this.mobilePhoneNumberRequired,
    this.countryCodeRequired,
    this.postalCodeRequired,
    this.mailingAddressRequired,
    this.invoiceRequired,
    this.phoneNumberRequired,
  });

  factory BookingRequirements.fromJson(Map<String, dynamic> json) =>
      BookingRequirements(
          emailAddressRequired: json["emailAddressRequired"] ?? false,
          mobilePhoneNumberRequired: json["mobilePhoneNumberRequired"] ?? false,
          postalCodeRequired: json["postalCodeRequired"] ?? false,
          countryCodeRequired: json["phoneCountryCodeRequired"] ?? false,
          mailingAddressRequired: json['mailingAddressRequired'] ?? false,
          invoiceRequired: json['invoiceAddressRequired'] ?? false,
          phoneNumberRequired: json['phoneNumberRequired'] ?? false);

  Map<String, dynamic> toJson() => {
        'emailAddressRequired': emailAddressRequired,
        'mobilePhoneNumberRequired': mobilePhoneNumberRequired,
        'postalCodeRequired': postalCodeRequired,
        'countryCodeRequired': countryCodeRequired,
        'mailingAddressRequired': mailingAddressRequired,
        'invoiceRequired': invoiceRequired,
        'phoneNumberRequired': phoneNumberRequired,
      };
}

class Included {
  Map<String, Bag>? bags;

  Included({
    this.bags,
  });

  factory Included.fromJson(Map<String, dynamic> json) => Included(
        bags: json["bags"] == null
            ? null
            : Map.from(json["bags"]!)
                .map((k, v) => MapEntry<String, Bag>(k, Bag.fromJson(v))),
      );
}

class Bag {
  int? quantity;
  String? name;
  BagPrice? price;
  bool? bookableByItinerary;
  List<String>? segmentIds;
  List<String>? travelerIds;

  Bag({
    this.quantity,
    this.name,
    this.price,
    this.bookableByItinerary,
    this.segmentIds,
    this.travelerIds,
  });

  factory Bag.fromJson(Map<String, dynamic> json) => Bag(
        quantity: json["quantity"],
        name: json["name"],
        price: json["price"] == null ? null : BagPrice.fromJson(json["price"]),
        bookableByItinerary: json["bookableByItinerary"],
        segmentIds: json["segmentIds"] == null
            ? []
            : List<String>.from(json["segmentIds"]!.map((x) => x)),
        travelerIds: json["travelerIds"] == null
            ? []
            : List<String>.from(json["travelerIds"]!.map((x) => x)),
      );
}

class BagPrice {
  String? amount;
  String? currencyCode;

  BagPrice({
    this.amount,
    this.currencyCode,
  });

  factory BagPrice.fromJson(Map<String, dynamic> json) => BagPrice(
        amount: json["amount"],
        currencyCode: json["currencyCode"],
      );
}

class Dictionaries {
  Map<String, Location>? locations;

  Dictionaries({
    this.locations,
  });

  factory Dictionaries.fromJson(Map<String, dynamic> json) => Dictionaries(
        locations: json["locations"] == null
            ? null
            : Map.from(json["locations"]!).map(
                (k, v) => MapEntry<String, Location>(k, Location.fromJson(v))),
      );
}

class Location {
  String? cityCode;
  String? countryCode;

  Location({
    this.cityCode,
    this.countryCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        cityCode: json["cityCode"],
        countryCode: json["countryCode"],
      );
}
