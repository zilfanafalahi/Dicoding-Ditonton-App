import 'dart:convert';
import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/exception.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_detail_response.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_response.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_result_model.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_season_detail_response.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvResultModel>> getOnTheAirTv();
  Future<List<TvResultModel>> getPopularTv();
  Future<List<TvResultModel>> getTopRatedTv();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvResultModel>> getTvRecommendations(int id);
  Future<List<TvResultModel>> searchTv(String query);
  Future<TvSeasonDetailResponse> getTvSeasonDetail(int id, int seasonNumber);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvResultModel>> getOnTheAirTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvResultModel>> getTvRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvResultModel>> getPopularTv() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvResultModel>> getTopRatedTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvResultModel>> searchTv(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeasonDetailResponse> getTvSeasonDetail(
      int id, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeasonDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
