const math = @import("std").math;
pub const Coordinate = struct {
    x: f32,
    y: f32,

    const Circle = enum {
        outside,
        outer,
        middle,
        inner,

        fn find(c: Coordinate) Circle {
            const r = c.rad();
            if (r > 10.0) return .outside;
            if (r > 5.0) return .outer;
            if (r > 1.0) return .middle;
            return .inner;
        }

        fn score(self: Circle) usize {
            return switch (self) {
                .outside => 0,
                .outer => 1,
                .middle => 5,
                .inner => 10,
            };
        }
    };

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{ .x = x_coord, .y = y_coord };
    }

    pub fn score(self: Coordinate) usize {
        return Circle.find(self).score();
    }

    fn rad(self: Coordinate) f32 {
        return math.sqrt(self.x * self.x + self.y * self.y);
    }
};
