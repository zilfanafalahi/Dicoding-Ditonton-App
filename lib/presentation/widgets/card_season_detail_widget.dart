import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/show_duration.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:readmore/readmore.dart';

class CardSeasonDetailWidget extends StatelessWidget {
  final int id;
  final int seasonNumber;
  final String stillPath;
  final int episodeNumber;
  final String name;
  final String airDate;
  final int runtime;
  final String overview;
  final double voteAverage;

  const CardSeasonDetailWidget({
    super.key,
    required this.id,
    required this.seasonNumber,
    required this.stillPath,
    required this.episodeNumber,
    required this.name,
    required this.airDate,
    required this.runtime,
    required this.overview,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            stillPath.isNotEmpty
                ? Container(
                    width: double.infinity,
                    height: 180,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: kPrimaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: "$baseImageUrl$stillPath",
                        placeholder: (context, url) {
                          return const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: kWhiteColor,
                                strokeWidth: 2.0,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Padding(
                            padding: const EdgeInsets.all(42),
                            child: Image.asset(
                              "assets/circle-g.png",
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 180,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: kPrimaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(42),
                      child: Image.asset(
                        "assets/circle-g.png",
                      ),
                    ),
                  ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: kPrimaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            IconlyLight.star,
                            color: kWhiteColor,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            (voteAverage / 2).toStringAsFixed(1),
                            style: kTextTheme.caption!.apply(
                              color: kWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Episode $episodeNumber. $name",
                    style: kTextTheme.subtitle1!.apply(
                      color: kPrimaryColor,
                      fontWeightDelta: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${airDate.split('-')[0]}  |  ${showDuration(runtime)}",
                    style: kTextTheme.subtitle2!.apply(
                      color: kGreyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Overview",
                    style: kTextTheme.subtitle2!.apply(
                      color: kPrimaryColor,
                      fontWeightDelta: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  overview.isNotEmpty
                      ? ReadMoreText(
                          overview,
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'show more',
                          trimExpandedText: 'show less',
                          style: kTextTheme.bodyText2!.copyWith(
                            color: kPrimaryColor,
                          ),
                          moreStyle: kTextTheme.bodyText2!.copyWith(
                            color: kSecondaryColor,
                          ),
                          lessStyle: kTextTheme.bodyText2!.copyWith(
                            color: kSecondaryColor,
                          ),
                        )
                      : Center(
                          child: Text(
                            "Data not available",
                            style: kTextTheme.caption!.apply(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
