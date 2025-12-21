pub fn squareOfSum(number: usize) usize {
    var sum: usize = 0;
    for (1..number + 1) |i| sum += i;
    return sum * sum;
}

pub fn sumOfSquares(number: usize) usize {
    var sum: usize = 0;
    for (1..number + 1) |i| sum += i * i;
    return sum;
}

pub fn differenceOfSquares(number: usize) usize {
    const ss2 = sumOfSquares(number);
    const s2s = squareOfSum(number);
    return if (ss2 > s2s) ss2 - s2s else s2s - ss2;
}
