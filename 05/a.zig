const std = @import("std");
const stdout = &std.io.getStdOut().outStream().stream;
const Md5 = std.crypto.Md5;

pub fn main() !void {
    var prefix = [_]u8{ 'u', 'q', 'w', 'q', 'e', 'm', 'i', 's',  };
    var in = [_]u8{0} ** 33;
    var outb = [_]u8{0} ** 16;
    var out = [_]u8{0} ** 33;
    var i: u32 = 0;
    var c: u32 = 0;
    var res = [_]u8{0} ** 9;

    while (true) {
        var buf = try std.fmt.bufPrint(in[0..], "{}{}", .{prefix, i});

        var size: usize = 0;
        for (in[0..]) |byte, index| {
            if (byte == 0) {
                size = index;
                break;
            }
        }

        Md5.hash(in[0..size], outb[0..]);

        var buf2 = try std.fmt.bufPrint(out[0..], "{x}", .{outb});

        var valid = 
            out[0] == '0' and
            out[1] == '0' and
            out[2] == '0' and
            out[3] == '0' and
            out[4] == '0';

        if (valid) {
            try stdout.print("{}\n", .{out});
            res[c] = out[5];
            c += 1;
        }

        if (c > 7)
            break;

        i += 1;
    }

    try stdout.print("{}\n", .{res});
}
