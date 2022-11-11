import 'package:common/common.dart';
import 'package:flutter/material.dart';

class DataNotAvailableWidet extends StatelessWidget {
  const DataNotAvailableWidet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Data not available",
        style: kTextTheme.caption!.apply(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
