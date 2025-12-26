const std = @import("std");
pub const HighScores = struct {
    buffer: []const i32,

    pub fn init(scores: []const i32) HighScores {
        return HighScores{ .buffer = scores };
    }

    pub fn latest(self: *const HighScores) ?i32 {
        if (self.buffer.len == 0)
            return null;
        return self.buffer[self.buffer.len - 1];
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        const best_three = self.personalTopThree();
        if (best_three.len == 0)
            return null;
        return best_three[0];
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        var best: []i32 = .{0} ** 3;
        return self.buffer;
    }
};
