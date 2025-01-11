import '../../../offers/data/models/offers_model.dart';

class UpsellingResponse {
  String? message;
  UpsellingData? data;

  UpsellingResponse({
    this.message,
    this.data,
  });

  factory UpsellingResponse.fromJson(Map<String, dynamic> json) =>
      UpsellingResponse(
        message: json['message'],
        data:
            json['data'] != null ? UpsellingData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
      };
}

class UpsellingData {
  UpsellingMeta? meta;
  List<FlightOfferUpSelling>? data;

  UpsellingData({
    this.meta,
    this.data,
  });

  factory UpsellingData.fromJson(Map<String, dynamic> json) => UpsellingData(
        meta:
            json['meta'] != null ? UpsellingMeta.fromJson(json['meta']) : null,
        data: json['data'] != null
            ? List<FlightOfferUpSelling>.from(
                json['data'].map((x) => FlightOfferUpSelling.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'meta': meta?.toJson(),
        'data': data?.map((x) => x.toJson()).toList(),
      };
}

class UpsellingMeta {
  int? count;

  UpsellingMeta({this.count});

  factory UpsellingMeta.fromJson(Map<String, dynamic> json) => UpsellingMeta(
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'count': count,
      };
}

class FlightOfferUpSelling {
  String? type;
  String? id;
  String? source;
  bool? instantTicketingRequired;
  bool? paymentCardRequired;
  String? lastTicketingDate;
  List<Itinerary>? itineraries;
  Price? price;
  PricingOptions? pricingOptions;
  List<String>? validatingAirlineCodes;
  List<TravelerPricingUpSelling>? travelerPricings;

  FlightOfferUpSelling({
    this.type,
    this.id,
    this.source,
    this.instantTicketingRequired,
    this.paymentCardRequired,
    this.lastTicketingDate,
    this.itineraries,
    this.price,
    this.pricingOptions,
    this.validatingAirlineCodes,
    this.travelerPricings,
  });

  factory FlightOfferUpSelling.fromJson(Map<String, dynamic> json) => FlightOfferUpSelling(
        type: json['type'],
        id: json['id'],
        source: json['source'],
        instantTicketingRequired: json['instantTicketingRequired'],
        paymentCardRequired: json['paymentCardRequired'],
        lastTicketingDate: json['lastTicketingDate'],
        itineraries: json['itineraries'] != null
            ? List<Itinerary>.from(
                json['itineraries'].map((x) => Itinerary.fromJson(x)))
            : null,
        price: json['price'] != null ? Price.fromJson(json['price']) : null,
        pricingOptions: json['pricingOptions'] != null
            ? PricingOptions.fromJson(json['pricingOptions'])
            : null,
        validatingAirlineCodes: json['validatingAirlineCodes'] != null
            ? List<String>.from(json['validatingAirlineCodes'])
            : null,
        travelerPricings: json['travelerPricings'] != null
            ? List<TravelerPricingUpSelling>.from(json['travelerPricings']
                .map((x) => TravelerPricingUpSelling.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'source': source,
        'instantTicketingRequired': instantTicketingRequired,
        'paymentCardRequired': paymentCardRequired,
        'lastTicketingDate': lastTicketingDate,
        'itineraries': itineraries?.map((x) => x.toJson()).toList(),
        'price': price?.toJson(),
        'pricingOptions': pricingOptions?.toJson(),
        'validatingAirlineCodes': validatingAirlineCodes,
        'travelerPricings': travelerPricings?.map((x) => x.toJson()).toList(),
      };
}

class Itinerary {
  List<Segment>? segments;
  String? duration;
  DurationData? durationData;

  Itinerary({this.segments, this.duration, this.durationData});

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        segments: json['segments'] != null
            ? List<Segment>.from(
                json['segments'].map((x) => Segment.fromJson(x)))
            : null,
        duration: json['duration'],
        durationData: json['durationData'] != null
            ? DurationData.fromJson(json['durationData'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'segments': segments?.map((x) => x.toJson()).toList(),
        'duration': duration,
        'durationData': durationData?.toJson(),
      };
}

class Segment {
  SegmentLocation? departure;
  SegmentLocation? arrival;
  String? carrierCode;
  String? number;
  Aircraft? aircraft;
  OperatingCarrier? operating;
  String? duration;
  String? id;
  int? numberOfStops;
  bool? blacklistedInEU;
  DurationData? durationData;
  String? carrierLogo;

  Segment({
    this.departure,
    this.arrival,
    this.carrierCode,
    this.number,
    this.aircraft,
    this.operating,
    this.duration,
    this.id,
    this.numberOfStops,
    this.blacklistedInEU,
    this.durationData,
    this.carrierLogo,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        departure: json['departure'] != null
            ? SegmentLocation.fromJson(json['departure'])
            : null,
        arrival: json['arrival'] != null
            ? SegmentLocation.fromJson(json['arrival'])
            : null,
        carrierCode: json['carrierCode'],
        number: json['number'],
        aircraft: json['aircraft'] != null
            ? Aircraft.fromJson(json['aircraft'])
            : null,
        operating: json['operating'] != null
            ? OperatingCarrier.fromJson(json['operating'])
            : null,
        duration: json['duration'],
        id: json['id'],
        numberOfStops: json['numberOfStops'],
        blacklistedInEU: json['blacklistedInEU'],
        durationData: json['durationData'] != null
            ? DurationData.fromJson(json['durationData'])
            : null,
        carrierLogo: json['carrierLogo'],
      );

  Map<String, dynamic> toJson() => {
        'departure': departure?.toJson(),
        'arrival': arrival?.toJson(),
        'carrierCode': carrierCode,
        'number': number,
        'aircraft': aircraft?.toJson(),
        'operating': operating?.toJson(),
        'duration': duration,
        'id': id,
        'numberOfStops': numberOfStops,
        'blacklistedInEU': blacklistedInEU,
        'durationData': durationData?.toJson(),
        'carrierLogo': carrierLogo,
      };
}

class SegmentLocation {
  String? iataCode;
  String? terminal;
  String? at;

  SegmentLocation({this.iataCode, this.terminal, this.at});

  factory SegmentLocation.fromJson(Map<String, dynamic> json) =>
      SegmentLocation(
        iataCode: json['iataCode'],
        terminal: json['terminal'],
        at: json['at'],
      );

  Map<String, dynamic> toJson() => {
        'iataCode': iataCode,
        'terminal': terminal,
        'at': at,
      };
}

class Aircraft {
  String? code;

  Aircraft({this.code});

  factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
      };
}

class OperatingCarrier {
  String? carrierCode;

  OperatingCarrier({this.carrierCode});

  factory OperatingCarrier.fromJson(Map<String, dynamic> json) =>
      OperatingCarrier(
        carrierCode: json['carrierCode'],
      );

  Map<String, dynamic> toJson() => {
        'carrierCode': carrierCode,
      };
}

class Price {
  String? currency;
  String? total;
  String? base;
  List<Fee>? fees;
  String? grandTotal;

  Price({
    this.currency,
    this.total,
    this.base,
    this.fees,
    this.grandTotal,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        currency: json['currency'],
        total: json['total'],
        base: json['base'],
        fees: json['fees'] != null
            ? List<Fee>.from(json['fees'].map((x) => Fee.fromJson(x)))
            : null,
        grandTotal: json['grandTotal'],
      );

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'total': total,
        'base': base,
        'fees': fees?.map((x) => x.toJson()).toList(),
        'grandTotal': grandTotal,
      };
}

class Fee {
  String? amount;
  String? type;

  Fee({this.amount, this.type});

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        amount: json['amount'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'type': type,
      };
}

class PricingOptions {
  List<String>? fareType;
  bool? includedCheckedBagsOnly;
  bool? refundableFare;
  bool? noRestrictionFare;
  bool? noPenaltyFare;

  PricingOptions({
    this.fareType,
    this.includedCheckedBagsOnly,
    this.refundableFare,
    this.noRestrictionFare,
    this.noPenaltyFare,
  });

  factory PricingOptions.fromJson(Map<String, dynamic> json) => PricingOptions(
        fareType: json['fareType'] != null
            ? List<String>.from(json['fareType'])
            : null,
        includedCheckedBagsOnly: json['includedCheckedBagsOnly'],
        refundableFare: json['refundableFare'],
        noRestrictionFare: json['noRestrictionFare'],
        noPenaltyFare: json['noPenaltyFare'],
      );

  Map<String, dynamic> toJson() => {
        'fareType': fareType,
        'includedCheckedBagsOnly': includedCheckedBagsOnly,
        'refundableFare': refundableFare,
        'noRestrictionFare': noRestrictionFare,
        'noPenaltyFare': noPenaltyFare,
      };
}

class TravelerPricingUpSelling {
  String? travelerId;
  String? fareOption;
  String? travelerType;
  Price? price;
  List<FareDetailBySegment>? fareDetailsBySegment;

  TravelerPricingUpSelling({
    this.travelerId,
    this.fareOption,
    this.travelerType,
    this.price,
    this.fareDetailsBySegment,
  });

  factory TravelerPricingUpSelling.fromJson(Map<String, dynamic> json) =>
      TravelerPricingUpSelling(
        travelerId: json['travelerId'],
        fareOption: json['fareOption'],
        travelerType: json['travelerType'],
        price: json['price'] != null ? Price.fromJson(json['price']) : null,
        fareDetailsBySegment: json['fareDetailsBySegment'] != null
            ? List<FareDetailBySegment>.from(json['fareDetailsBySegment']
                .map((x) => FareDetailBySegment.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'travelerId': travelerId,
        'fareOption': fareOption,
        'travelerType': travelerType,
        'price': price?.toJson(),
        'fareDetailsBySegment':
            fareDetailsBySegment?.map((x) => x.toJson()).toList(),
      };
}

class FareDetailBySegment {
  String? segmentId;
  String? cabin;
  String? fareBasis;
  String? brandedFare;
  String? className;
  IncludedCheckedBags? includedCheckedBags;
  List<Amenity>? amenities;

  FareDetailBySegment({
    this.segmentId,
    this.cabin,
    this.fareBasis,
    this.brandedFare,
    this.className,
    this.includedCheckedBags,
    this.amenities,
  });

  factory FareDetailBySegment.fromJson(Map<String, dynamic> json) =>
      FareDetailBySegment(
        segmentId: json['segmentId'],
        cabin: json['cabin'],
        fareBasis: json['fareBasis'],
        brandedFare: json['brandedFare'],
        className: json['class'],
        includedCheckedBags: json['includedCheckedBags'] != null
            ? IncludedCheckedBags.fromJson(json['includedCheckedBags'])
            : null,
        amenities: json['amenities'] != null
            ? List<Amenity>.from(
                json['amenities'].map((x) => Amenity.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'segmentId': segmentId,
        'cabin': cabin,
        'fareBasis': fareBasis,
        'brandedFare': brandedFare,
        'class': className,
        'includedCheckedBags': includedCheckedBags?.toJson(),
        'amenities': amenities?.map((x) => x.toJson()).toList(),
      };
}

class IncludedCheckedBags {
  int? weight;
  String? weightUnit;

  IncludedCheckedBags({this.weight, this.weightUnit});

  factory IncludedCheckedBags.fromJson(Map<String, dynamic> json) =>
      IncludedCheckedBags(
        weight: json['weight'],
        weightUnit: json['weightUnit'],
      );

  Map<String, dynamic> toJson() => {
        'weight': weight,
        'weightUnit': weightUnit,
      };
}

class Amenity {
  String? code;
  String? description;
  bool? isChargeable;
  String? amenityType;

  Amenity({
    this.code,
    this.description,
    this.isChargeable,
    this.amenityType,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        code: json['code'],
        description: json['description'],
        isChargeable: json['isChargeable'],
        amenityType: json['amenityType'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'description': description,
        'isChargeable': isChargeable,
        'amenityType': amenityType,
      };
}
