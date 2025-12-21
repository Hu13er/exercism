const std = @import("std");
const mem = std.mem;

const nil = @as(void, undefined);
pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var set = std.AutoHashMap(u64, void).init(allocator);
    defer set.deinit();
    for (factors) |f| {
        for (1..limit) |i| {
            const mult = @as(u64, i) * f;
            if (mult >= limit)
                break;
            try set.put(mult, nil);
        }
    }
    var result: u64 = 0;
    var it = set.keyIterator();
    while (it.next()) |mult|
        result += mult.*;
    return result;
}
