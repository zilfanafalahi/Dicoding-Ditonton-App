import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:flutter/material.dart';

class ErrorCustomWidget extends StatelessWidget {
  final String message;

  const ErrorCustomWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: kTextTheme.caption!.apply(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
