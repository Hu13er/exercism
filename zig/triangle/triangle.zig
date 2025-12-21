pub const TriangleError = error{Invalid};

pub const Triangle = struct {
    a: f64,
    b: f64,
    c: f64,

    pub fn init(a: f64, b: f64, c: f64) TriangleError!Triangle {
        try assert(a != 0);
        try assert(b != 0);
        try assert(c != 0);
        try assert(a <= b + c);
        try assert(b <= a + c);
        try assert(c <= a + b);
        return Triangle{ .a = a, .b = b, .c = c };
    }

    pub fn isEquilateral(self: Triangle) bool {
        return self.a == self.b and self.b == self.c;
    }

    pub fn isIsosceles(self: Triangle) bool {
        if (self.a == self.b) return true;
        if (self.b == self.c) return true;
        if (self.c == self.a) return true;
        return false;
    }

    pub fn isScalene(self: Triangle) bool {
        return !self.isIsosceles();
    }

    fn assert(cond: bool) TriangleError!void {
        return if (!cond) return TriangleError.Invalid else undefined;
    }
};
