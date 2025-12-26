const std = @import("std");
pub const HighScores = struct {
    top_3: [3]i32,
    last: ?i32,

    pub fn init(scores: []const i32) HighScores {
        var result = HighScores{
            .top_3 = @splat(-1),
            .last = if (scores.len > 0) scores[scores.len - 1] else null,
        };
        for (scores) |score| {
            if (result.top_3[0] < score) {
                result.top_3[2] = result.top_3[1];
                result.top_3[1] = result.top_3[0];
                result.top_3[0] = score;
            } else if (result.top_3[1] < score) {
                result.top_3[2] = result.top_3[1];
                result.top_3[1] = score;
            } else if (result.top_3[2] < score) {
                result.top_3[2] = score;
            }
        }
        return result;
    }

    pub fn latest(self: *const HighScores) ?i32 {
        return self.last;
    }

    pub fn personalBest(self: *const HighScores) ?i32 {
        return if (self.top_3[0] >= 0) self.top_3[0] else null;
    }

    pub fn personalTopThree(self: *const HighScores) []const i32 {
        const size = for (self.top_3, 1..) |v, i| {
            if (v < 0) break i - 1;
        } else 3;
        return self.top_3[0..size];
    }
};
