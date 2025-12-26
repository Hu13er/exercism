const std = @import("std");
const mem = std.mem;
const math = std.math;
const assert = std.debug.assert;

pub const ColorBand = enum(usize) {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
};

pub fn label(allocator: mem.Allocator, colors: []const ColorBand) mem.Allocator.Error![]u8 {
    assert(colors.len >= 2);
    const digit1 = @intFromEnum(colors[0]);
    const digit2 = @intFromEnum(colors[1]);
    const value = @as(f32, @floatFromInt(digit1 * 10 + digit2));
    return switch (if (colors.len >= 3) colors[2] else ColorBand.black) {
        .black => std.fmt.allocPrint(allocator, "{d:.0} ohms", .{value}),
        .brown => std.fmt.allocPrint(allocator, "{d:.0} ohms", .{value * 10}),
        .red => if (digit2 == 0)
            std.fmt.allocPrint(allocator, "{d:.0} kiloohms", .{digit1})
        else
            std.fmt.allocPrint(allocator, "{d:.1} kiloohms", .{value / 10.0}),
        .orange => std.fmt.allocPrint(allocator, "{d:.0} kiloohms", .{value}),
        .yellow => std.fmt.allocPrint(allocator, "{d:.0} kiloohms", .{value * 10}),
        .green => if (digit2 == 0)
            std.fmt.allocPrint(allocator, "{d:.0} megaohms", .{digit1})
        else
            std.fmt.allocPrint(allocator, "{d:.1} megaohms", .{value / 10.0}),
        .blue => std.fmt.allocPrint(allocator, "{d:.0} megaohms", .{value}),
        .violet => std.fmt.allocPrint(allocator, "{d:.0} megaohms", .{value * 10}),
        .grey => if (digit2 == 0)
            std.fmt.allocPrint(allocator, "{d:.0} gigaohms", .{digit1})
        else
            std.fmt.allocPrint(allocator, "{d:.1} gigaohms", .{value / 10.0}),
        .white => std.fmt.allocPrint(allocator, "{d:.0} gigaohms", .{value}),
    };
}
