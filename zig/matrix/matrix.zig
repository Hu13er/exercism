const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

pub const Error = error{
    RaggedMatrix,
    EmptyMatrix,
    OutOfRange,
} || mem.Allocator.Error;

/// Returns the selected row of the matrix.
pub fn row(allocator: mem.Allocator, s: []const u8, index: i32) Error![]i16 {
    var row_idx: i32 = 0;
    var rows_it = mem.tokenizeScalar(u8, s, '\n');
    while (rows_it.next()) |current_row| {
        row_idx += 1;
        if (row_idx != index)
            continue;
        var result = try std.ArrayList(i16).initCapacity(allocator, 4);
        errdefer result.deinit(allocator);
        var elements_it = mem.tokenizeScalar(u8, current_row, ' ');
        while (elements_it.next()) |elem| {
            result.append(allocator, item: i16)
        }
    }
    return result.toOwnedSlice(allocator);
}

/// Returns the selected column of the matrix.
pub fn column(allocator: mem.Allocator, s: []const u8, index: i32) Error![]i16 {
    var result = try std.ArrayList(i16).initCapacity(allocator, 4);
    defer result.deinit(allocator);

    return result.toOwnedSlice(allocator);
}
