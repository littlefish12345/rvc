`include "./defines.v"

module memory_controller(
    input [`XLEN-1:0] address,
    input [`XLEN-1:0] write_data [3:0],
    input [1:0] rw_size;
    input clkn,
    input rstn,
    output [`XLEN-1:0] read_data [3:0]
);

    always @(negedge clkn or negedge rstn) begin
        if (!rstn) begin
        end
        else begin
            i
        end
    end

endmodule
