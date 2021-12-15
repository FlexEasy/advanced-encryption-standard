/************************************************************************
Lab 9 Quartus Project Top Level

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module lab9_top (
	input  logic        CLOCK_50,
	input  logic [1:0]  KEY,
	output logic [7:0]  LEDG,
	output logic [17:0] LEDR,
	output logic [6:0]  HEX0,
	output logic [6:0]  HEX1,
	output logic [6:0]  HEX2,
	output logic [6:0]  HEX3,
	output logic [6:0]  HEX4,
	output logic [6:0]  HEX5,
	output logic [6:0]  HEX6,
	output logic [6:0]  HEX7,
	output logic [12:0] DRAM_ADDR,
	output logic [1:0]  DRAM_BA,
	output logic        DRAM_CAS_N,
	output logic        DRAM_CKE,
	output logic        DRAM_CS_N,
	inout  wire [31:0] DRAM_DQ,
	output logic [3:0]  DRAM_DQM,
	output logic        DRAM_RAS_N,
	output logic        DRAM_WE_N,
	output logic        DRAM_CLK
);


// Exported data to show on Hex displays
logic [31:0] AES_EXPORT_DATA;
logic Reset_h, Clk;
assign Clk = CLOCK_50;

always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
/*
//HPI_IO_Interface
logic [1:0] hpi_addr;
logic [15:0] hpi_data_in, hpi_data_out;
logic hpi_r, hpi_w, hpi_cs, hpi_reset;
//OTG 
logic [15:0] OTG_DATA;     //CY7C67200 Data bus 16 Bits
logic [1:0]  OTG_ADDR;     //CY7C67200 Address 2 Bits
logic        OTG_CS_N,     //CY7C67200 Chip Select
			    OTG_OE_N,     //CY7C67200 Write
             OTG_WE_N,     //CY7C67200 Read
             OTG_RST_N,    //CY7C67200 Reset
             OTG_INT;      //CY7C67200 Interrupt  
*/
				 
 /*hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            //.OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_OE_N),    
                            .OTG_WR_N(OTG_WE_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N),
									 .OTG_INT(OTG_INT)
    );
*/	 
// Instantiation of Qsys design
lab9_soc lab9_qsystem (
	.clk_clk(CLOCK_50),								// Clock input
	.reset_reset_n(1'b1),							// Reset key
	//.aes_export_EXPORT_DATA(AES_EXPORT_DATA),	// Exported data
	.sdram_wire_addr(DRAM_ADDR),					// sdram_wire.addr
	.sdram_wire_ba(DRAM_BA),						// sdram_wire.ba
	.sdram_wire_cas_n(DRAM_CAS_N),				// sdram_wire.cas_n
	.sdram_wire_cke(DRAM_CKE),						// sdram_wire.cke
	.sdram_wire_cs_n(DRAM_CS_N),					// sdram.cs_n
	.sdram_wire_dq(DRAM_DQ),						// sdram.dq
	.sdram_wire_dqm(DRAM_DQM),						// sdram.dqm
	.sdram_wire_ras_n(DRAM_RAS_N),				// sdram.ras_n
	.sdram_wire_we_n(DRAM_WE_N),					// sdram.we_n
	.sdram_clk_clk(DRAM_CLK),						// Clock out to SDRAM
	.aes_export_export_data(AES_EXPORT_DATA) //      aes_export.export_data
	
	// Lab8 Stuff
	//.otg_hpi_address_export(hpi_addr), // otg_hpi_address.export
	//.otg_hpi_cs_export(hpi_cs),      //      otg_hpi_cs.export
	//.otg_hpi_data_in_port(hpi_data_in),   //    otg_hpi_data.in_port
	//.otg_hpi_data_out_port(hpi_data_out),  //                .out_port
	//.otg_hpi_r_export(hpi_r),       //       otg_hpi_r.export
	//.otg_hpi_reset_export(hpi_reset),   //   otg_hpi_reset.export
	//.otg_hpi_w_export(hpi_w),       //       otg_hpi_w.export
	

	
);

//avalon_aes_interface AES_interface(
//
//												);
//	// Avalon Clock Input
//	input logic CLK,
//	
//	// Avalon Reset Input
//	input logic RESET,
//	
//	// Avalon-MM Slave Signals
//	input  logic AVL_READ,					// Avalon-MM Read
//	input  logic AVL_WRITE,					// Avalon-MM Write
//	input  logic AVL_CS,						// Avalon-MM Chip Select
//	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
//	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
//	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
//	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
//	
//	// Exported Conduit
//	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
//);


// Display the first 4 and the last 4 hex values of the received message
hexdriver hexdrv0 (
	.In(AES_EXPORT_DATA[3:0]),
   .Out(HEX0)
);
hexdriver hexdrv1 (
	.In(AES_EXPORT_DATA[7:4]),
   .Out(HEX1)
);
hexdriver hexdrv2 (
	.In(AES_EXPORT_DATA[11:8]),
   .Out(HEX2)
);
hexdriver hexdrv3 (
	.In(AES_EXPORT_DATA[15:12]),
   .Out(HEX3)
);
hexdriver hexdrv4 (
	.In(AES_EXPORT_DATA[19:16]),
   .Out(HEX4)
);
hexdriver hexdrv5 (
	.In(AES_EXPORT_DATA[23:20]),
   .Out(HEX5)
);
hexdriver hexdrv6 (
	.In(AES_EXPORT_DATA[27:24]),
   .Out(HEX6)
);
hexdriver hexdrv7 (
	.In(AES_EXPORT_DATA[31:28]),
   .Out(HEX7)
);

endmodule

