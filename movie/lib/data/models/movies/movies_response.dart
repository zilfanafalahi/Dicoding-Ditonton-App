import 'package:equatable/equatable.dart';
import 'package:movie/data/models/movies/movies_result_model.dart';

class MoviesResponse extends Equatable {
  const MoviesResponse({
    this.results = const [],
  });

  final List<MoviesResultModel> results;

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
        results: List<MoviesResultModel>.from(
            json["results"].map((x) => MoviesResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [results];
}
