`include "defines.v"

module pc (
    input [7:0] step_size,
    input [`XLEN-1:0] set_pc_value,
    input set_pc,
    input clk,
    input rstn,
    output [`XLEN-1:0] pc_value
);

    reg [`XLEN-1:0] pc;

    assign pc_value = pc;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            pc <= 'b0;
        end
        else begin 
            if (set_pc) begin
                pc <= set_pc_value;
            end
            else begin
                pc <= pc + step_size;
            end
        end
    end

endmodule
