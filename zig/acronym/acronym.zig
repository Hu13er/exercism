const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var splitter = mem.splitAny(u8, words, "- ");
    var result = try std.ArrayList(u8).initCapacity(allocator, 4);
    while (splitter.next()) |word| {
        const first = for (word) |ch| {
            if (std.ascii.isAlphabetic(ch)) break ch;
        } else null;
        if (first) |f| try result.append(allocator, std.ascii.toUpper(f));
    }
    return result.toOwnedSlice(allocator);
}
