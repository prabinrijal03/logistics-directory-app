import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_model.freezed.dart';
part 'ad_model.g.dart';

@freezed
class Ad with _$Ad {
  const factory Ad({
    required String id,
    required String position, 
    required String imageUrl,
  }) = _Ad;

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);
}
