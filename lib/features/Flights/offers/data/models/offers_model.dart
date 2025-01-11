class OffersModel {
  final String message;
  final OffersData data;

  OffersModel({
    required this.message,
    required this.data,
  });

  factory OffersModel.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return OffersModel(
      message: typedJson["message"] ?? "",
      data: OffersData.fromJson(typedJson["data"] ?? {}),
    );
  }
}

class OffersData {
  final Meta meta;
  final List<FlightOffer> data;
  final Dictionaries dictionaries;

  OffersData({
    required this.meta,
    required this.data,
    required this.dictionaries,
  });

  factory OffersData.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return OffersData(
      meta: Meta.fromJson(typedJson["meta"] ?? {}),
      data: typedJson["data"] != null
          ? List<FlightOffer>.from(
              typedJson["data"].map((x) => FlightOffer.fromJson(x)))
          : [],
      dictionaries: Dictionaries.fromJson(typedJson["dictionaries"] ?? {}),
    );
  }
}

class Meta {
  final int count;
  final Links links;

  Meta({
    required this.count,
    required this.links,
  });

  factory Meta.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Meta(
      count: typedJson["count"] ?? 0,
      links: Links.fromJson(typedJson["links"] ?? {}),
    );
  }
}

class Links {
  final String self;

  Links({
    required this.self,
  });

  factory Links.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Links(
      self: typedJson["self"] ?? "",
    );
  }
}

class FlightOffer {
  final String type;
  final String id;
  final String source;
  final bool instantTicketingRequired;
  final bool nonHomogeneous;
  final bool oneWay;
  final bool isUpsellOffer;
  final String lastTicketingDate;
  final String lastTicketingDateTime;
  final int numberOfBookableSeats;
  final List<Itinerary> itineraries;
  final Price price;
  final PricingOptions pricingOptions;
  final List<String> validatingAirlineCodes;
  final List<TravelerPricing> travelerPricings;

  FlightOffer({
    required this.type,
    required this.id,
    required this.source,
    required this.instantTicketingRequired,
    required this.nonHomogeneous,
    required this.oneWay,
    required this.isUpsellOffer,
    required this.lastTicketingDate,
    required this.lastTicketingDateTime,
    required this.numberOfBookableSeats,
    required this.itineraries,
    required this.price,
    required this.pricingOptions,
    required this.validatingAirlineCodes,
    required this.travelerPricings,
  });

