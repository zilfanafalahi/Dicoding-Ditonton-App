import 'package:dicoding_ditonton_app/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  const GenreModel({
    this.id = 0,
    this.name = "",
  });

  final int id;
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Genre toEntity() {
    return Genre(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
