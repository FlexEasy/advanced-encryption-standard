/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);

logic [31:0] register_file[16];
logic [31:0] AES_KEY[4];
logic [31:0] AES_MSG_ENC[4];
logic [31:0] AES_MSG_DEC[4]; 
logic  AES_DONE;
logic  AES_START; 
    
always_ff @ (posedge CLK) 
begin
	if(RESET)
    for(int i = 0; i< 16; i++)
        register_file[i] <= 0;
	else if(AVL_WRITE && AVL_CS) 
	begin
	 if(AVL_BYTE_EN == 4'b1111)
		  register_file[AVL_ADDR] <= AVL_WRITEDATA;
    else if(AVL_BYTE_EN == 4'b1100)
        register_file[AVL_ADDR][31:16] <= AVL_WRITEDATA[31:16];
    else if(AVL_BYTE_EN == 4'b0011)
        register_file[AVL_ADDR][15:0] <= AVL_WRITEDATA[15:0];
	 else if(AVL_BYTE_EN == 4'b1000)
		  register_file[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
    else if(AVL_BYTE_EN == 4'b0100)
        register_file[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
    else if(AVL_BYTE_EN == 4'b0010)
        register_file[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];
	 else if(AVL_BYTE_EN == 4'b0001)
        register_file[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];
	end
	//else if(AVL_READ && AVAL_CS) 
end

always_comb
begin	
case(AVL_ADDR)
	//Register Map:
	//0-3 : 4x 32bit AES Key
	4'b0000: AES_KEY[0] <= register_file[AVL_ADDR];
	4'b0001: AES_KEY[1] <= register_file[AVL_ADDR];
	4'b0010: AES_KEY[2] <= register_file[AVL_ADDR];
	4'b0011: AES_KEY[3] <= register_file[AVL_ADDR];
	
	//4-7 : 4x 32bit AES Encrypted Message
	4'b0100: AES_MSG_ENC[0] <= register_file[AVL_ADDR];
	4'b0101: AES_MSG_ENC[1] <= register_file[AVL_ADDR];
	4'b0110: AES_MSG_ENC[2] <= register_file[AVL_ADDR];
	4'b0111: AES_MSG_ENC[3] <= register_file[AVL_ADDR];
	
	//8-11: 4x 32bit AES Decrypted Message
	4'b1000:register_file[AVL_ADDR]<= AES_MSG_DEC[0];
	4'b1001:register_file[AVL_ADDR]<= AES_MSG_DEC[1];
	4'b1010:register_file[AVL_ADDR]<= AES_MSG_DEC[2];
	4'b1011:register_file[AVL_ADDR]<= AES_MSG_DEC[3];
	
	4'b1100:register_file[AVL_ADDR]= 32'b00000000_00000000_00000000_00000000;//unused 
	4'b1101:register_file[AVL_ADDR]= 32'b00000000_00000000_00000000_00000000;//unused
	//14: 32bit Start Register
	4'b1110:AES_START <=register_file[AVL_ADDR];
	//15: 32bit Done Register
	4'b1111:register_file[AVL_ADDR]<= AES_DONE;
endcase
end	

//AES myAES(.CLK,.RESET,.AES_START,.AES_DONE,
//			 .AES_KEY({AES_KEY[3],AES_KEY[2],AES_KEY[1],AES_KEY[0]}),
//			 .AES_MSG_ENC({AES_MSG_ENC[3],AES_MSG_ENC[2],AES_MSG_ENC[1],AES_MSG_ENC[0]}),
//			 .AES_MSG_DEC({AES_MSG_DEC[3],AES_MSG_DEC[2],AES_MSG_DEC[1],AES_MSG_DEC[0]}));

endmodule			 