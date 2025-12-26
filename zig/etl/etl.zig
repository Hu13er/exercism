const std = @import("std");
const mem = std.mem;

pub fn transform(allocator: mem.Allocator, legacy: std.AutoHashMap(i5, []const u8)) mem.Allocator.Error!std.AutoHashMap(u8, i5) {
    var result = std.AutoHashMap(u8, i5).init(allocator);
    var it = legacy.iterator();
    while (it.next()) |entry|
        for (entry.value_ptr.*) |letter|
            try result.put(std.ascii.toLower(letter), entry.key_ptr.*);
    return result;
}
