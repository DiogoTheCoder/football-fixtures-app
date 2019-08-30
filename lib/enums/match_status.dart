enum MatchStatus {
  SCHEDULED,
  POSTPONED,
  CANCELLED,
  SUSPENDED,
  IN_PLAY,
  PAUSED,
  FINISHED,
  AWARDED
}

bool isMatchOver(MatchStatus status) {
  return status == MatchStatus.FINISHED || status == MatchStatus.AWARDED;
}

bool isMatchInPlay(MatchStatus status) {
  return status == MatchStatus.IN_PLAY || status == MatchStatus.PAUSED;
}