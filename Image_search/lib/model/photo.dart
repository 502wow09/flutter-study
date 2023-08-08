import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

//아래 명시된 파일 하나 생성한다는 의미
part 'photo.g.dart';

@JsonSerializable()
class Photo extends Equatable {
  final int id;
  final String tags;

  //api의 field name이 이상하게 되어있으면 재정의 가능
  @JsonKey(name: 'largeImageURL')
  final String largeImageUrl;

  const Photo({
    required this.id,
    required this.tags,
    required this.largeImageUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Photo toJson() => _$PhotoFromJson(this as Map<String, dynamic>);

  @override
  List<Object?> get props => [id];
}
