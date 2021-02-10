import 'package:SuyuListening/utils/check_util.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('lrc util', () {


  });
  test('checkStr function', () {
    var originStr = "hello";
    var rightStr = "hello my name is";
    expect(
        checkStr(originStr, rightStr),
        equals(
            "  <normal>hello</normal>  <miss>my</miss>  <miss>name</miss>  <miss>is</miss>"));
  });

  test('check error function', () {
    var originStr = "hello miss";
    var rightStr = "hello my name is";
    expect(
        checkStr(originStr, rightStr),
        equals(
            "  <normal>hello</normal>  <error>miss</error>  <miss>name</miss>  <miss>is</miss>"));
  });

  test('trim function', () {
    var oldStr = "hello! my     name is hpy";
    expect(myTrim(oldStr), equals("hello my name is hpy"));
  });
}
