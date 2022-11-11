import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CardGridWidget extends StatelessWidget {
  final int id;
  final String posterPath;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final Function() onTap;

  const CardGridWidget({
    super.key,
    required this.id,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kAccentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              posterPath.isNotEmpty
                  ? Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kPrimaryColor,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
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
                      width: double.infinity,
                      height: 180,
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
              const SizedBox(
                height: 2,
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
