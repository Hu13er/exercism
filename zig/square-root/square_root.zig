pub fn squareRoot(radicand: usize) usize {
    var from: usize = 1;
    var to: usize = radicand;
    return while (true) {
        const pivot = (from + to) / 2;
        const pow = pivot * pivot;
        if (pow == radicand) break pivot;
        if (pow < radicand) {
            from = pivot;
        } else {
            to = pivot;
        }
    };
}