  factory FlightOffer.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return FlightOffer(
      type: typedJson["type"] ?? "",
      id: typedJson["id"] ?? "",
      source: typedJson["source"] ?? "",
      instantTicketingRequired: typedJson["instantTicketingRequired"] ?? false,
      nonHomogeneous: typedJson["nonHomogeneous"] ?? false,
      oneWay: typedJson["oneWay"] ?? false,
      isUpsellOffer: typedJson["isUpsellOffer"] ?? false,
      lastTicketingDate: typedJson["lastTicketingDate"] ?? "",
      lastTicketingDateTime: typedJson["lastTicketingDateTime"] ?? "",
      numberOfBookableSeats: typedJson["numberOfBookableSeats"] ?? 0,
      itineraries: typedJson["itineraries"] != null
          ? List<Itinerary>.from(
              typedJson["itineraries"].map((x) => Itinerary.fromJson(x)))
          : [],
      price: Price.fromJson(typedJson["price"] ?? {}),
      pricingOptions:
          PricingOptions.fromJson(typedJson["pricingOptions"] ?? {}),
      validatingAirlineCodes: typedJson["validatingAirlineCodes"] != null
          ? List<String>.from(
              typedJson["validatingAirlineCodes"].map((x) => x ?? ""))
          : [],
      travelerPricings: typedJson["travelerPricings"] != null
          ? List<TravelerPricing>.from(typedJson["travelerPricings"]
              .map((x) => TravelerPricing.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "source": source,
        "instantTicketingRequired": instantTicketingRequired,
        "nonHomogeneous": nonHomogeneous,
        "oneWay": oneWay,
        "isUpsellOffer": isUpsellOffer,
        "lastTicketingDate": lastTicketingDate,
        "lastTicketingDateTime": lastTicketingDateTime,
        "numberOfBookableSeats": numberOfBookableSeats,
        "itineraries": itineraries.map((e) => e.toJson()).toList(),
        "price": price.toJson(),
        "pricingOptions": pricingOptions.toJson(),
        "validatingAirlineCodes": validatingAirlineCodes,
        "travelerPricings": travelerPricings.map((e) => e.toJson()).toList(),
      };
}

class Itinerary {
  final String duration;
  final DurationData durationData;
  final List<Segment> segments;

  Itinerary({
    required this.duration,
    required this.durationData,
    required this.segments,
  });

  factory Itinerary.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Itinerary(
      duration: typedJson["duration"].toString() ?? "",
      durationData: DurationData.fromJson(typedJson["durationData"] ?? {}),
      segments: typedJson["segments"] != null
          ? List<Segment>.from(
              typedJson["segments"].map((x) => Segment.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "durationData": durationData.toJson(),
        "segments": segments.map((e) => e.toJson()).toList(),
      };
}

class DurationData {
  final String hours;
  final String minutes;

  DurationData({
    required this.hours,
    required this.minutes,
  });

  factory DurationData.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return DurationData(
      hours: typedJson["hours"].toString() ?? "",
      minutes: typedJson["minutes"].toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "hours": hours,
        "minutes": minutes,
      };
}

class Segment {
  final Location departure;
  final Location arrival;
  final String carrierCode;
  final String number;
  final Aircraft aircraft;
  final Operating operating;
  final String duration;
  final String id;
  final int numberOfStops;
  final bool blacklistedInEU;
  final DurationData durationData;
  final String carrierLogo;

  Segment({
    required this.departure,
    required this.arrival,
    required this.carrierCode,
    required this.number,
    required this.aircraft,
    required this.operating,
    required this.duration,
    required this.id,
    required this.numberOfStops,
    required this.blacklistedInEU,
    required this.durationData,
    required this.carrierLogo,
  });

  factory Segment.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Segment(
      departure: Location.fromJson(typedJson["departure"] ?? {}),
      arrival: Location.fromJson(typedJson["arrival"] ?? {}),
      carrierCode: typedJson["carrierCode"] ?? "",
      number: typedJson["number"] ?? "",
      aircraft: Aircraft.fromJson(typedJson["aircraft"] ?? {}),
      operating: Operating.fromJson(typedJson["operating"] ?? {}),
      duration: typedJson["duration"].toString() ?? "",
      id: typedJson["id"] ?? "",
      numberOfStops: typedJson["numberOfStops"] ?? 0,
      blacklistedInEU: typedJson["blacklistedInEU"] ?? false,
      durationData: DurationData.fromJson(typedJson["durationData"] ?? {}),
      carrierLogo: typedJson["carrierLogo"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "departure": departure.toJson(),
        "arrival": arrival.toJson(),
        "carrierCode": carrierCode,
        "number": number,
        "aircraft": aircraft.toJson(),
        "operating": operating.toJson(),
        "duration": duration,
        "id": id,
        "numberOfStops": numberOfStops,
        "blacklistedInEU": blacklistedInEU,
        "durationData": durationData.toJson(),
        "carrierLogo": carrierLogo,
      };
}

class Location {
  final String iataCode;
  final String terminal;
  final String at;

  Location({
    required this.iataCode,
    required this.terminal,
    required this.at,
  });

  factory Location.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Location(
      iataCode: typedJson["iataCode"] ?? "",
      terminal: typedJson["terminal"] ?? "",
      at: typedJson["at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "iataCode": iataCode,
        "terminal": terminal,
        "at": at,
      };
}

class Aircraft {
  final String code;

  Aircraft({
    required this.code,
  });

  factory Aircraft.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Aircraft(
      code: typedJson["code"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}

class Operating {
  final String carrierCode;

  Operating({
    required this.carrierCode,
  });

  factory Operating.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Operating(
      carrierCode: typedJson["carrierCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "carrierCode": carrierCode,
      };
}

class Price {
  final String currency;
  final String total;
  final String base;
  final List<Fee> fees;
  final String grandTotal;

  Price({
    required this.currency,
    required this.total,
    required this.base,
    required this.fees,
    required this.grandTotal,
  });

  factory Price.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Price(
      currency: typedJson["currency"] ?? "",
      total: typedJson["total"] ?? "",
      base: typedJson["base"] ?? "",
      fees: typedJson["fees"] != null
          ? List<Fee>.from(typedJson["fees"].map((x) => Fee.fromJson(x)))
          : [],
      grandTotal: typedJson["grandTotal"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "total": total,
        "base": base,
        "fees": fees.map((e) => e.toJson()).toList(),
        "grandTotal": grandTotal,
      };
}

class Fee {
  final String amount;
  final String type;

  Fee({
    required this.amount,
    required this.type,
  });

  factory Fee.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Fee(
      amount: typedJson["amount"] ?? "",
      type: typedJson["type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "type": type,
      };
}

class PricingOptions {
  final List<String> fareType;
  final bool includedCheckedBagsOnly;

  PricingOptions({
    required this.fareType,
    required this.includedCheckedBagsOnly,
  });

  factory PricingOptions.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return PricingOptions(
      fareType: typedJson["fareType"] != null
          ? List<String>.from(typedJson["fareType"].map((x) => x ?? ""))
          : [],
      includedCheckedBagsOnly: typedJson["includedCheckedBagsOnly"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "fareType": fareType,
        "includedCheckedBagsOnly": includedCheckedBagsOnly,
      };
}

class TravelerPricing {
  final String travelerId;
  final String fareOption;
  final String travelerType;
  final Price price;
  final List<FareDetailsBySegment> fareDetailsBySegment;

  TravelerPricing({
    required this.travelerId,
    required this.fareOption,
    required this.travelerType,
    required this.price,
    required this.fareDetailsBySegment,
  });

  factory TravelerPricing.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return TravelerPricing(
      travelerId: typedJson["travelerId"] ?? "",
      fareOption: typedJson["fareOption"] ?? "",
      travelerType: typedJson["travelerType"] ?? "",
      price: Price.fromJson(typedJson["price"] ?? {}),
      fareDetailsBySegment: typedJson["fareDetailsBySegment"] != null
          ? List<FareDetailsBySegment>.from(typedJson["fareDetailsBySegment"]
              .map((x) => FareDetailsBySegment.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "travelerId": travelerId,
        "fareOption": fareOption,
        "travelerType": travelerType,
        "price": price.toJson(),
        "fareDetailsBySegment":
            fareDetailsBySegment.map((e) => e.toJson()).toList(),
      };
}

class FareDetailsBySegment {
  final String segmentId;
  final String cabin;
  final String fareBasis;
  final String classType;
  final IncludedCheckedBags includedCheckedBags;

  FareDetailsBySegment({
    required this.segmentId,
    required this.cabin,
    required this.fareBasis,
    required this.classType,
    required this.includedCheckedBags,
  });

  factory FareDetailsBySegment.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return FareDetailsBySegment(
      segmentId: typedJson["segmentId"] ?? "",
      cabin: typedJson["cabin"] ?? "",
      fareBasis: typedJson["fareBasis"] ?? "",
      classType: typedJson["class"] ?? "",
      includedCheckedBags:
          IncludedCheckedBags.fromJson(typedJson["includedCheckedBags"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "segmentId": segmentId,
        "cabin": cabin,
        "fareBasis": fareBasis,
        "class": classType,
        "includedCheckedBags": includedCheckedBags.toJson(),
      };
}

class IncludedCheckedBags {
  final int weight;
  final String weightUnit;

  IncludedCheckedBags({
    required this.weight,
    required this.weightUnit,
  });

  factory IncludedCheckedBags.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return IncludedCheckedBags(
      weight: typedJson["weight"] ?? 0,
      weightUnit: typedJson["weightUnit"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "weightUnit": weightUnit,
      };
}

class Dictionaries {
  final Map<String, Location> locations;
  final Map<String, String> aircraft;
  final Map<String, String> currencies;
  final Map<String, String> carriers;

  Dictionaries({
    required this.locations,
    required this.aircraft,
    required this.currencies,
    required this.carriers,
  });

  factory Dictionaries.fromJson(dynamic json) {
    
    final Map<String, dynamic> typedJson = Map<String, dynamic>.from(json);

    return Dictionaries(
      locations: typedJson["locations"] != null
          ? Map.from(typedJson["locations"])
              .map((k, v) => MapEntry(k, Location.fromJson(v)))
          : {},
      aircraft: typedJson["aircraft"] != null
          ? Map.from(typedJson["aircraft"])
              .map((k, v) => MapEntry(k, v?.toString() ?? ""))
          : {},
      currencies: typedJson["currencies"] != null
          ? Map.from(typedJson["currencies"])
              .map((k, v) => MapEntry(k, v?.toString() ?? ""))
          : {},
      carriers: typedJson["carriers"] != null
          ? Map.from(typedJson["carriers"])
              .map((k, v) => MapEntry(k, v?.toString() ?? ""))
          : {},
    );
  }
}
