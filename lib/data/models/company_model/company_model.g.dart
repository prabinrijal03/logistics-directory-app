// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      name: json['name'] as String,
      serviceType: json['serviceType'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      rating: (json['rating'] as num).toDouble(),
      isFeatured: json['isFeatured'] as bool?,
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'serviceType': instance.serviceType,
      'location': instance.location,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'rating': instance.rating,
      'isFeatured': instance.isFeatured,
    };
