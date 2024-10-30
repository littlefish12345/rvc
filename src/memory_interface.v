`include "./defines.v"

module memory_interface (
    input [`XLEN-1:0] addr,
    input [1:0] rw_size,
    input read,
    input write,
    input clk,
    input rstn,
    input [31:0] write_data,
    output [31:0] read_data,

    output [`XLEN-2:0] sram_addr,
    output [3:0] sram_read,
    output [3:0] sram_write,
    inout [7:0] sram_data [3:0]
);

    reg [7:0] sram_read_buffer [3:0];
    assign 
    
    assign sram_addr = addr[`XLEN-1:2];

    always @(negedge clk) begin
        if (!rstn) begin
        end
        else begin
            case (rw_size)
                2'b00: begin
                    assign 
                end
                2'b01: begin
                end
                2'b10: begin
                end
                2'b11: begin
                end
            endcase
        end
    end

    always @(posedge clk) begin
    end

endmodule
