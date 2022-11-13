import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:flutter/material.dart';

class CardRecommendationWidget extends StatelessWidget {
  final int id;
  final String backdropPath;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final Function() onTap;

  const CardRecommendationWidget({
    super.key,
    required this.id,
    required this.backdropPath,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          backdropPath.isNotEmpty
              ? Container(
                  width: 180,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kPrimaryColor,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "$baseImageUrl$backdropPath",
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
                  width: 180,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
            height: 4,
          ),
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                  releaseDate.split("-")[0],
                  style: kTextTheme.caption!.apply(
                    color: kGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
