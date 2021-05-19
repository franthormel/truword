enum TimeLimit {
  long,
  regular,
  quick,
}

const timeLimitSeconds = {
  TimeLimit.long: 120,
  TimeLimit.regular: 60,
  TimeLimit.quick: 30,
};