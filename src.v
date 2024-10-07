module Add(

    input       [31:0]          a,

    input       [31:0]          b,

    output reg  [31:0]          sum

);

    reg[32:0] carry = 32'b0;

    integer i;

    always @(*) begin

        for (i = 0; i < 32; i = i + 1) begin

        {carry[i+1], sum[i]} = a[i] + b[i] + carry[i];

        end

    end

    

endmodule