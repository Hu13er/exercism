pub fn eggCount(number: usize) usize {
    var count: usize = 0;
    var mut_number = number;
    while (mut_number > 0) : (mut_number >>= 1) {
        if (mut_number % 2 == 1)
            count += 1;
    }
    return count;
}
