class HotelOffersModel {
  final String message;
  final HotelOffersData data;
  final List<dynamic> errors;
  final int state;
  final bool success;

  HotelOffersModel({
    required this.message,
    required this.data,
    required this.errors,
    required this.state,
    required this.success,
  });

  factory HotelOffersModel.fromJson(Map<String, dynamic> json) {
    return HotelOffersModel(
      message: json['message'] ?? '',
      data: HotelOffersData.fromJson(json['data']),
      errors: json['errors'] ?? [],
      state: json['state'] ?? 0,
      success: json['success'] ?? false,
    );
  }
}

class HotelOffersData {
  final List<HotelOffer> data;
  final Map<String, dynamic> dictionaries;

  HotelOffersData({
    required this.data,
    required this.dictionaries,
  });

  factory HotelOffersData.fromJson(Map<String, dynamic> json) {
    return HotelOffersData(
      data: (json['data'] as List).map((x) => HotelOffer.fromJson(x)).toList(),
      dictionaries: json['dictionaries'] ?? {},
    );
  }
}

class HotelOffer {
  final String type;
  final Hotel hotel;
  final bool available;
  final List<Offer> offers;
  final String self;

  HotelOffer({
    required this.type,
    required this.hotel,
    required this.available,
    required this.offers,
    required this.self,
  });

  factory HotelOffer.fromJson(Map<String, dynamic> json) {
    return HotelOffer(
      type: json['type'] ?? '',
      hotel: Hotel.fromJson(json['hotel']),
      available: json['available'] ?? false,
      offers: (json['offers'] as List).map((x) => Offer.fromJson(x)).toList(),
      self: json['self'] ?? '',
    );
  }
}

class Hotel {
  final String type;
  final String hotelId;
  final String chainCode;
  final String dupeId;
  final String name;
  final String cityCode;
  final double latitude;
  final double longitude;

  Hotel({
    required this.type,
    required this.hotelId,
    required this.chainCode,
    required this.dupeId,
    required this.name,
    required this.cityCode,
    required this.latitude,
    required this.longitude,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      type: json['type'] ?? '',
      hotelId: json['hotelId'] ?? '',
      chainCode: json['chainCode'] ?? '',
      dupeId: json['dupeId'] ?? '',
      name: json['name'] ?? '',
      cityCode: json['cityCode'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
    );
  }
}

class Offer {
  final String id;
  final int roomQuantity;
  final String checkInDate;
  final String checkOutDate;
  final String rateCode;
  final RateFamily rateFamilyEstimated;
  final Room room;
  final Guests guests;
  final Price price;
  final Policies policies;
  final String self;

  Offer({
    required this.id,
    required this.roomQuantity,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rateCode,
    required this.rateFamilyEstimated,
    required this.room,
    required this.guests,
    required this.price,
    required this.policies,
    required this.self,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] ?? '',
      roomQuantity: json['roomQuantity'] ?? 0,
      checkInDate: json['checkInDate'] ?? '',
      checkOutDate: json['checkOutDate'] ?? '',
      rateCode: json['rateCode'] ?? '',
      rateFamilyEstimated: RateFamily.fromJson(json['rateFamilyEstimated']),
      room: Room.fromJson(json['room']),
      guests: Guests.fromJson(json['guests']),
      price: Price.fromJson(json['price']),
      policies: Policies.fromJson(json['policies']),
      self: json['self'] ?? '',
    );
  }
}

class RateFamily {
  final String code;
  final String type;

  RateFamily({
    required this.code,
    required this.type,
  });

  factory RateFamily.fromJson(Map<String, dynamic> json) {
    return RateFamily(
      code: json['code'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class Room {
  final String type;
  final TypeEstimated typeEstimated;
  final Description description;

  Room({
    required this.type,
    required this.typeEstimated,
    required this.description,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      type: json['type'] ?? '',
      typeEstimated: TypeEstimated.fromJson(json['typeEstimated']),
      description: Description.fromJson(json['description']),
    );
  }
}

class TypeEstimated {
  final String category;
  final int beds;
  final String bedType;

  TypeEstimated({
    required this.category,
    required this.beds,
    required this.bedType,
  });

  factory TypeEstimated.fromJson(Map<String, dynamic> json) {
    return TypeEstimated(
      category: json['category'] ?? '',
      beds: json['beds'] ?? 0,
      bedType: json['bedType'] ?? '',
    );
  }
}

class Description {
  final String text;
  final String lang;

  Description({
    required this.text,
    required this.lang,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      text: json['text'] ?? '',
      lang: json['lang'] ?? '',
    );
  }
}

class Guests {
  final int adults;

  Guests({
    required this.adults,
  });

  factory Guests.fromJson(Map<String, dynamic> json) {
    return Guests(
      adults: json['adults'] ?? 0,
    );
  }
}

class Price {
  final String currency;
  final String base;
  final String total;
  final Variations variations;

  Price({
    required this.currency,
    required this.base,
    required this.total,
    required this.variations,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      currency: json['currency'] ?? '',
      base: json['base'] ?? '',
      total: json['total'] ?? '',
      variations: Variations.fromJson(json['variations']),
    );
  }
}

class Variations {
  final Average average;
  final List<Change> changes;

  Variations({
    required this.average,
    required this.changes,
  });

  factory Variations.fromJson(Map<String, dynamic> json) {
    return Variations(
      average: Average.fromJson(json['average']),
      changes:
          (json['changes'] as List).map((x) => Change.fromJson(x)).toList(),
    );
  }
}

class Average {
  final String base;

  Average({
    required this.base,
  });

  factory Average.fromJson(Map<String, dynamic> json) {
    return Average(
      base: json['base'] ?? '',
    );
  }
}

class Change {
  final String startDate;
  final String endDate;
  final String base;

  Change({
    required this.startDate,
    required this.endDate,
    required this.base,
  });

  factory Change.fromJson(Map<String, dynamic> json) {
    return Change(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      base: json['base'] ?? '',
    );
  }
}

class Policies {
  final List<Cancellation> cancellations;
  final String paymentType;

  Policies({
    required this.cancellations,
    required this.paymentType,
  });

  factory Policies.fromJson(Map<String, dynamic> json) {
    return Policies(
      cancellations: (json['cancellations'] as List)
          .map((x) => Cancellation.fromJson(x))
          .toList(),
      paymentType: json['paymentType'] ?? '',
    );
  }
}

class Cancellation {
  final int numberOfNights;
  final String deadline;
  final String amount;

  Cancellation({
    required this.numberOfNights,
    required this.deadline,
    required this.amount,
  });

  factory Cancellation.fromJson(Map<String, dynamic> json) {
    return Cancellation(
      numberOfNights: json['numberOfNights'] ?? 0,
      deadline: json['deadline'] ?? '',
      amount: json['amount'] ?? '',
    );
  }
}
