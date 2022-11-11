import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv/tv_result_model.dart';

class TvResponse extends Equatable {
  const TvResponse({
    this.results = const [],
  });

  final List<TvResultModel> results;

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        results: List<TvResultModel>.from(
            json["results"].map((x) => TvResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [results];
}
