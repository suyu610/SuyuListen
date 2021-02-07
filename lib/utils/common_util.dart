// 从一个区间向另一个区间映射

double mapIntervaltoAnother(
    double value, int upper, int lower, int toUpper, int toLower) {
  if (value <= lower) return 0;
  if (value >= upper) return 1;
  // 处在中间
  return value =
      toLower + ((toUpper - toLower) / (upper - lower)) * (value - lower);
}
