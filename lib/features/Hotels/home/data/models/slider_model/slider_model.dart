import 'datum.dart';

class SliderModel {
  String? message;
  List<Datum>? data;
  List<dynamic>? errors;
  int? state;
  bool? success;
  dynamic pagination;

  SliderModel({
    this.message,
    this.data,
    this.errors,
    this.state,
    this.success,
    this.pagination,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
        errors: json['errors'] as List<dynamic>?,
        state: json['state'] as int?,
        success: json['success'] as bool?,
        pagination: json['pagination'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
        'errors': errors,
        'state': state,
        'success': success,
        'pagination': pagination,
      };
}
