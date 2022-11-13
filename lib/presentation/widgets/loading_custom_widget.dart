import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:flutter/material.dart';

class LoadingCustomWidget extends StatelessWidget {
  const LoadingCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: kPrimaryColor,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
