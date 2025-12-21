const std = @import("std");
const pow = std.math.powi;

pub fn isArmstrongNumber(num: u128) bool {
    const num_digits = blk: {
        var temp = num;
        var count: usize = 0;
        while (temp > 0) : (count += 1)
            temp /= 10;
        break :blk count;
    };
    var sum: u128 = 0;
    var temp = num;
    while (temp > 0) : (temp /= 10)
        sum += pow(u128, temp % 10, num_digits) catch unreachable;
    return sum == num;
}
