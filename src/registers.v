`include "./defines.v"

module registers (
    input [4:0] write_addr,
    input [4:0] read_addr,
    input write,
    input clk,
    input rstn,
    input [`XLEN-1:0] write_data,
    output [`XLEN-1:0] read_data
);
    reg [`XLEN-1:0] registers [0:31];
    reg [5:0] i;
    
    assign read_data = registers[read_addr];

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 32; i = i+1) begin
                registers[i[4:0]] <= 'b0;
            end
        end
        else begin
            if (write) begin
                if (write_addr != 0) begin
                    registers[write_addr] <= write_data;
                end
            end
        end
    end
endmodule
