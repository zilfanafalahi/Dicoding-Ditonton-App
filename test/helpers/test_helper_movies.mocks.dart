// Mocks generated by Mockito 5.3.2 from annotations
// in dicoding_ditonton_app/test/helpers/test_helper_movies.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i19;
import 'dart:typed_data' as _i20;

import 'package:dartz/dartz.dart' as _i2;
import 'package:dicoding_ditonton_app/common/failure.dart' as _i8;
import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart'
    as _i15;
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_local_data_source.dart'
    as _i13;
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_remote_data_source.dart'
    as _i11;
import 'package:dicoding_ditonton_app/data/models/movies/movie_detail_response.dart'
    as _i3;
import 'package:dicoding_ditonton_app/data/models/movies/movies_result_model.dart'
    as _i12;
import 'package:dicoding_ditonton_app/data/models/movies/movies_table.dart'
    as _i14;
import 'package:dicoding_ditonton_app/data/models/tv/tv_table.dart' as _i17;
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart'
    as _i9;
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart'
    as _i10;
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart'
    as _i6;
import 'package:http/io_client.dart' as _i4;
import 'package:http/src/base_request.dart' as _i18;
import 'package:http/src/response.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i16;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIOStreamedResponse_2 extends _i1.SmartFake
    implements _i4.IOStreamedResponse {
  _FakeIOStreamedResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MoviesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRepository extends _i1.Mock implements _i6.MoviesRepository {
  MockMoviesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.Movies>>(
          this,
          Invocation.method(
            #getNowPlayingMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.Movies>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.Movies>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MoviesDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, _i10.MoviesDetail>>.value(
                _FakeEither_0<_i8.Failure, _i10.MoviesDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i10.MoviesDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.Movies>>(
          this,
          Invocation.method(
            #getMovieRecommendations,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.Movies>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlistMovie(
          _i10.MoviesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlistMovie,
            [movie],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlistMovie(
          _i10.MoviesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlistMovie,
            [movie],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlistMovie(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlistMovie,
          [id],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>.value(
                _FakeEither_0<_i8.Failure, List<_i9.Movies>>(
          this,
          Invocation.method(
            #getWatchlistMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movies>>>);
}

/// A class which mocks [MoviesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRemoteDataSource extends _i1.Mock
    implements _i11.MoviesRemoteDataSource {
  MockMoviesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.MoviesResultModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue: _i7.Future<List<_i12.MoviesResultModel>>.value(
            <_i12.MoviesResultModel>[]),
      ) as _i7.Future<List<_i12.MoviesResultModel>>);
  @override
  _i7.Future<List<_i12.MoviesResultModel>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i7.Future<List<_i12.MoviesResultModel>>.value(
            <_i12.MoviesResultModel>[]),
      ) as _i7.Future<List<_i12.MoviesResultModel>>);
  @override
  _i7.Future<List<_i12.MoviesResultModel>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i7.Future<List<_i12.MoviesResultModel>>.value(
            <_i12.MoviesResultModel>[]),
      ) as _i7.Future<List<_i12.MoviesResultModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i7.Future<_i3.MovieDetailResponse>.value(
            _FakeMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i12.MoviesResultModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue: _i7.Future<List<_i12.MoviesResultModel>>.value(
            <_i12.MoviesResultModel>[]),
      ) as _i7.Future<List<_i12.MoviesResultModel>>);
  @override
  _i7.Future<List<_i12.MoviesResultModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i7.Future<List<_i12.MoviesResultModel>>.value(
            <_i12.MoviesResultModel>[]),
      ) as _i7.Future<List<_i12.MoviesResultModel>>);
}

/// A class which mocks [MoviesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesLocalDataSource extends _i1.Mock
    implements _i13.MoviesLocalDataSource {
  MockMoviesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistMovie(_i14.MoviesTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlistMovie(_i14.MoviesTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i14.MoviesTable?> getMovieById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i7.Future<_i14.MoviesTable?>.value(),
      ) as _i7.Future<_i14.MoviesTable?>);
  @override
  _i7.Future<List<_i14.MoviesTable>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i14.MoviesTable>>.value(<_i14.MoviesTable>[]),
      ) as _i7.Future<List<_i14.MoviesTable>>);
}

/// A class which mocks [DbHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDbHelper extends _i1.Mock implements _i15.DbHelper {
  MockDbHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i16.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i7.Future<_i16.Database?>.value(),
      ) as _i7.Future<_i16.Database?>);
  @override
  _i7.Future<int> insertWatchlistMovie(_i14.MoviesTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistMovie(_i14.MoviesTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i7.Future<Map<String, dynamic>?>.value(),
      ) as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> insertWatchlistTv(_i17.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistTv,
          [tv],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistTv(_i17.TvTable? tv) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTv,
          [tv],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getTvById,
          [id],
        ),
        returnValue: _i7.Future<Map<String, dynamic>?>.value(),
      ) as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i4.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.IOStreamedResponse> send(_i18.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i4.IOStreamedResponse>.value(_FakeIOStreamedResponse_2(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i4.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<_i5.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i19.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i20.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i20.Uint8List>.value(_i20.Uint8List(0)),
      ) as _i7.Future<_i20.Uint8List>);
}
