module Add4(
    input  [3:0]               a,
    input  [3:0]               b,
    input                      ci,
    output  [3:0]              sum,
    output                     co
);
    wire [3:0] p = a ^ b;
    wire [3:0] g = a & b;
    wire [3:0] c;
    assign c[0] = ci;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    assign co = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c[0]);
    assign sum = p ^ c;
endmodule

module Add16(
    input  [15:0]               a,
    input  [15:0]               b,
    input                       ci,
    output  [15:0]              sum,
    output                      co
);
    wire [3:0] c;
    assign c[0] = ci;
    Add4 add4_0(
        .a(a[3:0]),
        .b(b[3:0]),
        .ci(c[0]),
        .sum(sum[3:0]),
        .co(c[1])
    );
    Add4 add4_1(
        .a(a[7:4]),
        .b(b[7:4]),
        .ci(c[1]),
        .sum(sum[7:4]),
        .co(c[2])
    );
    Add4 add4_2(
        .a(a[11:8]),
        .b(b[11:8]),
        .ci(c[2]),
        .sum(sum[11:8]),
        .co(c[3])
    );
    Add4 add4_3(
        .a(a[15:12]),
        .b(b[15:12]),
        .ci(c[3]),
        .sum(sum[15:12]),
        .co(co)
    );
endmodule

module Add(
    input [31:0]               a,
    input [31:0]               b,
    output [31:0]              sum
);
    wire tmp;
    wire [15:0] sum0, sum1;
    Add16 add16_0(
        .a(a[15:0]),
        .b(b[15:0]),
        .ci(1'b0),
        .sum(sum[15:0]),
        .co(tmp)
    );
    Add16 add16_1(
        .a(a[31:16]),
        .b(b[31:16]),
        .ci(tmp),
        .sum(sum[31:16])
        .co()
    );
endmodule
