`include "./defines.v"

module memory_interface (
    input [`XLEN-1:0] addr,
    input [1:0] rw_size,
    input read,
    input write,
    input memclk,
    input rstn,
    input [7:0] write_data [3:0],
    output reg [7:0] read_data [3:0],

    output [`XLEN-2:0] sram_addr,
    output reg [3:0] sram_read,
    output reg [3:0] sram_write,
    inout [7:0] sram_data [3:0]
);

    reg [1:0] i;
    reg sram_inout_data_out;
    reg [7:0] sram_data_out_buffer [3:0];
    
    assign sram_addr = addr[`XLEN-1:2];
    assign sram_data[3:0] = sram_inout_data_out ? sram_data_out_buffer[3:0] : '{8'bz, 8'bz, 8'bz, 8'bz};

    reg last_read;
    reg [`XLEN-1:0] last_addr;
    reg [1:0] last_rw_size;

    always @(posedge memclk) begin
        if (!rstn) begin
            read_data[3:0] <= '{8'b0, 8'b0, 8'b0, 8'b0};
            sram_read[3:0] <= '{0, 0, 0, 0};
            sram_write[3:0] <= '{0, 0, 0, 0};
            sram_inout_data_out <= 0;
            sram_inout_data_out[3:0] <= '{8'b0, 8'b0, 8'b0, 8'b0};
            last_read <= 0;
        end
        else begin
            if (last_read) begin
                case (last_rw_size)
                    sram_inout_data_out <= 0;
                    2'b01: begin
                        read_data[0] <= sram_data[addr[1:0]];
                    end
                    2'b10: begin
                        read_data[0] <= sram_data[addr[1:0]];
                        read_data[1] <= sram_data[addr[1:0]+1];
                    end
                    default: begin
                        read_data[3:0] <= sram_data[3:0];
                    end
                endcase
            end

            last_addr <= addr;
            last_rw_size <= rw_size;

            if (read)
                sram_write[3:0] <= '{0, 0, 0, 0};
                last_read <= 1;
                last_write <= 0;
                case (rw_size)
                    2'b01: begin
                        for (i = 0; i < 4; i = i+1) begin
                            if (i == addr[1:0]) begin
                                sram_read[i] <= 1;
                            end
                            else begin
                                sram_read[i] <= 0;
                            end
                        end
                    end
                    2'b10: begin
                        if (i == addr[1:0] || i == addr[1:0]+1) begin
                            sram_read[i] <= 1;
                        end
                        else begin
                            sram_read[i] <= 0;
                        end
                    end
                    default: begin
                        sram_read[3:0] <= '{1, 1, 1, 1};
                    end
                endcase
            end
            else if (write) begin
                sram_read[3:0] <= '{0, 0, 0, 0};
                last_read <= 0;
                last_write <= 1;
                sram_inout_data_out <= 0;
                case (rw_size)
                    2'b01: begin
                        for (i = 0; i < 4; i = i+1) begin
                            if (i == addr[1:0]) begin
                                sram_write[i] <= 1;
                            end
                            else begin
                                sram_write[i] <= 0;
                            end
                        end
                        sram_data[addr[1:0]] <= write_data[0];
                    end
                    2'b10: begin
                        if (i == addr[1:0] || i == addr[1:0]+1) begin
                            sram_write[i] <= 1;
                        end
                        else begin
                            sram_write[i] <= 0;
                        end
                        sram_data[addr[1:0]] <= write_data[0];
                        sram_data[addr[1:0]+1] <= write_data[1];
                    end
                    default: begin
                        sram_write[3:0] <= '{1, 1, 1, 1};
                        sram_data[3:0] <= write_data[3:0];
                    end
                endcase
            end
            else begin
                sram_read[3:0] <= '{0, 0, 0, 0};
                sram_write[3:0] <= '{0, 0, 0, 0};
                last_read <= 0;
                last_write <= 0;
            end
        end
    end

    always @(posedge clk) begin
    end

endmodule
