// zig build-lib hash.zig -dynamic

const std = @import("std");
const stdout = &std.io.getStdOut().outStream().stream;
const Md5 = std.crypto.Md5;

export fn hash(in: [32]u8, in_len: u32, out: *[16]u8) void {
    var buff: [32]u8 = in;

    Md5.hash(buff[0..in_len], out[0..]);
    var result = std.fmt.bufPrint(buff[0..], "{x}", .{out});

    var i: u32 = 0;

    while (i < 2016) {
        Md5.hash(buff[0..], out[0..]);
        var result2 = std.fmt.bufPrint(buff[0..], "{x}", .{out});

        i += 1;
    }
}
