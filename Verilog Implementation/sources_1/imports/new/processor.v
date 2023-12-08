`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 01:15:41 PM
// Design Name: 
// Module Name: processor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module processor(
input clk, input reset, input [1:0] ledSel, input [3:0] ssdSel,input SSDclk, 
output reg [15:0] leds, output [6:0] seven_segment_display, output [3:0] anode
    );
    reg [31:0] output_of_inst_mem;
    wire [3:0] alu_cu_input;
    wire [31:0] output_of_PC;
    wire [31:0] output_of_pc_mux;
    wire [31:0] read_data1_output;
    wire [31:0] read_data2_output;
    wire [31:0] output_of_data_memory_mux;
    wire branch_wire;
    wire memread_wire;
    wire memtoreg_wire;
    wire [2:0] aluop_wire;
    wire memwrite_wire;
    wire alusrc_wire;
    wire regwrite_wire;
    wire [31:0] imm_gen_wire;
    wire [31:0] output_of_alumux;
    wire [3:0] output_of_alu_control_unit;
    wire zeroFlag;
    wire cf;
    wire vf;
    wire sf;
    wire [31:0] output_of_alu;
    reg [31:0] output_of_data_mem_read;
    wire [31:0] pc_plus_four;
    wire [31:0] shift_left_output;
    wire [31:0] and_gate_output;
    reg [12:0] ssd;
    wire [31:0]lui_wire;
    wire [31:0]auipc_wire;
    wire output_of_branch_cu;
    wire [1:0] reg_file_input_mux_sel;
    wire [1:0] pc_mux_sel;
    wire [31:0] output_of_reg_file_input_mux;
    assign pc_mux_sel={EX_MEM_Ctrl[0] | output_of_branch_cu,EX_MEM_Ctrl[1] | output_of_branch_cu};
    assign lui_wire= ID_EX_Imm;
    
    assign reg_file_input_mux_sel={MEM_WB_INST[2]&MEM_WB_INST[4],MEM_WB_INST[2]&MEM_WB_INST[5]};
    //after making a truth table and k-map to get sel[0] and sel[1] in terms of instruction code[2] and [4] and [5]
    assign auipc_wire=lui_wire+ID_EX_PC;
    
    //InstMem my_inst_mem(.addr(output_of_PC[11:2]), .data_out(output_of_inst_mem));
    
    branch_cu my_branch_cu(.cf(EX_MEM_cf),.zf(EX_MEM_ZF),.vf(EX_MEM_vf),.sf(EX_MEM_sf),.branch(EX_MEM_Ctrl[10]), .func3(EX_MEM_func3), .output_of_branch_cu(output_of_branch_cu));
    //bcu at mem stage, will take ctrls from ex_mem
    
    register my_pc_counter(.rst(reset),.clk(clk),.D(output_of_pc_mux), .load(~({EX_MEM_INST[20],EX_MEM_INST[6:0]}==8'b11110011)), .Q(output_of_PC));
    
    //IF_ID
    wire[31:0] IF_ID_PC;
    wire[31:0] IF_ID_INST;
    wire[31:0] output_of_if_id_flush_mux;
    register #(64)IF_ID(.clk(!clk),.rst(reset),.load(1),.D({output_of_PC,output_of_if_id_flush_mux}),.Q({IF_ID_PC,IF_ID_INST}));
    
    Nbit_mux IF_ID_Flush_mux(.A(NOOP),.B(output_of_inst_mem),.sel((EX_MEM_Ctrl[10] | EX_MEM_Ctrl[0]| EX_MEM_Ctrl[1] | ({EX_MEM_INST[20],EX_MEM_INST[6:0]}==8'b11110011)) && clk == 0 ),.mux_output(output_of_if_id_flush_mux));
    
    
    NBit_4x1mux reg_file_input_mux(.A(MEM_WB_lui),.B(MEM_WB_auipc),
     .C(MEM_WB_auipc - MEM_WB_lui + 4),.D(output_of_data_memory_mux),
     .sel(reg_file_input_mux_sel), //7ases C elmafrood yob2a pc+
     .mux_output(output_of_reg_file_input_mux));
    //we2ft hena felpipeline elettegah lfo2 mesh lta7t
    
    //ID_EX_Imm +ID_EX_PC will assign them to target address stored in exmem reg
    NBit_4x1mux pc_mux(.A(EX_MEM_target_address),.B(EX_MEM_target_address), .C(EX_MEM_ALU_out),.D(pc_plus_four),.sel(pc_mux_sel),.mux_output(output_of_pc_mux));
    
    
    regfile my_register_file(
    .clk(clk), .rst(reset), .RegWrite(MEM_WB_Ctrl[2]), .readreg1(IF_ID_INST [19:15]),
    .readreg2(IF_ID_INST[24:20]), .writereg(MEM_WB_Rd), 
    .writedata(output_of_reg_file_input_mux), .read_data1(read_data1_output), .read_data2(read_data2_output)
    );
    
    control_unit my_control_unit(
    .opcode(IF_ID_INST[6:0]), .branch(branch_wire),.memread(memread_wire), 
    .memtoreg(memtoreg_wire),.aluop(aluop_wire), .memwrite(memwrite_wire), 
    .alusrc(alusrc_wire), .regwrite(reg_write_wire),.jalr(jalr_wire),.jal(jal_wire)
    );
    
    wire[10:0] ctrls;
    assign ctrls = {branch_wire,memread_wire,memtoreg_wire,aluop_wire,memwrite_wire,alusrc_wire,reg_write_wire,jalr_wire,jal_wire};
    
    //ID_EX
    wire [10:0]ID_EX_Ctrl;
    wire[31:0]ID_EX_INST;
    wire [31:0]ID_EX_PC;
    wire [31:0]ID_EX_RegR1;
    wire [31:0]ID_EX_RegR2;
    wire [31:0]ID_EX_Imm;
    wire [3:0]ID_EX_Func;
    wire [4:0]ID_EX_Rs1;
    wire [4:0]ID_EX_Rs2;
    wire [4:0]ID_EX_Rd;
    wire [10:0]output_of_id_ex_flush_mux;
    register #(190)ID_EX (.rst(reset),.clk(clk), .load(1),
     .D({output_of_id_ex_flush_mux ,IF_ID_INST ,IF_ID_PC,read_data1_output,read_data2_output
    , imm_gen_wire,IF_ID_INST[30], IF_ID_INST[14:12],IF_ID_INST[19:15]
    ,IF_ID_INST[24:20], IF_ID_INST[11:7]})
    ,.Q({ID_EX_Ctrl,ID_EX_INST,
    ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,ID_EX_Imm,ID_EX_Func,ID_EX_Rs1,
    ID_EX_Rs2,ID_EX_Rd}));
    
    Nbit_mux ID_EX_Flush_mux(.A(11'b0),.B(ctrls),.sel(EX_MEM_Ctrl[10] | EX_MEM_Ctrl[0]| EX_MEM_Ctrl[1] | ({EX_MEM_INST[20],EX_MEM_INST[6:0]}==8'b11110011) ),.mux_output(output_of_id_ex_flush_mux));
    
    
    //forwarding
    wire  forwardA;
    wire  forwardB;
    wire [31:0] output_of_alu_muxA;
    wire [31:0] output_of_alu_muxB;
  
    forwarding_unit my_fu(.id_ex_rs1(ID_EX_Rs1), .id_ex_rs2(ID_EX_Rs2),
      .mem_wb_rd(MEM_WB_Rd), 
      .mem_wb_regwrite(MEM_WB_Ctrl[2]),.forwardA(forwardA), .forwardB(forwardB) );
    Nbit_mux alu_muxA(.A(output_of_data_memory_mux),.B(ID_EX_RegR1), 
    .sel(forwardA), .mux_output(output_of_alu_muxA)); 
    Nbit_mux alu_muxB(.A(output_of_data_memory_mux),.B(ID_EX_RegR2), 
    .sel(forwardB), .mux_output(output_of_alu_muxB));   
    
    
    
    
    
    Nbit_mux alu_mux(.A(ID_EX_Imm),.B(output_of_alu_muxB), 
    .sel(ID_EX_Ctrl[3]), .mux_output(output_of_alumux)
    );
    
    prv32_ALU my_alu(.a(output_of_alu_muxA ), .b(output_of_alumux), 
    .alufn(output_of_alu_control_unit),.zf(zeroFlag), .r(output_of_alu),
    .cf(cf),.sf(sf),.vf(vf), .shamt((ID_EX_INST [6:2]==5'b0010)?ID_EX_INST[24:20]:output_of_alumux[4:0] ));
    
    
    //EX_MEM
    wire [10:0]EX_MEM_Ctrl;
    wire [31:0]EX_MEM_target_address;
    wire EX_MEM_ZF;
    wire [31:0]EX_MEM_ALU_out;
    wire [31:0]EX_MEM_RegR2;
    wire [4:0] EX_MEM_Rd;
    wire [2:0] EX_MEM_func3;
    wire EX_MEM_cf;
    wire EX_MEM_vf;
    wire EX_MEM_sf;  
    wire [31:0]EX_MEM_auipc;
    wire [31:0]EX_MEM_lui;
    wire [31:0]EX_MEM_INST;
    wire [31:0] output_of_ex_mem_flush_mux;
    
    register #(215)EX_MEM(.rst(reset),.clk(!clk),.load(1),.D({output_of_ex_mem_flush_mux,
     ID_EX_PC + ID_EX_Imm, zeroFlag, output_of_alu,output_of_alu_muxB, ID_EX_Rd,
      ID_EX_INST[14:12],cf,vf,sf,auipc_wire,lui_wire, ID_EX_INST}),
    .Q({EX_MEM_Ctrl, EX_MEM_target_address, EX_MEM_ZF, EX_MEM_ALU_out,
    EX_MEM_RegR2,  EX_MEM_Rd, EX_MEM_func3,EX_MEM_cf,EX_MEM_vf,EX_MEM_sf,
     EX_MEM_auipc, EX_MEM_lui,EX_MEM_INST}));
        
      
     Nbit_mux EX_MEM_Flush_mux(.A(11'b0),.B(ID_EX_Ctrl),.sel((EX_MEM_Ctrl[10] | EX_MEM_Ctrl[0]| EX_MEM_Ctrl[1] )&~clk),.mux_output(output_of_ex_mem_flush_mux));   
            
//     DataMem my_data_mem(.clk(clk), .MemRead(EX_MEM_Ctrl[9]), .MemWrite(EX_MEM_Ctrl[4]),
//    .addr(EX_MEM_ALU_out[7:0]),.data_in(EX_MEM_RegR2), .data_out(output_of_data_mem_read), .func3(EX_MEM_func3),.reset(0));
    
    wire [8:0]mem_addr_mux_output;
    wire [31:0]output_of_memory;
    Nbit_mux #(9)mem_addr_mux(.A(output_of_PC[8:0]),.B(EX_MEM_ALU_out[8:0]),.sel(clk),.mux_output(mem_addr_mux_output));
    memory my_mem(.clk(clk), .MemRead(EX_MEM_Ctrl[9]), .MemWrite(EX_MEM_Ctrl[4]),.addr(mem_addr_mux_output),.data_in(EX_MEM_RegR2), .data_out(output_of_memory), .func3(EX_MEM_func3));
    always@(*)begin 
    if(reset) begin 
        output_of_inst_mem <= 0; 
        output_of_data_mem_read <=0 ;
    end 
    else if(clk) output_of_inst_mem <= output_of_memory; 
    else output_of_data_mem_read <= output_of_memory;  
    end
    //MEM_WB
    wire [10:0] MEM_WB_Ctrl;
    wire [31:0] MEM_WB_Mem_out;
    wire [31:0] MEM_WB_ALU_out;
    wire [4:0] MEM_WB_Rd;
    wire [31:0]MEM_WB_auipc;
    wire [31:0]MEM_WB_lui;
    wire [31:0]MEM_WB_INST;
    register #(176) MEM_WB(.rst(reset),.clk(clk),.load(1),
    .D({EX_MEM_Ctrl,output_of_data_mem_read ,EX_MEM_ALU_out,
    EX_MEM_Rd, EX_MEM_auipc, EX_MEM_lui, EX_MEM_INST }),
    .Q({MEM_WB_Ctrl,MEM_WB_Mem_out, MEM_WB_ALU_out,
    MEM_WB_Rd, MEM_WB_auipc, MEM_WB_lui, MEM_WB_INST}));
    
    
    
    Nbit_mux data_mem_mux(.A(MEM_WB_Mem_out),.B(MEM_WB_ALU_out), 
    .sel(MEM_WB_Ctrl[8]), .mux_output(output_of_data_memory_mux)
    );  
    
    rv32_ImmGen my_imm_gen(.Imm(imm_gen_wire), .IR(IF_ID_INST));
    
    //assign alu_cu_input = {output_of_inst_mem[30],output_of_inst_mem[14:12]};
    
    
    //alu op is 2 bits in module and 3 bits in top module 
    //it takes the 2 lsb so no problem till now
    alucontrolunit my_alu_cu(.aluop(ID_EX_Ctrl[7:5]), .inst_por(ID_EX_Func), .alusel(output_of_alu_control_unit));
    
    assign pc_plus_four = output_of_PC + 4;
    
    //shifting is executed implicitly in new immgen
    //NBit_shift_left_1 my_shifter(.in(imm_gen_wire ),.out(shift_left_output));
    
    

////fpga implementation   
//   always @(ledSel)
//   begin
//   if(ledSel == 2'b00) leds = output_of_inst_mem[15:0];
//   else if(ledSel == 2'b01) leds = output_of_inst_mem[31:16];
//   else if(ledSel == 2'b10) begin
//   leds = {2'b00,branch_wire,memread_wire,memtoreg_wire
//   ,aluop_wire,memwrite_wire,alusrc_wire,regwrite_wire,output_of_alu_control_unit,
//    zeroFlag,branch_wire && zeroFlag};
//   end  
//   end   
//   assign and_gate_output=branch_wire & zeroFlag;
//   always @(ssdSel)
//   begin
//   case(ssdSel) 
//   4'b0000: ssd = output_of_PC[12:0];
//   4'b0001: ssd = pc_plus_four [12:0];
//   4'b0010: ssd = and_gate_output[12:0];
//   4'b0011: ssd = output_of_pc_mux [12:0];
//   4'b0100: ssd = read_data1_output [12:0];
//   4'b0101: ssd = read_data2_output [12:0];
//   4'b0110: ssd = output_of_data_memory_mux [12:0];
//   4'b0111: ssd = imm_gen_wire [12:0];
//   4'b1000: ssd = shift_left_output [12:0];
//   4'b1001: ssd = output_of_alumux[12:0];
//   4'b1010: ssd = output_of_alu [12:0];
//   4'b1011: ssd = output_of_data_mem_read [12:0];
//   endcase
//   end 
//   Four_Digit_Seven_Segment_Driver my_ssd(.clk(SSDclk),.num(ssd),.Anode(anode),.LED_out(seven_segment_display));
endmodule
