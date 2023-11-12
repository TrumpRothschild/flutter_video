enum RankingDateType {
  day,
  week,
  month,
  total,
}

extension RankingDateTypeHelper on RankingDateType {
  String get title {
    switch (this) {
      case RankingDateType.day:
        return '日榜';
      case RankingDateType.week:
        return '周榜';
      case RankingDateType.month:
        return '月榜';
      case RankingDateType.total:
        return '总榜';
    }
  }
}
