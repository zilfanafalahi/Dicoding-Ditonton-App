import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CardSeasonWidget extends StatelessWidget {
  final int id;
  final String posterPath;
  final String name;
  final int episodeCount;
  final String airDate;
  final int seasonNumber;
  final Function() onTap;

  const CardSeasonWidget({
    super.key,
    required this.id,
    required this.posterPath,
    required this.name,
    required this.episodeCount,
    required this.airDate,
    required this.seasonNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            posterPath.isNotEmpty
                ? Container(
                    width: 120,
                    height: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      color: kPrimaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: "$baseImageUrl$posterPath",
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
                            padding: const EdgeInsets.all(16),
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
                    width: 120,
                    height: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      color: kPrimaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        "assets/circle-g.png",
                      ),
                    ),
                  ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: 104,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: kTextTheme.subtitle2!.apply(
                      color: kPrimaryColor,
                      fontWeightDelta: 2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    airDate.split("-")[0],
                    style: kTextTheme.caption!.apply(
                      color: kGreyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "$episodeCount Espisode",
                    style: kTextTheme.caption!.apply(
                      color: kGreyColor,
                      fontWeightDelta: 2,
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
