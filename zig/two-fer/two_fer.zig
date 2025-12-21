const fmt = @import("std").fmt;
pub fn twoFer(buffer: []u8, name: ?[]const u8) ![]u8 {
    return fmt.bufPrint(buffer, "One for {s}, one for me.", .{name orelse "you"});
}
