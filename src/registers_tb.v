`timescale 1ns/1ps
`include "./defines.v"

module registers_tb();
    reg [4:0] write_addr;
    reg [4:0] read_addr;
    reg write;
    reg clk;
    reg rstn;
    reg [`XLEN-1:0] write_data;
    wire [`XLEN-1:0] read_data;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, registers_tb);
        write_addr = 0;
        write_data = 0;
        write = 0;
        clk = 0;
        rstn = 1;

        for (reg [5:0] i = 0; i < 32; i = i+1) begin
            read_addr = i[4:0];
            $display("%d: %h", read_addr, read_data);
        end

        $display("");

        rstn = 0;
        #10 rstn = 1;

        for (reg [5:0] i = 0; i < 32; i = i+1) begin
            read_addr = i[4:0];
            $display("%d: %h", read_addr, read_data);
        end

        $display("");

        write_data = 32'h12345678;
        for (reg [5:0] i = 0; i < 32; i = i+1) begin
            write_addr = i[4:0];
            read_addr = i[4:0];
            write = 1;
            #10 clk = 1;
            #10 write = 0;
            #10 clk = 0;
            $display("%d: %h", write_addr, read_data);
        end

        $stop;
    end

    registers registers_u (
        .write_addr (write_addr),
        .read_addr (read_addr),
        .write (write),
        .clk (clk),
        .rstn (rstn),
        .write_data (write_data),
        .read_data (read_data)
    );

endmodule
