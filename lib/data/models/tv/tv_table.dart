import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  const TvTable({
    required this.id,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.firstAirDate,
  });

  final int id;
  final String posterPath;
  final String name;
  final double voteAverage;
  final String firstAirDate;

  factory TvTable.fromJson(Map<String, dynamic> json) => TvTable(
        id: json["id"] ?? 0,
        posterPath: json["posterPath"] ?? "",
        name: json["name"] ?? "",
        voteAverage: json["voteAverage"].toDouble() ?? 0,
        firstAirDate: json["firstAirDate"] ?? "",
      );

  factory TvTable.fromEntity(TvDetail tv) => TvTable(
        id: tv.id,
        posterPath: tv.posterPath,
        name: tv.name,
        voteAverage: tv.voteAverage,
        firstAirDate: tv.firstAirDate,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "posterPath": posterPath,
        "name": name,
        "voteAverage": voteAverage,
        "firstAirDate": firstAirDate,
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        posterPath: posterPath,
        name: name,
        voteAverage: voteAverage,
        firstAirDate: firstAirDate,
      );

  @override
  List<Object?> get props => [
        id,
        posterPath,
        name,
        voteAverage,
        firstAirDate,
      ];
}
