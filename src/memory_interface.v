`include "./defines.v"

module memory_interface (
    input [`XLEN-1:0] addr,
    input [1:0] rw_size,
    input read,
    input write,
    input memclk,
    input rstn,
    input [7:0] write_data [3:0],
    output [7:0] read_data [3:0],

    output [`XLEN-2:0] sram_addr,
    output [3:0] sram_read,
    output [3:0] sram_write,
    inout [7:0] sram_data [3:0]
);

    reg [7:0] sram_read_buffer [3:0];
    
    assign sram_addr = addr[`XLEN-1:2];

    always @(posedge memclk) begin
        if (!rstn) begin
        end
        else begin
            sram_read[0] <= 0;
            sram_read[1] <= 0;
            sram_read[2] <= 0;
            sram_read[3] <= 0;
            sram_write[0] <= 0;
            sram_write[1] <= 0;
            sram_write[2] <= 0;
            sram_write[3] <= 0;
            if (read)
                case (rw_size)
                    2'b00: begin
                        sram_read[addr[1:0]] <= 1;
                    end
                    2'b01: begin
                        sram_read[addr[1:0]] <= 1;
                        sram_read[addr[1:0]+1] <= 1;
                    end
                    default: begin
                        sram_read[0] <= 1;
                        sram_read[1] <= 1;
                        sram_read[2] <= 1;
                        sram_read[3] <= 1;
                    end
                endcase
            end
            else if (write) begin
                sram_read <= 0;
                sram_write <= 1;
                case (rw_size)
                    2'b00: begin
                        sram_write[addr[1:0]] <= 1;
                    end
                    2'b01: begin
                        sram_write[addr[1:0]] <= 1;
                        sram_write[addr[1:0]+1] <= 1;
                    end
                    default: begin
                        sram_write[0] <= 1;
                        sram_write[1] <= 1;
                        sram_write[2] <= 1;
                        sram_write[3] <= 1;
                    end
                endcase
            end
        end
    end

    always @(posedge clk) begin
    end

endmodule
