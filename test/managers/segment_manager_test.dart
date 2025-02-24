import 'package:flutter_test/flutter_test.dart';
import 'package:my_runner_game/managers/segment_manager.dart';

void main() {
  test('''
GIVEN the Segment Manager
WHEN initialized 
THEN it should generate 2 default segments
''', () {
    final sut = SegmentManager(); // initializes with 2 default segments

    expect(sut.segments.length, 2); // 3 new segments + 2 default segments
  });

  test('''
GIVEN the Segment Manager
WHEN initialized 
AND generate is called 
THEN it should generate the number of segments passed
''', () {
    final sut = SegmentManager(
        numberOfSegments: 3); // initializes with 2 default segments
    sut.generate();

    expect(sut.segments.length, 3 + 2); // 3 new segments + 2 default segments
  });
}
