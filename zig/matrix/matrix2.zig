const std = @import("std");
const fmt = std.fmt;
const mem = std.mem;

const Elem = struct {
    row: usize,
    column: usize,
    value: []const u8,
};

const Event = union(enum) {
    elem: Elem,
    row_end: void,
    end: void,
};

fn TableIterator(comptime Validator: type) type {
    return struct {
        col_idx: usize,
        row_idx: usize,
        elem_tokenizer: ?mem.TokenIterator(u8, .scalar),
        row_tokenizer: mem.TokenIterator(u8, .scalar),
        validator: Validator,

        const Self = @This();

        fn init(buffer: []const u8, validator: Validator) Self {
            return Self{
                .row_idx = 0,
                .col_idx = 0,
                .elem_tokenizer = null,
                .row_tokenizer = mem.tokenizeScalar(u8, buffer, '\n'),
                .validator = validator,
            };
        }

        fn next(self: *Self) (Validator.Error)!?Elem {
            while (true) {
                if (self.elem_tokenizer) |*it| {
                    if (it.next()) |elem| {
                        self.col_idx += 1;
                        const e = Elem{
                            .row = self.row_idx,
                            .column = self.col_idx,
                            .value = elem,
                        };
                        try self.validator.onEvent(.{ .elem = e });
                        return e;
                    }
                    try self.validator.onEvent(.row_end);
                }

                self.col_idx = 0;
                self.row_idx += 1;

                if (self.row_tokenizer.next()) |current_row| {
                    self.elem_tokenizer = mem.tokenizeScalar(u8, current_row, ' ');
                } else {
                    try self.validator.onEvent(.end);
                    return null;
                }
            }
        }
    };
}

pub const MatrixValidator = struct {
    expected_cols: usize = 0,
    current_row_cols: usize = 0,
    current_row: usize = 0,

    assert_col_exists: ?usize = null,
    assert_row_exists: ?usize = null,

    pub const Error = error{
        RaggedMatrix,
        EmptyMatrix,
        OutOfRange,
    };

    fn onEvent(self: *MatrixValidator, event: Event) !void {
        switch (event) {
            .elem => |e| {
                self.current_row_cols = e.column;
                self.current_row = e.row;
            },
            .row_end => {
                if (self.expected_cols == 0) {
                    self.expected_cols = self.current_row_cols;
                    if (self.assert_col_exists) |ac| {
                        if (ac > self.expected_cols) return Error.OutOfRange;
                    }
                    if (self.expected_cols == 0) return Error.EmptyMatrix;
                } else {
                    if (self.current_row_cols != self.expected_cols)
                        return Error.RaggedMatrix;
                }
            },
            .end => {
                if (self.assert_row_exists) |ar| {
                    if (ar > self.current_row) return Error.OutOfRange;
                }
            },
        }
    }
};

const NoOpValidator = struct {
    const Error = error{};
    fn onEvent(_: *NoOpValidator, _: Event) !void {}
};

comptime {
    const check_validators = [_]type{ NoOpValidator, MatrixValidator };
    for (check_validators) |V|
        assertValidator(V);
}

fn assertValidator(V: type) void {
    comptime {
        if (!@hasDecl(V, "onEvent"))
            @compileError("Validator must define onElem()");
        if (!@hasDecl(V, "Error"))
            @compileError("Validator must define Error: error{}");
    }
}

/// Returns the selected row of the matrix.
pub fn row(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    var result = try std.ArrayList(i16).initCapacity(allocator, 4);
    defer result.deinit(allocator);
    var it = TableIterator(MatrixValidator).init(s, MatrixValidator{ .assert_row_exists = @intCast(index) });
    while (try it.next()) |elem| {
        if (elem.row != index)
            continue;
        const parsed = try fmt.parseInt(i16, elem.value, 10);
        try result.append(allocator, parsed);
    }
    return result.toOwnedSlice(allocator);
}

/// Returns the selected column of the matrix.
pub fn column(allocator: mem.Allocator, s: []const u8, index: i32) ![]i16 {
    var result = try std.ArrayList(i16).initCapacity(allocator, 4);
    defer result.deinit(allocator);
    var it = TableIterator(MatrixValidator).init(s, MatrixValidator{ .assert_col_exists = @intCast(index) });
    while (try it.next()) |elem| {
        if (elem.column != index)
            continue;
        const parsed = try fmt.parseInt(i16, elem.value, 10);
        try result.append(allocator, parsed);
    }
    return result.toOwnedSlice(allocator);
}
