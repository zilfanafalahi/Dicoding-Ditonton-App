import 'package:tv/tv.dart';

const testTv = Tv(
  id: 37854,
  backdropPath: "/mBxsapX4DNhH1XkOlLp15He5sxL.jpg",
  posterPath: "/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
  name: "One Piece",
  voteAverage: 8.7,
  firstAirDate: "1999-10-20",
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: "Overview",
  posterPath: "/poster_path.jpg",
  firstAirDate: "2022-10-25",
  episodeRunTime: [90],
  name: "Name",
  voteAverage: 8.5,
  seasons: [
    TvSeason(
      airDate: "2022-10-25",
      episodeCount: 1,
      id: 1,
      name: "Name",
      posterPath: "/poster_path.jpg",
      seasonNumber: 1,
    )
  ],
);
const testWatchlistTv = Tv.watchlist(
  id: 1,
  posterPath: "/poster_path.jpg",
  name: "Name",
  voteAverage: 8.5,
  firstAirDate: "2022-10-25",
);

const testTvTable = TvTable(
  id: 1,
  posterPath: "/poster_path.jpg",
  name: "Name",
  voteAverage: 8.5,
  firstAirDate: "2022-10-25",
);

const testTvSeasonDetail = TvSeasonDetail(
  id: 1,
  seasonNumber: 1,
  name: "Name",
  episodes: [
    TvEpisode(
      id: 1,
      episodeNumber: 1,
      seasonNumber: 1,
      name: "Name",
      overview: "Overview",
      stillPath: "/still_path.jpg",
      voteAverage: 8.5,
      airDate: "2022-10-25",
      runtime: 90,
    )
  ],
);

final testTvMap = {
  "id": 1,
  "posterPath": "/poster_path.jpg",
  "name": "Name",
  "voteAverage": 8.5,
  "firstAirDate": "2022-10-25",
};
