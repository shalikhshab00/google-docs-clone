import 'package:flutter_test/flutter_test.dart';
import 'package:google_docs/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LoaderModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
