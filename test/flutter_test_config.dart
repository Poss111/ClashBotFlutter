import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'widget/threshold_golden_comparator.dart';

const _kGoldenTestsThreshold = 0.5 / 100;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  if (goldenFileComparator is LocalFileComparator) {
    final testUrl = (goldenFileComparator as LocalFileComparator).basedir;

    goldenFileComparator = ThresholdGoldenComparator(
      Uri.parse('$testUrl/test.dart'),
      _kGoldenTestsThreshold,
    );
  } else {
    throw Exception(
      'Expected `goldenFileComparator` to be of type `LocalFileComparator`, '
      'but it is of type `${goldenFileComparator.runtimeType}`',
    );
  }

  await testMain();
}