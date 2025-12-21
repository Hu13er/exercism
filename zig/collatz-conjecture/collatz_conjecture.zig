pub const ComputationError = error{IllegalArgument};
pub fn steps(number: usize) anyerror!usize {
    if (number == 0) return ComputationError.IllegalArgument;
    if (number == 1) return 0;
    return 1 + if (number % 2 == 0) try steps(number / 2) else try steps(number * 3 + 1);
}
