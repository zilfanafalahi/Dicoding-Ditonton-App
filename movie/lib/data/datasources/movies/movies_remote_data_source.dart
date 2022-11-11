import 'dart:convert';
import 'package:common/common.dart';
import 'package:http/io_client.dart';
import 'package:movie/data/models/movies/movie_detail_response.dart';
import 'package:movie/data/models/movies/movies_response.dart';
import 'package:movie/data/models/movies/movies_result_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MoviesResultModel>> getNowPlayingMovies();
  Future<List<MoviesResultModel>> getPopularMovies();
  Future<List<MoviesResultModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MoviesResultModel>> getMovieRecommendations(int id);
  Future<List<MoviesResultModel>> searchMovies(String query);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final IOClient ioClient;

  MoviesRemoteDataSourceImpl({required this.ioClient});

  @override
  Future<List<MoviesResultModel>> getNowPlayingMovies() async {
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/$id?$apiKey'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesResultModel>> getMovieRecommendations(int id) async {
    final response = await ioClient
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesResultModel>> getPopularMovies() async {
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesResultModel>> getTopRatedMovies() async {
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MoviesResultModel>> searchMovies(String query) async {
    final response = await ioClient
        .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
