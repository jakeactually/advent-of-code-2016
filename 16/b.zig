const std = @import("std");
const stdout = &std.io.getStdOut().outStream().stream;
const disk_size = 35651584;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;

    var buff = try allocator.create([disk_size]u8);
    const input = [_]u8{ 0,1,0,0,0,1,0,0,0,1,0,0,1,0,1,1,1 };    
    std.mem.copy(u8, buff[0..], input[0..]);

    fill(buff, input.len);
    const len = checksum(buff, disk_size);

    for (buff[0..len]) |bit| {
        try stdout.print("{}", .{ bit });
    }

    try stdout.print("\n", .{});
}

fn fill(buff: *[disk_size]u8, initial_len: u32) void {
    var len = initial_len;

    while (len < disk_size) {
        var new_len = len * 2;

        var i: u32 = 0;
        while (i < len) {
            if (new_len - i < disk_size)            
                buff[new_len - i] = ~buff[i] & 1;

            i += 1;
        }

        len = new_len + 1;
    }
}

fn checksum(buff: *[disk_size]u8, initial_len: u32) u32 {
    var len = initial_len;

    while (len % 2 == 0) {
        const half = len / 2;
        
        for (buff[0..half]) |_, i| {
            buff[i] = ~(buff[i * 2] ^ buff[i * 2 + 1]) & 1;
        }

        len = half;
    }

    return len;
}
