`include "./defines.v"

module bus_controller(
    input clk,
    input memclk,
    input rstn,

    input [`XLEN-1:0] if_stage_address,
    input [1:0] if_stage_data_size,
    input if_stage_request,
    output reg [7:0] if_stage_read_data [3:0],
    output reg if_stage_done,

    input [`XLEN-1:0] mem_stage_address,
    input [1:0] mem_stage_data_size,
    input mem_stage_request,
    input mem_stage_rw, //0=read, 1=write
    input [7:0] mem_stage_write_data [3:0],
    output reg [7:0] mem_stage_read_data [3:0],
    output reg mem_stage_done
);

    reg [7:0] i;

    always @(posedge menclk or negedge rstn) begin
        if (!rstn) begin
            if_stage_done <= 0;
            mem_stage_done <= 0;
            for (i = 0; i < 4; i = i+1) begin
                if_stage_data[i] <= 0;
                mem_stage_read_data[i] <= 0;
            end
        end
        else begin
            if ()
        end
    end

    always @(negedge if_stage_request) begin
        if_stage_done = 0;
    end
    
    always @(negedge mem_stage_request) begin
        mem_stage_done = 0;
    end

endmodule
