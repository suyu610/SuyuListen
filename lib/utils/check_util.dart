// <normal></normal>
// <error></error>
// <miss></miss>
// <tense><tense>

///
/// 听力检查
///

String checkStr(String originStr, String rightStr) {
  var outputStr = [];
  if (originStr == rightStr) {
    return rightStr;
  } else {
    var originArr = originStr.split(' ');
    var rightArr = rightStr.split(' ');
    // 选一个更长的
    rightArr.asMap().forEach((index, value) => {
          // 未超出
          if (index > originArr.length - 1)
            {outputStr.add("  <miss>" + value + "</miss>")}
          else if (originArr[index] == value)
            {outputStr.add("  <normal>" + value + "</normal>")}
          else
            {outputStr.add("  <error>" + originArr[index] + "</error>")}
        });
    return outputStr.join('');
  }
}

// 去掉多余的空格，标点
String myTrim(String oldStr) {
  oldStr = oldStr.trim();
  // 去除多余的空格
  RegExp re = new RegExp(r"(,|')+[。.?!]*\s*");

  oldStr = oldStr.replaceAll(re, " ");
  oldStr = oldStr.replaceAll(new RegExp("\\s{2,}"), " ");
  return oldStr;
}
