module VGAScreen (CLOCK_50, VGA_HS, VGA_VS, VGA_R, VGA_B, VGA_G, VGA_CLK, VGA_BLANK_N, KEY, SW);

input CLOCK_50;
input [1:0] SW;
output VGA_VS, VGA_HS;
output reg [7:0] VGA_R, VGA_G, VGA_B;
output VGA_CLK;
output VGA_BLANK_N;

assign VGA_BLANK_N = 1;

//clock divider
reg CLK_25MHz;

initial begin
CLK_25MHz = 0;
end

always @(posedge CLOCK_50) begin
	CLK_25MHz <= ~CLK_25MHz;

end


assign VGA_CLK = CLK_25MHz;

//Pixel Counter
reg [9:0] count_horiz, count_verti;
reg vga_h, vga_v;

initial begin
count_horiz=0;
count_verti=0;
end

always @(posedge CLK_25MHz) begin
if (count_horiz<799) begin
	count_horiz <= count_horiz+1;
end else begin
	count_horiz <= 0;
	if (count_verti<520) begin
	count_verti <= count_verti+1;
	end else begin
	count_verti <= 0;
	end
end
if (count_horiz>655 && count_horiz<751) vga_h = 0;
else vga_h = 1;
if (count_verti>489 && count_verti<491) vga_v = 0;
else vga_v = 1;
end

assign VGA_HS = vga_h;
assign VGA_VS = vga_v;

//images
reg [7:0] COLOUR_DATA_B_Apple [0:6399];
reg [7:0] COLOUR_DATA_G_Apple [0:6399];
reg [7:0] COLOUR_DATA_R_Apple [0:6399];
wire [15:0] STATE_Apple;

reg [7:0] COLOUR_DATA_B_Tomato [0:6399];
reg [7:0] COLOUR_DATA_G_Tomato [0:6399];
reg [7:0] COLOUR_DATA_R_Tomato [0:6399];
wire [15:0] STATE_Tomato;

reg [7:0] COLOUR_DATA_B_Potato [0:6399];
reg [7:0] COLOUR_DATA_G_Potato [0:6399];
reg [7:0] COLOUR_DATA_R_Potato [0:6399];
wire [15:0] STATE_Potato;

reg [7:0] COLOUR_DATA_B_Pineapple [0:6399];
reg [7:0] COLOUR_DATA_G_Pineapple [0:6399];
reg [7:0] COLOUR_DATA_R_Pineapple [0:6399];
wire [15:0] STATE_Pineapple;

reg [7:0] COLOUR_DATA_B_Banana [0:6399];
reg [7:0] COLOUR_DATA_G_Banana [0:6399];
reg [7:0] COLOUR_DATA_R_Banana [0:6399];
wire [15:0] STATE_Banana;

reg [7:0] COLOUR_DATA_B_Peach [0:6399];
reg [7:0] COLOUR_DATA_G_Peach [0:6399];
reg [7:0] COLOUR_DATA_R_Peach [0:6399];
wire [15:0] STATE_Peach;

reg [7:0] COLOUR_DATA_B_Pepper [0:6399];
reg [7:0] COLOUR_DATA_G_Pepper [0:6399];
reg [7:0] COLOUR_DATA_R_Pepper [0:6399];
wire [15:0] STATE_Pepper;

reg [7:0] COLOUR_DATA_B_Milk [0:6399];
reg [7:0] COLOUR_DATA_G_Milk [0:6399];
reg [7:0] COLOUR_DATA_R_Milk [0:6399];
wire [15:0] STATE_Milk;

reg [7:0] COLOUR_DATA_B_Icecream [0:6399];
reg [7:0] COLOUR_DATA_G_Icecream [0:6399];
reg [7:0] COLOUR_DATA_R_Icecream [0:6399];
wire [15:0] STATE_Icecream;

reg [7:0] COLOUR_DATA_B_Bread [0:6399];
reg [7:0] COLOUR_DATA_G_Bread [0:6399];
reg [7:0] COLOUR_DATA_R_Bread [0:6399];
wire [15:0] STATE_Bread;

reg [7:0] COLOUR_DATA_B_Chocolate [0:6399];
reg [7:0] COLOUR_DATA_G_Chocolate [0:6399];
reg [7:0] COLOUR_DATA_R_Chocolate [0:6399];
wire [15:0] STATE_Chocolate;

reg [7:0] COLOUR_DATA_B_Rice [0:6399];
reg [7:0] COLOUR_DATA_G_Rice [0:6399];
reg [7:0] COLOUR_DATA_R_Rice [0:6399];
wire [15:0] STATE_Rice;

reg [7:0] COLOUR_DATA_B_Logo [0:899];
reg [7:0] COLOUR_DATA_G_Logo [0:899];
reg [7:0] COLOUR_DATA_R_Logo [0:899];
wire [15:0] STATE_Logo;

parameter Size = 7'd80;
parameter Size2 = 7'd30;


assign STATE_Apple = (count_horiz-201)*Size+(count_verti-101);
assign STATE_Tomato = (count_horiz-301)*Size+(count_verti-101);
assign STATE_Potato = (count_horiz-401)*Size+(count_verti-101);
assign STATE_Pineapple = (count_horiz-501)*Size+(count_verti-101);
assign STATE_Banana = (count_horiz-201)*Size+(count_verti-201);
assign STATE_Peach = (count_horiz-301)*Size+(count_verti-201);
assign STATE_Pepper = (count_horiz-401)*Size+(count_verti-201);
assign STATE_Milk = (count_horiz-501)*Size+(count_verti-201);
assign STATE_Icecream = (count_horiz-201)*Size+(count_verti-301);
assign STATE_Bread = (count_horiz-301)*Size+(count_verti-301);
assign STATE_Chocolate = (count_horiz-401)*Size+(count_verti-301);
assign STATE_Rice = (count_horiz-501)*Size+(count_verti-301);
assign STATE_Logo = (count_horiz-21)*Size2+(count_verti-31);

initial begin
	$readmemh ("apple_r.list", COLOUR_DATA_R_Apple);
	$readmemh ("apple_g.list", COLOUR_DATA_G_Apple);
	$readmemh ("apple_b.list", COLOUR_DATA_B_Apple);
	
	$readmemh ("tomato_r.list", COLOUR_DATA_R_Tomato);
	$readmemh ("tomato_g.list", COLOUR_DATA_G_Tomato);
	$readmemh ("tomato_b.list", COLOUR_DATA_B_Tomato);
	
	$readmemh ("potato_r.list", COLOUR_DATA_R_Potato);
	$readmemh ("potato_g.list", COLOUR_DATA_G_Potato);
	$readmemh ("potato_b.list", COLOUR_DATA_B_Potato);
	
	$readmemh ("pineapple_r.list", COLOUR_DATA_R_Pineapple);
	$readmemh ("pineapple_g.list", COLOUR_DATA_G_Pineapple);
	$readmemh ("pineapple_b.list", COLOUR_DATA_B_Pineapple);
	
	$readmemh ("banana_r.list", COLOUR_DATA_R_Banana);
	$readmemh ("banana_g.list", COLOUR_DATA_G_Banana);
	$readmemh ("banana_b.list", COLOUR_DATA_B_Banana);
	
	$readmemh ("peach_r.list", COLOUR_DATA_R_Peach);
	$readmemh ("peach_g.list", COLOUR_DATA_G_Peach);
	$readmemh ("peach_b.list", COLOUR_DATA_B_Peach);
	
	$readmemh ("pepper_r.list", COLOUR_DATA_R_Pepper);
	$readmemh ("pepper_g.list", COLOUR_DATA_G_Pepper);
	$readmemh ("pepper_b.list", COLOUR_DATA_B_Pepper);
	
	$readmemh ("milk_r.list", COLOUR_DATA_R_Milk);
	$readmemh ("milk_g.list", COLOUR_DATA_G_Milk);
	$readmemh ("milk_b.list", COLOUR_DATA_B_Milk);
	
	$readmemh ("icecream_r.list", COLOUR_DATA_R_Icecream);
	$readmemh ("icecream_g.list", COLOUR_DATA_G_Icecream);
	$readmemh ("icecream_b.list", COLOUR_DATA_B_Icecream);
	
	$readmemh ("bread_r.list", COLOUR_DATA_R_Bread);
	$readmemh ("bread_g.list", COLOUR_DATA_G_Bread);
	$readmemh ("bread_b.list", COLOUR_DATA_B_Bread);
	
	$readmemh ("chocolate_r.list", COLOUR_DATA_R_Chocolate);
	$readmemh ("chocolate_g.list", COLOUR_DATA_G_Chocolate);
	$readmemh ("chocolate_b.list", COLOUR_DATA_B_Chocolate);
	
	$readmemh ("rice_r.list", COLOUR_DATA_R_Rice);
	$readmemh ("rice_g.list", COLOUR_DATA_G_Rice);
	$readmemh ("rice_b.list", COLOUR_DATA_B_Rice);
	
	$readmemh ("logo_r.list", COLOUR_DATA_R_Logo);
	$readmemh ("logo_g.list", COLOUR_DATA_G_Logo);
	$readmemh ("logo_b.list", COLOUR_DATA_B_Logo);
	end

//Screen
//Products
always @(posedge CLK_25MHz) begin
if (count_horiz>200 && count_horiz<281 && count_verti>100 && count_verti<181) begin
	VGA_R <= COLOUR_DATA_R_Apple[{STATE_Apple}];
	VGA_B <= COLOUR_DATA_B_Apple[{STATE_Apple}];
	VGA_G <= COLOUR_DATA_G_Apple[{STATE_Apple}];
end else if (count_horiz>300 && count_horiz<381 && count_verti>100 && count_verti<181) begin
	VGA_R <= COLOUR_DATA_R_Tomato[{STATE_Tomato}];
	VGA_B <= COLOUR_DATA_B_Tomato[{STATE_Tomato}];
	VGA_G <= COLOUR_DATA_G_Tomato[{STATE_Tomato}];
end else if (count_horiz>400 && count_horiz<481 && count_verti>100 && count_verti<181) begin
	VGA_R <= COLOUR_DATA_R_Potato[{STATE_Potato}];
	VGA_B <= COLOUR_DATA_B_Potato[{STATE_Potato}];
	VGA_G <= COLOUR_DATA_G_Potato[{STATE_Potato}];
end else if (count_horiz>500 && count_horiz<581 && count_verti>100 && count_verti<181) begin
	VGA_R <= COLOUR_DATA_R_Pineapple[{STATE_Pineapple}];
	VGA_B <= COLOUR_DATA_B_Pineapple[{STATE_Pineapple}];
	VGA_G <= COLOUR_DATA_G_Pineapple[{STATE_Pineapple}];
end else if (count_horiz>200 && count_horiz<281 && count_verti>200 && count_verti<281) begin
	VGA_R <= COLOUR_DATA_R_Banana[{STATE_Banana}];
	VGA_B <= COLOUR_DATA_B_Banana[{STATE_Banana}];
	VGA_G <= COLOUR_DATA_G_Banana[{STATE_Banana}];
end else if (count_horiz>300 && count_horiz<381 && count_verti>200 && count_verti<281) begin
	VGA_R <= COLOUR_DATA_R_Peach[{STATE_Peach}];
	VGA_B <= COLOUR_DATA_B_Peach[{STATE_Peach}];
	VGA_G <= COLOUR_DATA_G_Peach[{STATE_Peach}];
end else if (count_horiz>400 && count_horiz<481 && count_verti>200 && count_verti<281) begin
	VGA_R <= COLOUR_DATA_R_Pepper[{STATE_Pepper}];
	VGA_B <= COLOUR_DATA_B_Pepper[{STATE_Pepper}];
	VGA_G <= COLOUR_DATA_G_Pepper[{STATE_Pepper}];
end else if (count_horiz>500 && count_horiz<581 && count_verti>200 && count_verti<281) begin
	VGA_R <= COLOUR_DATA_R_Milk[{STATE_Milk}];
	VGA_B <= COLOUR_DATA_B_Milk[{STATE_Milk}];
	VGA_G <= COLOUR_DATA_G_Milk[{STATE_Milk}];
end else if (count_horiz>200 && count_horiz<281 && count_verti>300 && count_verti<381) begin
	VGA_R <= COLOUR_DATA_R_Icecream[{STATE_Icecream}];
	VGA_B <= COLOUR_DATA_B_Icecream[{STATE_Icecream}];
	VGA_G <= COLOUR_DATA_G_Icecream[{STATE_Icecream}];
end else if (count_horiz>300 && count_horiz<381 && count_verti>300 && count_verti<381) begin
	VGA_R <= COLOUR_DATA_R_Bread[{STATE_Bread}];
	VGA_B <= COLOUR_DATA_B_Bread[{STATE_Bread}];
	VGA_G <= COLOUR_DATA_G_Bread[{STATE_Bread}];
end else if (count_horiz>400 && count_horiz<481 && count_verti>300 && count_verti<381) begin
	VGA_R <= COLOUR_DATA_R_Chocolate[{STATE_Chocolate}];
	VGA_B <= COLOUR_DATA_B_Chocolate[{STATE_Chocolate}];
	VGA_G <= COLOUR_DATA_G_Chocolate[{STATE_Chocolate}];
end else if (count_horiz>500 && count_horiz<581 && count_verti>300 && count_verti<381) begin
	VGA_R <= COLOUR_DATA_R_Rice[{STATE_Rice}];
	VGA_B <= COLOUR_DATA_B_Rice[{STATE_Rice}];
	VGA_G <= COLOUR_DATA_G_Rice[{STATE_Rice}];
end else if (count_horiz>20 && count_horiz<51 && count_verti>30 && count_verti<61) begin
	VGA_R <= COLOUR_DATA_R_Logo[{STATE_Logo}];
	VGA_B <= COLOUR_DATA_B_Logo[{STATE_Logo}];
	VGA_G <= COLOUR_DATA_G_Logo[{STATE_Logo}];
//Autocomplete Operation
end else if ((count_horiz>200 && count_horiz<281 && count_verti>182 && count_verti<190) && 
((barcode == 16'h3000) || (barcode == 16'h3100) || (barcode == 16'h3130) || (barcode == 16'h3133))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>300 && count_horiz<381 && count_verti>182 && count_verti<190) && 
((barcode == 16'h4000) || (barcode == 16'h4100) || (barcode  == 16'h4130) || (barcode == 16'h4133))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>400 && count_horiz<481 && count_verti>182 && count_verti<190) && 
((barcode == 16'h4000) || (barcode == 16'h4100) || (barcode == 16'h4130) || (barcode == 16'h4132))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>500 && count_horiz<581 && count_verti>182 && count_verti<190) && 
((barcode == 16'h3000) || (barcode == 16'h3200) || (barcode == 16'h3210) || (barcode == 16'h3214))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>200 && count_horiz<281 && count_verti>282 && count_verti<290) && 
((barcode == 16'h3000) || (barcode == 16'h3100) || (barcode == 16'h3120) || (barcode == 16'h3124))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>300 && count_horiz<381 && count_verti>282 && count_verti<290) && 
((barcode == 16'h3000) || (barcode == 16'h3100) || (barcode == 16'h3120) || (barcode == 16'h3121))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>400 && count_horiz<481 && count_verti>282 && count_verti<290) && 
((barcode == 16'h1000) || (barcode == 16'h1200) || (barcode == 16'h1240) || (barcode == 16'h1243))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>500 && count_horiz<581 && count_verti>282 && count_verti<290) && 
((barcode == 16'h1000) || (barcode == 16'h1300) || (barcode == 16'h1340) || (barcode == 16'h1344))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>200 && count_horiz<281 && count_verti>382 && count_verti<390) && 
((barcode == 16'h2000) || (barcode == 16'h2100) || (barcode == 16'h2130) || (barcode == 16'h2133))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>300 && count_horiz<381 && count_verti>382 && count_verti<390) && 
((barcode == 16'h2000) || (barcode == 16'h2400) || (barcode == 16'h2430) || (barcode == 16'h2431))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>400 && count_horiz<481 && count_verti>382 && count_verti<390) && 
((barcode == 16'h1000) || (barcode == 16'h1400) || (barcode == 16'h1410) || (barcode == 16'h1411))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>500 && count_horiz<581 && count_verti>382 && count_verti<390) && 
((barcode == 16'h2000) || (barcode == 16'h2300) || (barcode == 16'h2320) || (barcode == 16'h2321))) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>200 && count_horiz<221 && count_verti>182 && count_verti<190) && SW[0]==1 && next==0)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>300 && count_horiz<321 && count_verti>182 && count_verti<190) && SW[0]==1 && next==1)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>400 && count_horiz<421 && count_verti>182 && count_verti<190) && SW[0]==1 && next==2)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>500 && count_horiz<521 && count_verti>182 && count_verti<190) && SW[0]==1 && next==3)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>200 && count_horiz<221 && count_verti>282 && count_verti<290) && SW[0]==1 && next==4)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>300 && count_horiz<321 && count_verti>282 && count_verti<290) && SW[0]==1 && next==5)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>400 && count_horiz<421 && count_verti>282 && count_verti<290) && SW[0]==1 && next==6)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>500 && count_horiz<521 && count_verti>282 && count_verti<290) && SW[0]==1 && next==7)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>200 && count_horiz<221 && count_verti>382 && count_verti<390) && SW[0]==1 && next==8)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>300 && count_horiz<321 && count_verti>382 && count_verti<390) && SW[0]==1 && next==9)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>400 && count_horiz<421 && count_verti>382 && count_verti<390) && SW[0]==1 && next==10)begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>500 && count_horiz<521 && count_verti>382 && count_verti<390) && SW[0]==1 && next==11 )begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end else if ((count_horiz>15 && count_horiz<20 && count_verti>100 && count_verti<120)&&SW[1]==1 && next2==0) begin
	VGA_R <= 8'b00000000;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>15 && count_horiz<20 && count_verti>130 && count_verti<150)&&SW[1]==1 && next2==1) begin
	VGA_R <= 8'b00000000;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>15 && count_horiz<20 && count_verti>160 && count_verti<180)&&SW[1]==1 && next2==2) begin
	VGA_R <= 8'b00000000;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>15 && count_horiz<20 && count_verti>190 && count_verti<210)&&SW[1]==1 && next2==3) begin
	VGA_R <= 8'b00000000;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>15 && count_horiz<20 && count_verti>220 && count_verti<240)&&SW[1]==1 && next2==4) begin
	VGA_R <= 8'b00000000;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b11111111;
end else if ((count_horiz>15 && count_horiz<20 && count_verti>250 && count_verti<270)&&SW[1]==1 && next2==5) begin
	VGA_R <= 8'b00000000;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b11111111;
end else if (A) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if (B) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if (C) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else if (count_verti == 420 && count_horiz>74 && count_horiz<76) begin
	VGA_R <= 8'b11111111;
	VGA_G <= 8'b11111111;
	VGA_B <= 8'b11111111;
end else begin
	VGA_R <= 8'b00000000;
	VGA_G <= 8'b00000000;
	VGA_B <= 8'b00000000;
end


end

input wire [3:0] KEY;

parameter M = 8;
reg [M:0]shift0;
reg [M:0]shift1;
reg [M:0]shift2;
reg [M:0]shift3;
 
reg [3:0] count;
reg [3:0] num;
reg [15:0] barcode; 
reg [2:0] quantity;
reg [9:0] price, price1, price2, price3, price4, price5, price6;
reg [2:0] state;
reg [14:0] sum;
reg push_button0, push_button1, push_button2, push_button3, push_button;

reg [2:0] product_count;
reg [15:0] product1, product2, product3, product4, product5, product6;
reg [2:0] quantity1, quantity2, quantity3, quantity4, quantity5, quantity6;

always @(*)
case (barcode)
16'h0000 : price = 0;
16'h3124 : price = 250; //banana
16'h4132 : price = 50; //potato
16'h4133 : price = 75; //tomato
16'h3121 : price = 200; //peach
16'h3133 : price = 100; //apple
16'h3214 : price = 995; //pineapple
16'h1243 : price = 100; //pepper
16'h1344 : price = 325; //milk_b
16'h2133 : price = 500; //icecream
16'h2431 : price = 150; //bread
16'h1411 : price = 400; //chocolate
16'h2321 : price = 500; //rice
endcase

always @(*)
case (product1)
16'h0000 : price1 = 0;
16'h3124 : price1 = 250; //banana
16'h4132 : price1 = 50; //potato
16'h4133 : price1 = 75; //tomato
16'h3121 : price1 = 200; //peach
16'h3133 : price1 = 100; //apple
16'h3214 : price1 = 995; //pineapple
16'h1243 : price1 = 100; //pepper
16'h1344 : price1 = 325; //milk_b
16'h2133 : price1 = 500; //icecream
16'h2431 : price1 = 150; //bread
16'h1411 : price1 = 400; //chocolate
16'h2321 : price1 = 500; //rice
endcase

always @(*)
case (product2)
16'h0000 : price2 = 0;
16'h3124 : price2 = 250; //banana
16'h4132 : price2 = 50; //potato
16'h4133 : price2 = 75; //tomato
16'h3121 : price2 = 200; //peach
16'h3133 : price2 = 100; //apple
16'h3214 : price2 = 995; //pineapple
16'h1243 : price2 = 100; //pepper
16'h1344 : price2 = 325; //milk_b
16'h2133 : price2 = 500; //icecream
16'h2431 : price2 = 150; //bread
16'h1411 : price2 = 400; //chocolate
16'h2321 : price2 = 500; //rice
endcase

always @(*)
case (product3)
16'h0000 : price3 = 0;
16'h3124 : price3 = 250; //banana
16'h4132 : price3 = 50; //potato
16'h4133 : price3 = 75; //tomato
16'h3121 : price3 = 200; //peach
16'h3133 : price3 = 100; //apple
16'h3214 : price3 = 995; //pineapple
16'h1243 : price3 = 100; //pepper
16'h1344 : price3 = 325; //milk_b
16'h2133 : price3 = 500; //icecream
16'h2431 : price3 = 150; //bread
16'h1411 : price3 = 400; //chocolate
16'h2321 : price3 = 500; //rice
endcase

always @(*)
case (product4)
16'h0000 : price4 = 0;
16'h3124 : price4 = 250; //banana
16'h4132 : price4 = 50; //potato
16'h4133 : price4 = 75; //tomato
16'h3121 : price4 = 200; //peach
16'h3133 : price4 = 100; //apple
16'h3214 : price4 = 995; //pineapple
16'h1243 : price4 = 100; //pepper
16'h1344 : price4 = 325; //milk_b
16'h2133 : price4 = 500; //icecream
16'h2431 : price4 = 150; //bread
16'h1411 : price4 = 400; //chocolate
16'h2321 : price4 = 500; //rice
endcase

always @(*)
case (product5)
16'h0000 : price5 = 0;
16'h3124 : price5 = 250; //banana
16'h4132 : price5 = 50; //potato
16'h4133 : price5 = 75; //tomato
16'h3121 : price5 = 200; //peach
16'h3133 : price5 = 100; //apple
16'h3214 : price5 = 995; //pineapple
16'h1243 : price5 = 100; //pepper
16'h1344 : price5 = 325; //milk_b
16'h2133 : price5 = 500; //icecream
16'h2431 : price5 = 150; //bread
16'h1411 : price5 = 400; //chocolate
16'h2321 : price5 = 500; //rice
endcase

always @(*)
case (product6)
16'h0000 : price6 = 0;
16'h3124 : price6 = 250; //banana
16'h4132 : price6 = 50; //potato
16'h4133 : price6 = 75; //tomato
16'h3121 : price6 = 200; //peach
16'h3133 : price6 = 100; //apple
16'h3214 : price6 = 995; //pineapple
16'h1243 : price6 = 100; //pepper
16'h1344 : price6 = 325; //milk_b
16'h2133 : price6 = 500; //icecream
16'h2431 : price6 = 150; //bread
16'h1411 : price6 = 400; //chocolate
16'h2321 : price6 = 500; //rice
endcase


parameter st_0 = 'd0; //initial
parameter st_1 = 'd1; //barcode
parameter st_2 = 'd2; //quantity
parameter st_3 = 'd3; // sum calculation

initial begin
	count <= 0;
	num <= 0;
	barcode <= 0;
	state <= st_0;
end

//Push Button Counter
 
 always @ (posedge CLOCK_50) 
 begin	
	shift0 <= {shift0,KEY[0]}; // N shift register
   if(~|shift0) begin
	  push_button0 <= 1;
	  num <= 1;
	end
   else if(&shift0) begin
	  push_button0 <= 0;
	end
   else begin 
	push_button0 <= push_button0;
	end
	
	shift1 <= {shift1,KEY[1]}; // N shift register
   if(~|shift1) begin
	  push_button1 <= 1;
	  num <= 2;
	end
   else if(&shift1) begin
	  push_button1 <= 0;
	end
   else begin 
	push_button1 <= push_button1;
	end
	
	shift2 <= {shift2,KEY[2]}; // N shift register
   if(~|shift2) begin
	  push_button2 <= 1;
	  num <= 3;
	end
   else if(&shift2) begin
	  push_button2 <= 0;
	end
   else begin 
	push_button2 <= push_button2;
	end

	shift3 <= {shift3,KEY[3]}; // N shift register
   if(~|shift3) begin
	  push_button3 <= 1;
	  num <= 4;
	end
   else if(&shift3) begin
	  push_button3 <= 0;
	end
   else begin 
	push_button3 <= push_button3;
	end
	
push_button <= push_button0 | push_button1 | push_button2 | push_button3;
end

reg [3:0] control, control2;
reg [1:0] select, select2;
reg [4:0] next, next2;

always @(posedge push_button) begin

		if(count == 5 && SW[0]==0 && SW[1]==0) count<=1;
		else if (product_count==6 && quantity==4) count<=0;
		else if(SW==0 && SW[1]==0) begin
		count<=count+1;
		end
		
		if(control==0 && SW[0]==1 && num==4) control<=1;
		else if (control==2 && SW[0]==1)control<=0;
		else if (control==3 && SW[0]==1) control<=control+1;
		else if(control==1) control<=control+1;
		else control<=0;
		
		if(control2==0 && SW[1]==1 && num==4) control2<=1;
		else if (control2==2 && SW[1]==1)control2<=0;
		else if(control2==1) control2<=control2+1;
		else control2<=0;
end

always @(posedge push_button) begin

		if(next<11 && SW[0]==1 && num==1 && control!=1 && SW[1]==0) next<=next+1;
		else if(next<8 && SW[0]==1 && num==2 && control!=1&& SW[1]==0) next<=next+4;
		else if(SW[0]==1 && num==2 && next>7 && next<12 && control!=1&& SW[1]==0) next<=next-8;
		else if (SW[0]==1 && num==4 && control==1&& SW[1]==0) next<=next;

		if (next2<6 && SW[1]==1 && num==1 && control2!=1) next2<=next2+1;
		else if (next>=0 && SW[1]==1 && num==2 && control2!=1) next2<=next2-1;
		else if (SW[1]==1&&num==4&&control2==1) next2<=next2;
		
end

always @(posedge CLOCK_50) begin

case (state)

st_0 : begin
	sum <= 0;
	quantity <= 0;
	barcode <= 0;
	product_count <= 0;
	product1<=0;
	product2<=0;
	product3<=0;
	product4<=0;
	product5<=0;
	product6<=0;
	quantity1<=0;
	quantity2<=0;
	quantity3<=0;
	quantity4<=0;
	quantity5<=0;
	quantity6<=0;
	state <= st_1;
end

st_1 : begin
if(SW[0]==1 && control==1 && SW[1]==0) begin
			
			case(next)
				0 : begin
				barcode<=16'h3133 ; //apple
				if (product_count ==0) begin
				product1 <= 16'h3133;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h3133;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h3133;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h3133;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h3133;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h3133;
				product_count <= product_count+1;
				end
				end
				1 : begin
				barcode<=16'h4133 ; // tomato
				if (product_count ==0) begin
				product1 <= 16'h4133;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h4133;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h4133;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h4133;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h4133;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h4133;
				product_count <= product_count+1;
				end
				end
				2 : begin
				barcode<=16'h4132 ; // potato
				if (product_count ==0) begin
				product1 <= 16'h4132;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h4132;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h4132;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h4132;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h4132;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h4132;
				product_count <= product_count+1;
				end
				end
				3 : begin
				barcode<=16'h3214 ;//pineapple 
				if (product_count ==0) begin
				product1 <= 16'h3214;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h3214;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h3214;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h3214;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h3214;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h3214;
				product_count <= product_count+1;
				end
				end
				4 : begin
				barcode<=16'h3124 ;//banana 
				if (product_count ==0) begin
				product1 <= 16'h3124;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h3124;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h3124;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h3124;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h3124;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h3124;
				product_count <= product_count+1;
				end
				end
				5 : begin
				barcode<=16'h3121 ;//peach 
				if (product_count ==0) begin
				product1 <= 16'h3121;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h3121;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h3121;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h3121;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h3121;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h3121;
				product_count <= product_count+1;
				end
				end
				6 : begin
				barcode<=16'h1243;//pepper 
				if (product_count ==0) begin
				product1 <= 16'h1243;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h1243;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h1243;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h1243;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h1243;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h1243;
				product_count <= product_count+1;
				end
				end
				7 : begin
				barcode<=16'h1344;//milk 
				if (product_count ==0) begin
				product1 <= 16'h1344;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h1344;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h1344;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h1344;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h1344;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h1344;
				product_count <= product_count+1;
				end
				end
				8 : begin
				barcode<=16'h2133;//icecream
				if (product_count ==0) begin
				product1 <= 16'h2133;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h2133;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h2133;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h2133;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h2133;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h2133;
				product_count <= product_count+1;
				end
				end
				9 : begin
				barcode<=16'h2431;//bread 
				if (product_count ==0) begin
				product1 <= 16'h2431;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h2431;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h2431;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h2431;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h2431;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h2431;
				product_count <= product_count+1;
				end
				end
				10 : begin
				barcode<=16'h1411 ;//chocolate
			   if (product_count ==0) begin
				product1 <= 16'h1411;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h1411;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h1411;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h1411;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h1411;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h1411;
				product_count <= product_count+1;
				end
				end
				11 : begin
				barcode<=16'h2321;//rice 
				if (product_count ==0) begin
				product1 <= 16'h2321;
				product_count <= product_count+1;
				end else if (product_count ==1) begin
				product2 <= 16'h2321;
				product_count <= product_count+1;
				end else if (product_count ==2) begin
				product3 <= 16'h2321;
				product_count <= product_count+1;
				end else if (product_count ==3) begin
				product4 <= 16'h2321;
				product_count <= product_count+1;
				end else if (product_count ==4) begin
				product5 <= 16'h2321;
				product_count <= product_count+1;
				end else if (product_count ==5) begin
				product6 <= 16'h2321;
				product_count <= product_count+1;
				end
				end
			endcase
			state<=st_2;
		end
else if (SW[1]==1 && control2==1) begin
	state<=st_3;

end
else if (SW[0]==0&&SW[1]==0) begin
	if (product_count == 0) begin
		if (count==1  && barcode [15:12] == 0 && product1 [15:12]==0) begin
		quantity<=0;
		barcode [15:12] <= num [3:0];
		product1 [15:12] <= num [3:0];
		end else if (count==2 && barcode [11:0] == 0 && product1 [11:0]==0) begin
		barcode [11:8] <= num [3:0];
		product1 [11:8] <= num [3:0];
		end else if (count==3 && barcode [7:0] == 0&&product1 [7:0]==0) begin
		barcode [7:4] <= num [3:0];
		product1 [7:4] <= num [3:0];
		end else if (count==4 && barcode [3:0] == 0&&product1 [3:0]==0) begin 
		barcode [3:0] <= num [3:0];
		product1 [3:0] <= num [3:0];
		product_count <= product_count+1;
		state <= st_2;
		end else state <= st_1;
	end else if (product_count == 1) begin
		if (count==1  && barcode [15:12] == 0 && product2 [15:12]==0) begin
		quantity<=0;
		barcode [15:12] <= num [3:0];
		product2 [15:12] <= num [3:0];
		end else if (count==2 && barcode [11:8] == 0 && product2 [11:8]==0) begin
		barcode [11:8] <= num [3:0];
		product2 [11:8] <= num [3:0];
		end else if (count==3 && barcode [7:4] == 0&&product2 [7:4]==0) begin
		barcode [7:4] <= num [3:0];
		product2 [7:4] <= num [3:0];
		end else if (count==4 && barcode [3:0] == 0&&product2 [3:0]==0) begin
		barcode [3:0] <= num [3:0];
		product2 [3:0] <= num [3:0];
		product_count <= product_count+1;
		state <= st_2;
		end else state <= st_1;
	end else if (product_count == 2) begin
		if (count==1  && barcode [15:12] == 0 && product3 [15:12]==0) begin
		quantity<=0;
		barcode [15:12] <= num [3:0];
		product3 [15:12] <= num [3:0];
		end else if (count==2 && barcode [11:8] == 0 && product3 [11:8]==0) begin
		barcode [11:8] <= num [3:0];
		product3 [11:8] <= num [3:0];
		end else if (count==3 && barcode [7:4] == 0&&product3 [7:4]==0) begin
		barcode [7:4] <= num [3:0];
		product3 [7:4] <= num [3:0];
		end else if (count==4 && barcode [3:0] == 0&&product3 [3:0]==0) begin
		barcode [3:0] <= num [3:0];
		product3 [3:0] <= num [3:0];
		product_count <= product_count+1;
		state <= st_2;
		end else state <= st_1;
	end else if (product_count == 3) begin
		if (count==1  && barcode [15:12] == 0 && product4 [15:12]==0) begin
		quantity<=0;
		barcode [15:12] <= num [3:0];
		product4 [15:12] <= num [3:0];
		end else if (count==2 && barcode [11:8] == 0 && product4 [11:8]==0) begin
		barcode [11:8] <= num [3:0];
		product4 [11:8] <= num [3:0];
		end else if (count==3 && barcode [7:4] == 0&&product4 [7:4]==0) begin
		barcode [7:4] <= num [3:0];
		product4 [7:4] <= num [3:0];
		end else if (count==4 && barcode [3:0] == 0&&product4 [3:0]==0) begin
		barcode [3:0] <= num [3:0];
		product4 [3:0] <= num [3:0];
		product_count <= product_count+1;
		state <= st_2;
		end else state <= st_1;
	end else if (product_count == 4) begin
		if (count==1  && barcode [15:12] == 0 && product5 [15:12]==0) begin
		quantity<=0;
		barcode [15:12] <= num [3:0];
		product5 [15:12] <= num [3:0];
		end else if (count==2 && barcode [11:8] == 0 && product5 [11:8]==0) begin
		barcode [11:8] <= num [3:0];
		product5 [11:8] <= num [3:0];
		end else if (count==3 && barcode [7:4] == 0&&product5 [7:4]==0) begin
		barcode [7:4] <= num [3:0];
		product5 [7:4] <= num [3:0];
		end else if (count==4 && barcode [3:0] == 0&&product5 [3:0]==0) begin
	   barcode [3:0] <= num [3:0];
	   product5 [3:0] <= num [3:0];
		product_count <= product_count+1;
		state <= st_2;
		end else state <= st_1;
	end else if (product_count == 5) begin
		if (count==1  && barcode [15:12] == 0 && product6 [15:12]==0) begin
		quantity<=0;
		barcode [15:12] <= num [3:0];
		product6 [15:12] <= num [3:0];
		end else if (count==2 && barcode [11:8] == 0 && product6 [11:8]==0) begin
		barcode [11:8] <= num [3:0];
		product6 [11:8] <= num [3:0];
		end else if (count==3 && barcode [7:4] == 0&&product6 [7:4]==0) begin
		barcode [7:4] <= num [3:0];
		product6 [7:4] <= num [3:0];
		end else if (count==4 && barcode [3:0] == 0&&product6 [3:0]==0) begin
		barcode [3:0] <= num [3:0];
		product6 [3:0] <= num [3:0];
		product_count <= product_count+1;
		state <= st_2;
		end else state<=st_1;	
	end else if (product_count == 6) begin
		if (num==4) state<=st_0;
		else state<=st_1;
	end
	
end
end
st_2 : begin
	
if ((count == 5 && quantity == 0 && barcode != 16'h4444)||((SW[0]==1) && control==2)) begin
	quantity <= num;
	if (product_count==1) quantity1 <= num;
	else if (product_count==2) quantity2 <= num;
	else if (product_count==3) quantity3 <= num;
	else if (product_count==4) quantity4 <= num;
	else if (product_count==5) quantity5 <= num;
	else if (product_count==6) quantity6 <= num;
	state <= st_3;
end else if (count == 5 && barcode == 16'h4444) begin
	state <= st_0;
	quantity<=num;
	end
else state <= st_2;
end


st_3 : begin
if (SW[1]==1 && control2==2) begin
	case (next2)
	0: begin
	sum=sum-(price1*quantity1);
	product_count=product_count-1;
	product1=product2;
	quantity1=quantity2;
	product2=product3;
	quantity2=quantity3;
	product3=product4;
	quantity3=quantity4;
	product4=product5;
	quantity4=quantity5;
	product5=product6;
	quantity5=quantity6;
	product6 = 0;
	quantity6 = 0;
	end
	1 : begin
	sum=sum-(price2*quantity2);
	product_count=product_count-1;
	product2=product3;
	quantity2=quantity3;
	product3=product4;
	quantity3=quantity4;
	product4=product5;
	quantity4=quantity5;
	product5=product6;
	quantity5=quantity6;
	product6 = 0;
	quantity6 = 0;
	end
	2: begin
	sum=sum-(price3*quantity3);
	product_count=product_count-1;
	product3=product4;
	quantity3=quantity4;
	product4=product5;
	quantity4=quantity5;
	product5=product6;
	quantity5=quantity6;
	product6 = 0;
	quantity6 = 0;
	end
	3 : begin
	sum=sum-(price4*quantity4);
	product_count=product_count-1;
	product4=product5;
	quantity4=quantity5;
	product5=product6;
	quantity5=quantity6;
	product6 = 0;
	quantity6 = 0;
	end
	4 : begin
	sum=sum-(price5*quantity5);
	product_count=product_count-1;
	product5=product6;
	quantity5=quantity6;
	product6 = 0;
	quantity6 = 0;
	end
	5 : begin
	sum=sum-(price6*quantity6);
	product_count=product_count-1;
	product6 = 0;
	quantity6 = 0;
	end
	endcase
	state=st_1;
end else if (SW[1]==0) begin
	sum <= sum + price * quantity;
	barcode<=0;
	state <= st_1;
end else state<=st_3;
end	

endcase
	

end 

reg q00, q01, q02, q03, q04, q05, q06,
    q10, q11, q12, q13, q14, q15, q16,
	 q20, q21, q22, q23, q24, q25, q26,
	 q30, q31, q32, q33, q34, q35, q36,
	 q40, q41, q42, q43, q44, q45, q46,
	 q50, q51, q52, q53, q54, q55, q56;

always @(posedge CLK_25MHz)
begin
case (quantity1)
0: begin
q00 = 0;
q01 = 0;
q02 = 0;
q03 = 0;
q04 = 0;
q05 = 0;
q06 = 0;
end
1: begin
q00 = 0;
q01 = (count_horiz == 195 && (count_verti >100 && count_verti<110));
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = 0;
q04 = 0;
q05 = 0;
q06 = 0;
end
2: begin
q00 = (count_verti == 100 && (count_horiz >185 && count_horiz<195));
q01 = (count_horiz == 195 && (count_verti >100 && count_verti<110));
q02 = 0;
q03 = (count_verti == 120 && (count_horiz >185 && count_horiz<195));
q04 = (count_horiz == 185 && (count_verti >110 && count_verti<120));
q05 = 0;
q06 = (count_verti == 110 && (count_horiz >185 && count_horiz<195));
end
3: begin
q00 = (count_verti == 100 && (count_horiz >185 && count_horiz<195));
q01 = (count_horiz == 195 && (count_verti >100 && count_verti<110));
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = (count_verti == 120 && (count_horiz >185 && count_horiz<195));
q04 = 0;
q05 = 0;
q06 = (count_verti == 110 && (count_horiz >185 && count_horiz<195));
end
4: begin
q00 = 0;
q01 = (count_horiz == 195 && (count_verti >100 && count_verti<110));
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = 0;
q04 = 0;
q05 = (count_horiz == 185 && (count_verti >100 && count_verti<110));
q06 = (count_verti == 110 && (count_horiz >185 && count_horiz<195));
end
5: begin
q00 = (count_verti == 100 && (count_horiz >185 && count_horiz<195));
q01 = 0;
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = (count_verti == 120 && (count_horiz >185 && count_horiz<195));
q04 = 0;
q05 = (count_horiz == 185 && (count_verti >100 && count_verti<110));
q06 = (count_verti == 110 && (count_horiz >185 && count_horiz<195));
end
6: begin
q00 = (count_verti == 100 && (count_horiz >185 && count_horiz<195));
q01 = 0;
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = (count_verti == 120 && (count_horiz >185 && count_horiz<195));
q04 = (count_horiz == 185 && (count_verti >110 && count_verti<120));
q05 = (count_horiz == 185 && (count_verti >100 && count_verti<110));
q06 = (count_verti == 110 && (count_horiz >185 && count_horiz<195));
end
7: begin
q00 = (count_verti == 100 && (count_horiz >185 && count_horiz<195));
q01 = (count_horiz == 195 && (count_verti >100 && count_verti<110));
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = 0;
q04 = 0;
q05 = 0;
q06 = 0;
end
8: begin
q00 = (count_verti == 100 && (count_horiz >185 && count_horiz<195));
q01 = (count_horiz == 195 && (count_verti >100 && count_verti<110));
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = (count_verti == 120 && (count_horiz >185 && count_horiz<195));
q04 = (count_horiz == 185 && (count_verti >110 && count_verti<120));
q05 = (count_horiz == 185 && (count_verti >100 && count_verti<110));
q06 = (count_verti == 110 && (count_horiz >185 && count_horiz<195));
end
9: begin
q00 = (count_verti == 100 && (count_horiz >185 && count_horiz<195));
q01 = (count_horiz == 195 && (count_verti >100 && count_verti<110));
q02 = (count_horiz == 195 && (count_verti >110 && count_verti<120));
q03 = (count_verti == 120 && (count_horiz >185 && count_horiz<195));
q04 = 0;
q05 = (count_horiz == 185 && (count_verti >100 && count_verti<110));
q06 = (count_verti == 110 && (count_horiz >185 && count_horiz<195));
end
endcase
end	 

always @(posedge CLK_25MHz)
begin
case (quantity2)
0: begin
q10 = 0;
q11 = 0;
q12 = 0;
q13 = 0;
q14 = 0;
q15 = 0;
q16 = 0;
end
1: begin
q10 = 0;
q11 = (count_horiz == 195 && (count_verti >130 && count_verti<140));
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = 0;
q14 = 0;
q15 = 0;
q16 = 0;
end
2: begin
q10 = (count_verti == 130 && (count_horiz >185 && count_horiz<195));
q11 = (count_horiz == 195 && (count_verti >130 && count_verti<140));
q12 = 0;
q13 = (count_verti == 150 && (count_horiz >185 && count_horiz<195));
q14 = (count_horiz == 185 && (count_verti >140 && count_verti<150));
q15 = 0;
q16 = (count_verti == 140 && (count_horiz >185 && count_horiz<195));
end
3: begin
q10 = (count_verti == 130 && (count_horiz >185 && count_horiz<195));
q11 = (count_horiz == 195 && (count_verti >130 && count_verti<140));
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = (count_verti == 150 && (count_horiz >185 && count_horiz<195));
q14 = 0;
q15 = 0;
q16 = (count_verti == 140 && (count_horiz >185 && count_horiz<195));
end
4: begin
q10 = 0;
q11 = (count_horiz == 195 && (count_verti >130 && count_verti<140));
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = 0;
q14 = 0;
q15 = (count_horiz == 185 && (count_verti >130 && count_verti<140));
q16 = (count_verti == 140 && (count_horiz >185 && count_horiz<195));
end
5: begin
q10 = (count_verti == 130 && (count_horiz >185 && count_horiz<195));
q11 = 0;
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = (count_verti == 150 && (count_horiz >185 && count_horiz<195));
q14 = 0;
q15 = (count_horiz == 185 && (count_verti >130 && count_verti<140));
q16 = (count_verti == 140 && (count_horiz >185 && count_horiz<195));
end
6: begin
q10 = (count_verti == 130 && (count_horiz >185 && count_horiz<195));
q11 = 0;
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = (count_verti == 150 && (count_horiz >185 && count_horiz<195));
q14 = (count_horiz == 185 && (count_verti >140 && count_verti<150));
q15 = (count_horiz == 185 && (count_verti >130 && count_verti<140));
q16 = (count_verti == 140 && (count_horiz >185 && count_horiz<195));
end
7: begin
q10 = (count_verti == 130 && (count_horiz >185 && count_horiz<195));
q11 = (count_horiz == 195 && (count_verti >130 && count_verti<140));
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = 0;
q14 = 0;
q15 = 0;
q16 = 0;
end
8: begin
q10 = (count_verti == 130 && (count_horiz >185 && count_horiz<195));
q11 = (count_horiz == 195 && (count_verti >130 && count_verti<140));
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = (count_verti == 150 && (count_horiz >185 && count_horiz<195));
q14 = (count_horiz == 185 && (count_verti >140 && count_verti<150));
q15 = (count_horiz == 185 && (count_verti >130 && count_verti<140));
q16 = (count_verti == 140 && (count_horiz >185 && count_horiz<195));
end
9: begin
q10 = (count_verti == 130 && (count_horiz >185 && count_horiz<195));
q11 = (count_horiz == 195 && (count_verti >130 && count_verti<140));
q12 = (count_horiz == 195 && (count_verti >140 && count_verti<150));
q13 = (count_verti == 150 && (count_horiz >185 && count_horiz<195));
q14 = 0;
q15 = (count_horiz == 185 && (count_verti >130 && count_verti<140));
q16 = (count_verti == 140 && (count_horiz >185 && count_horiz<195));
end
endcase
end	 

always @(posedge CLK_25MHz)
begin
case (quantity3)
0: begin
q20 = 0;
q21 = 0;
q22 = 0;
q23 = 0;
q24 = 0;
q25 = 0;
q26 = 0;
end
1: begin
q20 = 0;
q21 = (count_horiz == 195 && (count_verti >160 && count_verti<170));
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = 0;
q24 = 0;
q25 = 0;
q26 = 0;
end
2: begin
q20 = (count_verti == 160 && (count_horiz >185 && count_horiz<195));
q21 = (count_horiz == 195 && (count_verti >160 && count_verti<170));
q22 = 0;
q23 = (count_verti == 180 && (count_horiz >185 && count_horiz<195));
q24 = (count_horiz == 185 && (count_verti >170 && count_verti<180));
q25 = 0;
q26 = (count_verti == 170 && (count_horiz >185 && count_horiz<195));
end
3: begin
q20 = (count_verti == 160 && (count_horiz >185 && count_horiz<195));
q21 = (count_horiz == 195 && (count_verti >160 && count_verti<170));
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = (count_verti == 180 && (count_horiz >185 && count_horiz<195));
q24 = 0;
q25 = 0;
q26 = (count_verti == 170 && (count_horiz >185 && count_horiz<195));
end
4: begin
q20 = 0;
q21 = (count_horiz == 195 && (count_verti >160 && count_verti<170));
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = 0;
q24 = 0;
q25 = (count_horiz == 185 && (count_verti >160 && count_verti<170));
q26 = (count_verti == 170 && (count_horiz >185 && count_horiz<195));
end
5: begin
q20 = (count_verti == 160 && (count_horiz >185 && count_horiz<195));
q21 = 0;
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = (count_verti == 180 && (count_horiz >185 && count_horiz<195));
q24 = 0;
q25 = (count_horiz == 185 && (count_verti >160 && count_verti<170));
q26 = (count_verti == 170 && (count_horiz >185 && count_horiz<195));
end
6: begin
q20 = (count_verti == 160 && (count_horiz >185 && count_horiz<195));
q21 = 0;
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = (count_verti == 180 && (count_horiz >185 && count_horiz<195));
q24 = (count_horiz == 185 && (count_verti >170 && count_verti<180));
q25 = (count_horiz == 185 && (count_verti >160 && count_verti<170));
q26 = (count_verti == 170 && (count_horiz >185 && count_horiz<195));
end
7: begin
q20 = (count_verti == 160 && (count_horiz >185 && count_horiz<195));
q21 = (count_horiz == 195 && (count_verti >160 && count_verti<170));
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = 0;
q24 = 0;
q25 = 0;
q26 = 0;
end
8: begin
q20 = (count_verti == 160 && (count_horiz >185 && count_horiz<195));
q21 = (count_horiz == 195 && (count_verti >160 && count_verti<170));
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = (count_verti == 180 && (count_horiz >185 && count_horiz<195));
q24 = (count_horiz == 185 && (count_verti >170 && count_verti<180));
q25 = (count_horiz == 185 && (count_verti >160 && count_verti<170));
q26 = (count_verti == 170 && (count_horiz >185 && count_horiz<195));
end
9: begin
q20 = (count_verti == 160 && (count_horiz >185 && count_horiz<195));
q21 = (count_horiz == 195 && (count_verti >160 && count_verti<170));
q22 = (count_horiz == 195 && (count_verti >170 && count_verti<180));
q23 = (count_verti == 180 && (count_horiz >185 && count_horiz<195));
q24 = 0;
q25 = (count_horiz == 185 && (count_verti >160 && count_verti<170));
q26 = (count_verti == 170 && (count_horiz >185 && count_horiz<195));
end
endcase
end	 

always @(posedge CLK_25MHz)
begin
case (quantity4)
0: begin
q30 = 0;
q31 = 0;
q32 = 0;
q33 = 0;
q34 = 0;
q35 = 0;
q36 = 0;
end
1: begin
q30 = 0;
q31 = (count_horiz == 195 && (count_verti >190 && count_verti<200));
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = 0;
q34 = 0;
q35 = 0;
q36 = 0;
end
2: begin
q30 = (count_verti == 190 && (count_horiz >185 && count_horiz<195));
q31 = (count_horiz == 195 && (count_verti >190 && count_verti<200));
q32 = 0;
q33 = (count_verti == 210 && (count_horiz >185 && count_horiz<195));
q34 = (count_horiz == 185 && (count_verti >200 && count_verti<210));
q35 = 0;
q36 = (count_verti == 200 && (count_horiz >185 && count_horiz<195));
end
3: begin
q30 = (count_verti == 190 && (count_horiz >185 && count_horiz<195));
q31 = (count_horiz == 195 && (count_verti >190 && count_verti<200));
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = (count_verti == 210 && (count_horiz >185 && count_horiz<195));
q34 = 0;
q35 = 0;
q36 = (count_verti == 200 && (count_horiz >185 && count_horiz<195));
end
4: begin
q30 = 0;
q31 = (count_horiz == 195 && (count_verti >190 && count_verti<200));
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = 0;
q34 = 0;
q35 = (count_horiz == 185 && (count_verti >190 && count_verti<200));
q36 = (count_verti == 200 && (count_horiz >185 && count_horiz<195));
end
5: begin
q30 = (count_verti == 190 && (count_horiz >185 && count_horiz<195));
q31 = 0;
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = (count_verti == 210 && (count_horiz >185 && count_horiz<195));
q34 = 0;
q35 = (count_horiz == 185 && (count_verti >190 && count_verti<200));
q36 = (count_verti == 200 && (count_horiz >185 && count_horiz<195));
end
6: begin
q30 = (count_verti == 190 && (count_horiz >185 && count_horiz<195));
q31 = 0;
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = (count_verti == 210 && (count_horiz >185 && count_horiz<195));
q34 = (count_horiz == 185 && (count_verti >200 && count_verti<210));
q35 = (count_horiz == 185 && (count_verti >190 && count_verti<200));
q36 = (count_verti == 200 && (count_horiz >185 && count_horiz<195));
end
7: begin
q30 = (count_verti == 190 && (count_horiz >185 && count_horiz<195));
q31 = (count_horiz == 195 && (count_verti >190 && count_verti<200));
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = 0;
q34 = 0;
q35 = 0;
q36 = 0;
end
8: begin
q30 = (count_verti == 190 && (count_horiz >185 && count_horiz<195));
q31 = (count_horiz == 195 && (count_verti >190 && count_verti<200));
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = (count_verti == 210 && (count_horiz >185 && count_horiz<195));
q34 = (count_horiz == 185 && (count_verti >200 && count_verti<210));
q35 = (count_horiz == 185 && (count_verti >190 && count_verti<200));
q36 = (count_verti == 200 && (count_horiz >185 && count_horiz<195));
end
9: begin
q30 = (count_verti == 190 && (count_horiz >185 && count_horiz<195));
q31 = (count_horiz == 195 && (count_verti >190 && count_verti<200));
q32 = (count_horiz == 195 && (count_verti >200 && count_verti<210));
q33 = (count_verti == 210 && (count_horiz >185 && count_horiz<195));
q34 = 0;
q35 = (count_horiz == 185 && (count_verti >190 && count_verti<200));
q36 = (count_verti == 200 && (count_horiz >185 && count_horiz<195));
end
endcase
end	 

always @(posedge CLK_25MHz)
begin
case (quantity5)
0: begin
q40 = 0;
q41 = 0;
q42 = 0;
q43 = 0;
q44 = 0;
q45 = 0;
q46 = 0;
end
1: begin
q40 = 0;
q41 = (count_horiz == 195 && (count_verti >220 && count_verti<230));
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = 0;
q44 = 0;
q45 = 0;
q46 = 0;
end
2: begin
q40 = (count_verti == 220 && (count_horiz >185 && count_horiz<195));
q41 = (count_horiz == 195 && (count_verti >220 && count_verti<230));
q42 = 0;
q43 = (count_verti == 240 && (count_horiz >185 && count_horiz<195));
q44 = (count_horiz == 185 && (count_verti >230 && count_verti<240));
q45 = 0;
q46 = (count_verti == 230 && (count_horiz >185 && count_horiz<195));
end
3: begin
q40 = (count_verti == 220 && (count_horiz >185 && count_horiz<195));
q41 = (count_horiz == 195 && (count_verti >220 && count_verti<230));
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = (count_verti == 240 && (count_horiz >185 && count_horiz<195));
q44 = 0;
q45 = 0;
q46 = (count_verti == 230 && (count_horiz >185 && count_horiz<195));
end
4: begin
q40 = 0;
q41 = (count_horiz == 195 && (count_verti >220 && count_verti<230));
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = 0;
q44 = 0;
q45 = (count_horiz == 185 && (count_verti >220 && count_verti<230));
q46 = (count_verti == 230 && (count_horiz >185 && count_horiz<195));
end
5: begin
q40 = (count_verti == 220 && (count_horiz >185 && count_horiz<195));
q41 = 0;
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = (count_verti == 240 && (count_horiz >185 && count_horiz<195));
q44 = 0;
q45 = (count_horiz == 185 && (count_verti >220 && count_verti<230));
q46 = (count_verti == 230 && (count_horiz >185 && count_horiz<195));
end
6: begin
q40 = (count_verti == 220 && (count_horiz >185 && count_horiz<195));
q41 = 0;
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = (count_verti == 240 && (count_horiz >185 && count_horiz<195));
q44 = (count_horiz == 185 && (count_verti >230 && count_verti<240));
q45 = (count_horiz == 185 && (count_verti >220 && count_verti<230));
q46 = (count_verti == 230 && (count_horiz >185 && count_horiz<195));
end
7: begin
q40 = (count_verti == 220 && (count_horiz >185 && count_horiz<195));
q41 = (count_horiz == 195 && (count_verti >220 && count_verti<230));
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = 0;
q44 = 0;
q45 = 0;
q46 = 0;
end
8: begin
q40 = (count_verti == 220 && (count_horiz >185 && count_horiz<195));
q41 = (count_horiz == 195 && (count_verti >220 && count_verti<230));
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = (count_verti == 240 && (count_horiz >185 && count_horiz<195));
q44 = (count_horiz == 185 && (count_verti >230 && count_verti<240));
q45 = (count_horiz == 185 && (count_verti >220 && count_verti<230));
q46 = (count_verti == 230 && (count_horiz >185 && count_horiz<195));
end
9: begin
q40 = (count_verti == 220 && (count_horiz >185 && count_horiz<195));
q41 = (count_horiz == 195 && (count_verti >220 && count_verti<230));
q42 = (count_horiz == 195 && (count_verti >230 && count_verti<240));
q43 = (count_verti == 240 && (count_horiz >185 && count_horiz<195));
q44 = 0;
q45 = (count_horiz == 185 && (count_verti >220 && count_verti<230));
q46 = (count_verti == 230 && (count_horiz >185 && count_horiz<195));
end
endcase
end	 

always @(posedge CLK_25MHz)
begin
case (quantity6)
0: begin
q50 = 0;
q51 = 0;
q52 = 0;
q53 = 0;
q54 = 0;
q55 = 0;
q56 = 0;
end
1: begin
q50 = 0;
q51 = (count_horiz == 195 && (count_verti >250 && count_verti<260));
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = 0;
q54 = 0;
q55 = 0;
q56 = 0;
end
2: begin
q50 = (count_verti == 250 && (count_horiz >185 && count_horiz<195));
q51 = (count_horiz == 195 && (count_verti >250 && count_verti<260));
q52 = 0;
q53 = (count_verti == 270 && (count_horiz >185 && count_horiz<195));
q54 = (count_horiz == 185 && (count_verti >260 && count_verti<270));
q55 = 0;
q56 = (count_verti == 260 && (count_horiz >185 && count_horiz<195));
end
3: begin
q50 = (count_verti == 250 && (count_horiz >185 && count_horiz<195));
q51 = (count_horiz == 195 && (count_verti >250 && count_verti<260));
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = (count_verti == 270 && (count_horiz >185 && count_horiz<195));
q54 = 0;
q55 = 0;
q56 = (count_verti == 260 && (count_horiz >185 && count_horiz<195));
end
4: begin
q50 = 0;
q51 = (count_horiz == 195 && (count_verti >250 && count_verti<260));
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = 0;
q54 = 0;
q55 = (count_horiz == 185 && (count_verti >250 && count_verti<260));
q56 = (count_verti == 260 && (count_horiz >185 && count_horiz<195));
end
5: begin
q50 = (count_verti == 250 && (count_horiz >185 && count_horiz<195));
q51 = 0;
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = (count_verti == 270 && (count_horiz >185 && count_horiz<195));
q54 = 0;
q55 = (count_horiz == 185 && (count_verti >250 && count_verti<260));
q56 = (count_verti == 260 && (count_horiz >185 && count_horiz<195));
end
6: begin
q50 = (count_verti == 250 && (count_horiz >185 && count_horiz<195));
q51 = 0;
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = (count_verti == 270 && (count_horiz >185 && count_horiz<195));
q54 = (count_horiz == 185 && (count_verti >260 && count_verti<270));
q55 = (count_horiz == 185 && (count_verti >250 && count_verti<260));
q56 = (count_verti == 260 && (count_horiz >185 && count_horiz<195));
end
7: begin
q50 = (count_verti == 250 && (count_horiz >185 && count_horiz<195));
q51 = (count_horiz == 195 && (count_verti >250 && count_verti<260));
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = 0;
q54 = 0;
q55 = 0;
q56 = 0;
end
8: begin
q50 = (count_verti == 250 && (count_horiz >185 && count_horiz<195));
q51 = (count_horiz == 195 && (count_verti >250 && count_verti<260));
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = (count_verti == 270 && (count_horiz >185 && count_horiz<195));
q54 = (count_horiz == 185 && (count_verti >260 && count_verti<270));
q55 = (count_horiz == 185 && (count_verti >250 && count_verti<260));
q56 = (count_verti == 260 && (count_horiz >185 && count_horiz<195));
end
9: begin
q50 = (count_verti == 250 && (count_horiz >185 && count_horiz<195));
q51 = (count_horiz == 195 && (count_verti >250 && count_verti<260));
q52 = (count_horiz == 195 && (count_verti >260 && count_verti<270));
q53 = (count_verti == 270 && (count_horiz >185 && count_horiz<195));
q54 = 0;
q55 = (count_horiz == 185 && (count_verti >250 && count_verti<260));
q56 = (count_verti == 260 && (count_horiz >185 && count_horiz<195));
end
endcase
end	 

wire C = q00 || q01 || q02 || q03 || q04 || q05 || q06
      || q10 || q11 || q12 || q13 || q14 || q15 || q16
		|| q20 || q21 || q22 || q23 || q24 || q25 || q26
		|| q30 || q31 || q32 || q33 || q34 || q35 || q36
		|| q40 || q41 || q42 || q43 || q44 || q45 || q46
		|| q50 || q51 || q52 || q53 || q54 || q55 || q56;

reg a, b, c, d, e, f;
reg g, h, j, k, l, m;
reg n, o, p, r, s, t;
reg u, v, y, z, aa, bb;
reg cc, dd, ee, ff, gg, hh;
reg jj, kk, ll, mm, nn, oo;

always @(posedge CLK_25MHz)
begin
case (product1)
16'h0000 : begin
a = 0;
b = 0;
c = 0;
d = 0;
e = 0;
f = 0;
end
16'h3124 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<55)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<85) || (count_horiz>95 && count_horiz<105)));
b = (count_verti==110 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<105) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>123 && count_horiz<128)));
c = (count_verti==120 && ((count_horiz>20 && count_horiz<30) || (count_horiz>55 && count_horiz<60)
                           || (count_horiz>85 && count_horiz<90) || (count_horiz==116) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>123 && count_horiz<128) ));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 || count_horiz==30 || count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 || count_horiz==80 
														  || count_horiz==85 || count_horiz==90 || count_horiz==95 || count_horiz==105));
e=(count_verti==115 && ((count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)));
f=((count_verti>115 && count_verti<120 && (count_horiz==110 || count_horiz==122))
  ||(count_verti>110 && count_verti<115 && (count_horiz==115||count_horiz==117)) 
  ||(count_verti>110 && count_verti<120 && (count_horiz==123 || count_horiz==128)));
end
16'h4133 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
b = (count_verti==110 && ((count_horiz>65 && count_horiz<75) || (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)
                          || (count_horiz>123 && count_horiz<128)));
c = (count_verti==120 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115)
                           || (count_horiz>123 && count_horiz<128) ||(count_horiz==116)));
d = (count_verti>100 && count_verti<120 && (count_horiz==25 ||  count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 
														  || count_horiz==85 || count_horiz==95 || count_horiz==105));
e=((count_verti>110 && count_verti<115 && count_horiz==123)||(count_verti>115 && count_verti<120 && count_horiz==128));
f=((count_verti>110 && count_verti<120 && ((count_horiz==110)||(count_horiz==115)||(count_horiz==122)))
   ||(count_verti==115&& count_horiz>123 && count_horiz<128));
end
16'h4132 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
b = (count_verti==110 && ((count_horiz>20 && count_horiz<30)||(count_horiz>65 && count_horiz<75)||(count_horiz>110 && count_horiz<115)
                            ||(count_horiz>117 && count_horiz<122) ||(count_horiz>123 && count_horiz<128)));
c = (count_verti==120 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115) 
                            || (count_horiz>117 && count_horiz<122) || (count_horiz>123 && count_horiz<128) || (count_horiz==116)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 || count_horiz==55 
                                            || count_horiz==65 || count_horiz==75 || count_horiz==85 || count_horiz==95 || count_horiz==105));
e = (count_verti>100 && count_verti<110 && (count_horiz==30));
f= (((count_verti>110 && count_verti<120 && (count_horiz==110 || count_horiz==115 || count_horiz==123 || count_horiz==128))
    ||(count_verti>110 && count_verti<115 && count_horiz==117)||(count_verti>115 && count_verti<120 && count_horiz==122))
	 ||(count_verti==115&&count_horiz>117&&count_horiz<122));
end
16'h3121 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75)));
b = (count_verti==110 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>95 && count_horiz<100)||(count_horiz>102 && count_horiz<107)
									||(count_horiz>108 && count_horiz<113)));
c = (count_verti==120 && ((count_horiz>35 && count_horiz<45) || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<100)
                           || (count_horiz>102 && count_horiz<107) || (count_horiz>108 && count_horiz<113)|| (count_horiz==101)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==60 
                                            || count_horiz==65 || count_horiz==80 || count_horiz==90));
e = (count_verti>100 && count_verti<110 && (count_horiz==30));
f= ((count_verti>110 && count_verti<115 && count_horiz==100)||(count_verti>115 && count_verti<120 && count_horiz==95)
     ||(count_verti>110 && count_verti<120 && (count_horiz==102||count_horiz==107||count_horiz==108||count_horiz==113))
	  ||(count_verti==115 && count_horiz>95 && count_horiz<100));
end
16'h3133 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>80 && count_horiz<90)));
b = (count_verti==110 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
c = (count_verti==120 && ((count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90)|| (count_horiz>97 && count_horiz<102)
                            || (count_horiz>103 && count_horiz<108) ||(count_horiz==96)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==80));
e = (count_verti>100 && count_verti<110 && (count_horiz==45 || count_horiz==60));
f=(count_verti>110 && count_verti<120 && (count_horiz==95 || count_horiz==97 || count_horiz==102 || count_horiz==103 || count_horiz==108));
end
16'h3214 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>130&& count_horiz<140)));
b = (count_verti==110 && ((count_horiz>20 && count_horiz<30)||(count_horiz>55 && count_horiz<65)||(count_horiz>70 && count_horiz<80)
								   ||(count_horiz>85 && count_horiz<95)||(count_horiz>105 && count_horiz<110)||(count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)));
c = (count_verti==120 && ((count_horiz>45 && count_horiz<50) || (count_horiz>55 && count_horiz<65)|| (count_horiz>115 && count_horiz<125) 
                           || (count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)
									|| (count_horiz==151)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==55 || count_horiz==70 || count_horiz==80 || count_horiz==85
														  || count_horiz==100 || count_horiz==115 || count_horiz==130));
e = (count_verti>100 && count_verti<110 && (count_horiz==30 || count_horiz==95 || count_horiz==110));
f=((count_verti==115 && ((count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)))
   ||(count_verti>110 && count_verti<115&&(count_horiz==145|| count_horiz==152||count_horiz==158))
	||(count_verti>115 && count_verti<120&&(count_horiz==163))
	||(count_verti>110 && count_verti<120&&(count_horiz==150||count_horiz==157)));
end
16'h1243 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)));
b = (count_verti==110 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>80 && count_horiz<90)||(count_horiz>100 && count_horiz<105)
									||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)));
c = (count_verti==120 && ((count_horiz>35 && count_horiz<45) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)||(count_horiz==111)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==65 
                                            || count_horiz==80 || count_horiz==95));
e = (count_verti>100 && count_verti<110 && (count_horiz==30 || count_horiz==60 || count_horiz==75 || count_horiz==105));
f = (((count_horiz==100 && count_verti==110)||(count_horiz==101 && count_verti==112)||(count_horiz==102 && count_verti==114)
     ||(count_horiz==103 && count_verti==116)||(count_horiz==104 && count_verti==118)||(count_horiz==105 && count_verti==120))
	  ||(count_verti>110 && count_verti<120 && (count_horiz==110||count_horiz==112||count_horiz==117||count_horiz==118||count_horiz==123)));
end
16'h1344 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)));
b = (count_verti==110 && ((count_horiz>55 && count_horiz<60)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                         ||(count_horiz>83 && count_horiz<88)));
c = (count_verti==120 && ((count_horiz>40 && count_horiz<50)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                          ||(count_horiz>83 && count_horiz<88)||(count_horiz==76)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==25 || count_horiz==30 || count_horiz==35 
                                            || count_horiz==40 || count_horiz==55));
e = ((count_horiz==65 && count_verti==100)||(count_horiz==64 && count_verti==102)||(count_horiz==63 && count_verti==104)
     ||(count_horiz==62 && count_verti==106)||(count_horiz==61 && count_verti==108)||(count_horiz==60 && count_verti==110));
f = (((count_horiz==60 && count_verti==110)||(count_horiz==61 && count_verti==112)||(count_horiz==62 && count_verti==114)
     ||(count_horiz==63 && count_verti==116)||(count_horiz==64 && count_verti==118)||(count_horiz==65 && count_verti==120))
	  ||(count_verti==115&&((count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)))
	  ||(count_verti>110 && count_verti<120 &&  count_horiz==75)
	  ||(count_verti>110 && count_verti<115 && (count_horiz==82||count_horiz==83))
	  ||(count_verti>115 && count_verti<120 && (count_horiz==77||count_horiz==88)));
end
16'h2133 : begin
a = (count_verti==100 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>115&& count_horiz<125)));
b = (count_verti==110 && ((count_horiz>40 && count_horiz<50)||(count_horiz>75 && count_horiz<80)||(count_horiz>85 && count_horiz<95)
								   ||(count_horiz>100 && count_horiz<110)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
c = (count_verti==120 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>85&& count_horiz<95) || (count_horiz==136)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==25 || count_horiz==40 || count_horiz==55 
                                            || count_horiz==70 || count_horiz==85|| count_horiz==100|| count_horiz==110
														  || count_horiz==115 || count_horiz==120|| count_horiz==125));
e = (count_verti>100 && count_verti<110 && (count_horiz==80));
f = (((count_horiz==75 && count_verti==110)||(count_horiz==76 && count_verti==112)||(count_horiz==77 && count_verti==114)
     ||(count_horiz==78 && count_verti==116)||(count_horiz==79 && count_verti==118)||(count_horiz==80 && count_verti==120))
	  ||(count_verti==115 && count_horiz>130 && count_horiz<135)
	  ||(count_verti>110 && count_verti<120 && (count_horiz==137||count_horiz==142||count_horiz==143||count_horiz==148))
	  ||(count_verti>110 && count_verti<115 && count_horiz==130)
	  ||(count_verti>115 && count_verti<120 && count_horiz==135));
end
16'h2431 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90)));
b = (count_verti==110 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
c = (count_verti==120 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)||(count_horiz==96)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==75|| count_horiz==80|| count_horiz==90));
e = (count_verti>100 && count_verti<110 && (count_horiz==45));
f = (((count_horiz==40 && count_verti==110)||(count_horiz==41 && count_verti==112)||(count_horiz==42 && count_verti==114)
     ||(count_horiz==43 && count_verti==116)||(count_horiz==44 && count_verti==118)||(count_horiz==45 && count_verti==120))
	  ||(count_verti==115 && ((count_horiz>97&&count_horiz<102)))
	  ||(count_verti>110 && count_verti<120 && (count_horiz==95||count_horiz==103||count_horiz==108))
	  ||(count_verti>110 && count_verti<115 && count_horiz==97)
	  ||(count_verti>115 && count_verti<120 && count_horiz==102));
end
16'h1411 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>110&& count_horiz<120) || (count_horiz>125&& count_horiz<135)
									|| (count_horiz>140&& count_horiz<150)));
b = (count_verti==110 && ((count_horiz>35 && count_horiz<45)||(count_horiz>110 && count_horiz<120)||(count_horiz>140 && count_horiz<150)
                           ||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)));
c = (count_verti==120 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)
									|| (count_horiz>140&& count_horiz<150)||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)
									||(count_horiz==161)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==60 || count_horiz==65 || count_horiz==80 || count_horiz==90
														  || count_horiz==95 || count_horiz==110 || count_horiz==120|| count_horiz==130|| count_horiz==140));
e = (count_verti==115 && count_horiz>155 && count_horiz<160);
f=((count_verti>110 && count_verti<120 && (count_horiz==160||count_horiz==162||count_horiz==167||count_horiz==168||count_horiz==173))
    ||(count_verti>110&&count_verti<115&&count_horiz==155));
end
16'h2321 : begin
a = (count_verti==100 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)));
b = (count_verti==110 && ((count_horiz>25 && count_horiz<30)||(count_horiz>55 && count_horiz<65)
                          ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
c = (count_verti==120 && ((count_horiz>40 && count_horiz<50)||(count_horiz>55 && count_horiz<65) || (count_horiz==76)
                           ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
d = (count_verti>100 && count_verti<120 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40|| count_horiz==55));
e = (count_verti>100 && count_verti<110 && (count_horiz==30));
f = (((count_horiz==25 && count_verti==110)||(count_horiz==26 && count_verti==112)||(count_horiz==27 && count_verti==114)
     ||(count_horiz==28 && count_verti==116)||(count_horiz==29 && count_verti==118)||(count_horiz==30 && count_verti==120))
	  ||(count_verti==115 && count_horiz>70 && count_horiz<75)
	  ||(count_verti>110 && count_verti<120 && (count_horiz==77||count_horiz==82||count_horiz==83||count_horiz==88)
	  ||(count_verti>110 && count_verti<115 && count_horiz==70)
	  ||(count_verti>115 && count_verti<120 && count_horiz==75)));
end
endcase
end
 
wire B = a || b || c || d || e || f ||
         g || h || j || k || l || m ||
			n || o || p || r || s || t ||
			u || v || y || z || aa || bb ||
			cc || dd || ee || ff || gg || hh ||
			jj || kk || ll || mm || nn || oo;

always @(posedge CLK_25MHz)
begin
case (product2)
16'h0000 : begin
g = 0;
h= 0;
j = 0;
k = 0;
l = 0;
m = 0;
end
16'h3124 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<55)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<85) || (count_horiz>95 && count_horiz<105)));
h = (count_verti==140 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<105) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>123 && count_horiz<128)));
j = (count_verti==150 && ((count_horiz>20 && count_horiz<30) || (count_horiz>55 && count_horiz<60)
                           || (count_horiz>85 && count_horiz<90) || (count_horiz==116) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>123 && count_horiz<128) ));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 || count_horiz==30 || count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 || count_horiz==80 
														  || count_horiz==85 || count_horiz==90 || count_horiz==95 || count_horiz==105));
l=(count_verti==145 && ((count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)));
m=((count_verti>145 && count_verti<150 && (count_horiz==110 || count_horiz==122))
  ||(count_verti>140 && count_verti<145 && (count_horiz==115||count_horiz==117)) 
  ||(count_verti>140 && count_verti<150 && (count_horiz==123 || count_horiz==128)));
end
16'h4133 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
h = (count_verti==140 && ((count_horiz>65 && count_horiz<75) || (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)
                          || (count_horiz>123 && count_horiz<128)));
j = (count_verti==150 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115)
                           || (count_horiz>123 && count_horiz<128) ||(count_horiz==116)));
k = (count_verti>130 && count_verti<150 && (count_horiz==25 ||  count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 
														  || count_horiz==85 || count_horiz==95 || count_horiz==105));
l=((count_verti>140 && count_verti<145 && count_horiz==123)||(count_verti>145 && count_verti<150 && count_horiz==128));
m=((count_verti>140 && count_verti<150 && ((count_horiz==110)||(count_horiz==115)||(count_horiz==122)))
   ||(count_verti==145&& count_horiz>123 && count_horiz<128));
end
16'h4132 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
h = (count_verti==140 && ((count_horiz>20 && count_horiz<30)||(count_horiz>65 && count_horiz<75)||(count_horiz>110 && count_horiz<115)
                            ||(count_horiz>117 && count_horiz<122) ||(count_horiz>123 && count_horiz<128)));
j = (count_verti==150 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115) 
                            || (count_horiz>117 && count_horiz<122) || (count_horiz>123 && count_horiz<128) || (count_horiz==116)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 || count_horiz==55 
                                            || count_horiz==65 || count_horiz==75 || count_horiz==85 || count_horiz==95 || count_horiz==105));
l = (count_verti>130 && count_verti<140 && (count_horiz==30));
m=(((count_verti>140 && count_verti<150 && (count_horiz==110 || count_horiz==115 || count_horiz==123 || count_horiz==128))
    ||(count_verti>140 && count_verti<145 && count_horiz==117)||(count_verti>145 && count_verti<150 && count_horiz==122))
	 ||(count_verti==145&&count_horiz>117&&count_horiz<122));
end
16'h3121 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75)));
h = (count_verti==140 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>95 && count_horiz<100)||(count_horiz>102 && count_horiz<107)
									||(count_horiz>108 && count_horiz<113)));
j = (count_verti==150 && ((count_horiz>35 && count_horiz<45) || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<100)
                           || (count_horiz>102 && count_horiz<107) || (count_horiz>108 && count_horiz<113)|| (count_horiz==101)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==60 
                                            || count_horiz==65 || count_horiz==80 || count_horiz==90));
l = (count_verti>130 && count_verti<140 && (count_horiz==30));
m=(((count_verti>140 && count_verti<145 && count_horiz==100)||(count_verti>145 && count_verti<150 && count_horiz==95)
     ||(count_verti>140 && count_verti<150 && (count_horiz==102||count_horiz==107||count_horiz==108||count_horiz==113)))
	  ||(count_verti==145 && count_horiz>95 && count_horiz<100));
end
16'h3133 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>80 && count_horiz<90)));
h = (count_verti==140 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
j = (count_verti==150 && ((count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90)|| (count_horiz>97 && count_horiz<102)
                            || (count_horiz>103 && count_horiz<108) ||(count_horiz==96)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==80));
l = (count_verti>130 && count_verti<140 && (count_horiz==45 || count_horiz==60));
m=(count_verti>140 && count_verti<150 && (count_horiz==95 || count_horiz==97 || count_horiz==102 || count_horiz==103 || count_horiz==108));
end
16'h3214 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>130&& count_horiz<140)));
h = (count_verti==140 && ((count_horiz>20 && count_horiz<30)||(count_horiz>55 && count_horiz<65)||(count_horiz>70 && count_horiz<80)
								   ||(count_horiz>85 && count_horiz<95)||(count_horiz>105 && count_horiz<110)||(count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)));
j = (count_verti==150 && ((count_horiz>45 && count_horiz<50) || (count_horiz>55 && count_horiz<65)|| (count_horiz>115 && count_horiz<125) 
                           || (count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)
									|| (count_horiz==151)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==55 || count_horiz==70 || count_horiz==80 || count_horiz==85
														  || count_horiz==100 || count_horiz==115 || count_horiz==130));
l = (count_verti>130 && count_verti<140 && (count_horiz==30 || count_horiz==95 || count_horiz==110));
m=((count_verti==145 && ((count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)))
   ||(count_verti>140 && count_verti<145&&(count_horiz==145|| count_horiz==152||count_horiz==158))
	||(count_verti>145 && count_verti<150&&(count_horiz==163))
	||(count_verti>140 && count_verti<150&&(count_horiz==150||count_horiz==157)));
end
16'h1243 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)));
h = (count_verti==140 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>80 && count_horiz<90)||(count_horiz>100 && count_horiz<105)
									||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)));
j = (count_verti==150 && ((count_horiz>35 && count_horiz<45) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)||(count_horiz==111)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==65 
                                            || count_horiz==80 || count_horiz==95));
l = (count_verti>130 && count_verti<140 && (count_horiz==30 || count_horiz==60 || count_horiz==75 || count_horiz==105));
m = (((count_horiz==100 && count_verti==140)||(count_horiz==101 && count_verti==142)||(count_horiz==102 && count_verti==144)
     ||(count_horiz==103 && count_verti==146)||(count_horiz==104 && count_verti==148)||(count_horiz==105 && count_verti==150))
	  ||(count_verti>140 && count_verti<150 && (count_horiz==110||count_horiz==112||count_horiz==117||count_horiz==118||count_horiz==123)));
end
16'h1344 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)));
h = (count_verti==140 && ((count_horiz>55 && count_horiz<60)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                         ||(count_horiz>83 && count_horiz<88)));
j = (count_verti==150 && ((count_horiz>40 && count_horiz<50)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                          ||(count_horiz>83 && count_horiz<88)||(count_horiz==76)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==25 || count_horiz==30 || count_horiz==35 
                                            || count_horiz==40 || count_horiz==55));
l = ((count_horiz==65 && count_verti==130)||(count_horiz==64 && count_verti==132)||(count_horiz==63 && count_verti==134)
     ||(count_horiz==62 && count_verti==136)||(count_horiz==61 && count_verti==138)||(count_horiz==60 && count_verti==140));
m = (((count_horiz==60 && count_verti==140)||(count_horiz==61 && count_verti==142)||(count_horiz==62 && count_verti==144)
     ||(count_horiz==63 && count_verti==146)||(count_horiz==64 && count_verti==148)||(count_horiz==65 && count_verti==150))
	  ||(count_verti==145&&((count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)))
	  ||(count_verti>140 && count_verti<150 &&  count_horiz==75)
	  ||(count_verti>140 && count_verti<145 && (count_horiz==82||count_horiz==83))
	  ||(count_verti>145 && count_verti<150 && (count_horiz==77||count_horiz==88)));
end
16'h2133 : begin
g = (count_verti==130 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>115&& count_horiz<125)));
h = (count_verti==140 && ((count_horiz>40 && count_horiz<50)||(count_horiz>75 && count_horiz<80)||(count_horiz>85 && count_horiz<95)
								   ||(count_horiz>100 && count_horiz<110)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
j = (count_verti==150 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>85&& count_horiz<95) || (count_horiz==136)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==25 || count_horiz==40 || count_horiz==55 
                                            || count_horiz==70 || count_horiz==85|| count_horiz==100|| count_horiz==110
														  || count_horiz==115 || count_horiz==120|| count_horiz==125));
l = (count_verti>130 && count_verti<140 && (count_horiz==80));
m = (((count_horiz==75 && count_verti==140)||(count_horiz==76 && count_verti==142)||(count_horiz==77 && count_verti==144)
     ||(count_horiz==78 && count_verti==146)||(count_horiz==79 && count_verti==148)||(count_horiz==80 && count_verti==150))
	  ||(count_verti==145 && count_horiz>130 && count_horiz<135)
	  ||(count_verti>140 && count_verti<150 && (count_horiz==137||count_horiz==142||count_horiz==143||count_horiz==148))
	  ||(count_verti>140 && count_verti<145 && count_horiz==130)
	  ||(count_verti>145 && count_verti<150 && count_horiz==135));
end
16'h2431 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90)));
h = (count_verti==140 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
j = (count_verti==150 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)||(count_horiz==96)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==75|| count_horiz==80|| count_horiz==90));
l = (count_verti>130 && count_verti<140 && (count_horiz==45));
m = (((count_horiz==40 && count_verti==140)||(count_horiz==41 && count_verti==142)||(count_horiz==42 && count_verti==144)
     ||(count_horiz==43 && count_verti==146)||(count_horiz==44 && count_verti==148)||(count_horiz==45 && count_verti==150))
	  ||(count_verti==145 && ((count_horiz>97&&count_horiz<102)))
	  ||(count_verti>140 && count_verti<150 && (count_horiz==95||count_horiz==103||count_horiz==108))
	  ||(count_verti>140 && count_verti<145 && count_horiz==97)
	  ||(count_verti>145 && count_verti<150 && count_horiz==102));
end
16'h1411 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>110&& count_horiz<120) || (count_horiz>125&& count_horiz<135)
									|| (count_horiz>140&& count_horiz<150)));
h = (count_verti==140 && ((count_horiz>35 && count_horiz<45)||(count_horiz>110 && count_horiz<120)||(count_horiz>140 && count_horiz<150)
                           ||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)));
j = (count_verti==150 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)
									|| (count_horiz>140&& count_horiz<150)||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)
									||(count_horiz==161)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==60 || count_horiz==65 || count_horiz==80 || count_horiz==90
														  || count_horiz==95 || count_horiz==110 || count_horiz==120|| count_horiz==130|| count_horiz==140));
l = (count_verti==145 && count_horiz>155 && count_horiz<160);
m=((count_verti>140 && count_verti<150 && (count_horiz==160||count_horiz==162||count_horiz==167||count_horiz==168||count_horiz==173))
    ||(count_verti>140&&count_verti<145&&count_horiz==155));
end
16'h2321 : begin
g = (count_verti==130 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)));
h = (count_verti==140 && ((count_horiz>25 && count_horiz<30)||(count_horiz>55 && count_horiz<65)
                          ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
j = (count_verti==150 && ((count_horiz>40 && count_horiz<50)||(count_horiz>55 && count_horiz<65) || (count_horiz==76)
                           ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
k = (count_verti>130 && count_verti<150 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40|| count_horiz==55));
l = (count_verti>130 && count_verti<140 && (count_horiz==30));
m = (((count_horiz==25 && count_verti==140)||(count_horiz==26 && count_verti==142)||(count_horiz==27 && count_verti==144)
     ||(count_horiz==28 && count_verti==146)||(count_horiz==29 && count_verti==148)||(count_horiz==30 && count_verti==150))
	  ||(count_verti==145 && count_horiz>70 && count_horiz<75)
	  ||(count_verti>140 && count_verti<150 && (count_horiz==77||count_horiz==82||count_horiz==83||count_horiz==88)
	  ||(count_verti>140 && count_verti<145 && count_horiz==70)
	  ||(count_verti>145 && count_verti<150 && count_horiz==75)));
end
endcase
end
 
always @(posedge CLK_25MHz)
begin
case (product3)
16'h0000 : begin
n = 0;
o = 0;
p = 0;
r = 0;
s = 0;
t = 0;
end
16'h3124 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<55)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<85) || (count_horiz>95 && count_horiz<105)));
o = (count_verti==170 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<105)
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>123 && count_horiz<128)));
p = (count_verti==180 && ((count_horiz>20 && count_horiz<30) || (count_horiz>55 && count_horiz<60)
                           || (count_horiz>85 && count_horiz<90) || (count_horiz==116) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>123 && count_horiz<128) ));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 || count_horiz==30 || count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 || count_horiz==80 
														  || count_horiz==85 || count_horiz==90 || count_horiz==95 || count_horiz==105));
s=(count_verti==175 && ((count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)));
t=((count_verti>175 && count_verti<180 && (count_horiz==110 || count_horiz==122))
  ||(count_verti>170 && count_verti<175 && (count_horiz==115||count_horiz==117)) 
  ||(count_verti>170 && count_verti<180 && (count_horiz==123 || count_horiz==128)));
end
16'h4133 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
o = (count_verti==170 && ((count_horiz>65 && count_horiz<75) || (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)
                          || (count_horiz>123 && count_horiz<128)));
p = (count_verti==180 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115)
                           || (count_horiz>123 && count_horiz<128) ||(count_horiz==116)));
r = (count_verti>160 && count_verti<180 && (count_horiz==25 ||  count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 
														  || count_horiz==85 || count_horiz==95 || count_horiz==105));
s=((count_verti>170 && count_verti<175 && count_horiz==123)||(count_verti>175 && count_verti<180 && count_horiz==128));
t=(((count_verti>170 && count_verti<180 && ((count_horiz==110)||(count_horiz==115)||(count_horiz==122)))
   ||(count_verti==175&& count_horiz>123 && count_horiz<128)));
end
16'h4132 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
o = (count_verti==170 && ((count_horiz>20 && count_horiz<30)||(count_horiz>65 && count_horiz<75)||(count_horiz>110 && count_horiz<115)
                            ||(count_horiz>117 && count_horiz<122) ||(count_horiz>123 && count_horiz<128)));
p = (count_verti==180 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115) 
                            || (count_horiz>117 && count_horiz<122) || (count_horiz>123 && count_horiz<128) || (count_horiz==116)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 || count_horiz==55 
                                            || count_horiz==65 || count_horiz==75 || count_horiz==85 || count_horiz==95 || count_horiz==105));
s = (count_verti>160 && count_verti<170 && (count_horiz==30));
t=(((count_verti>170 && count_verti<180 && (count_horiz==110 || count_horiz==115 || count_horiz==123 || count_horiz==128))
    ||(count_verti>170 && count_verti<175 && count_horiz==117)||(count_verti>175 && count_verti<180 && count_horiz==122))
	 ||(count_verti==175&&count_horiz>117&&count_horiz<122));
end
16'h3121 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75)));
o = (count_verti==170 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>95 && count_horiz<100)||(count_horiz>102 && count_horiz<107)
									||(count_horiz>108 && count_horiz<113)));
p = (count_verti==180 && ((count_horiz>35 && count_horiz<45) || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<100)
                           || (count_horiz>102 && count_horiz<107) || (count_horiz>108 && count_horiz<113)|| (count_horiz==101)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==60 
                                            || count_horiz==65 || count_horiz==80 || count_horiz==90));
s = (count_verti>160 && count_verti<170 && (count_horiz==30));
t=(((count_verti>170 && count_verti<175 && count_horiz==100)||(count_verti>175 && count_verti<180 && count_horiz==95)
     ||(count_verti>170 && count_verti<180 && (count_horiz==102||count_horiz==107||count_horiz==108||count_horiz==113)))
	  ||(count_verti==175 && count_horiz>95 && count_horiz<100));
end
16'h3133 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>80 && count_horiz<90)));
o = (count_verti==170 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
p = (count_verti==180 && ((count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90)|| (count_horiz>97 && count_horiz<102)
                            || (count_horiz>103 && count_horiz<108) ||(count_horiz==96)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==80));
s = (count_verti>160 && count_verti<170 && (count_horiz==45 || count_horiz==60));
t=(count_verti>170 && count_verti<180 && (count_horiz==95 || count_horiz==97 || count_horiz==102 || count_horiz==103 || count_horiz==108));
end
16'h3214 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>130&& count_horiz<140)));
o = (count_verti==170 && ((count_horiz>20 && count_horiz<30)||(count_horiz>55 && count_horiz<65)||(count_horiz>70 && count_horiz<80)
								   ||(count_horiz>85 && count_horiz<95)||(count_horiz>105 && count_horiz<110)||(count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)));
p = (count_verti==180 && ((count_horiz>45 && count_horiz<50) || (count_horiz>55 && count_horiz<65)|| (count_horiz>115 && count_horiz<125) 
                           || (count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)
									|| (count_horiz==151)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==55 || count_horiz==70 || count_horiz==80 || count_horiz==85
														  || count_horiz==100 || count_horiz==115 || count_horiz==130));
s = (count_verti>160 && count_verti<170 && (count_horiz==30 || count_horiz==95 || count_horiz==110));
t=((count_verti==175 && ((count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)))
   ||(count_verti>170 && count_verti<175&&(count_horiz==145|| count_horiz==152||count_horiz==158))
	||(count_verti>175 && count_verti<180&&(count_horiz==163))
	||(count_verti>170 && count_verti<180&&(count_horiz==150||count_horiz==157)));
end
16'h1243 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)));
o = (count_verti==170 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>80 && count_horiz<90)||(count_horiz>100 && count_horiz<105)
									||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)));
p = (count_verti==180 && ((count_horiz>35 && count_horiz<45) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)||(count_horiz==111)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==65 
                                            || count_horiz==80 || count_horiz==95));
s = (count_verti>160 && count_verti<170 && (count_horiz==30 || count_horiz==60 || count_horiz==75 || count_horiz==105));
t = (((count_horiz==100 && count_verti==170)||(count_horiz==101 && count_verti==172)||(count_horiz==102 && count_verti==174)
     ||(count_horiz==103 && count_verti==176)||(count_horiz==104 && count_verti==178)||(count_horiz==105 && count_verti==180))
	  ||(count_verti>170 && count_verti<180 && (count_horiz==110||count_horiz==112||count_horiz==117||count_horiz==118||count_horiz==123)));
end
16'h1344 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)));
o = (count_verti==170 && ((count_horiz>55 && count_horiz<60)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                         ||(count_horiz>83 && count_horiz<88)));
p = (count_verti==180 && ((count_horiz>40 && count_horiz<50)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                          ||(count_horiz>83 && count_horiz<88)||(count_horiz==76)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==25 || count_horiz==30 || count_horiz==35 
                                            || count_horiz==40 || count_horiz==55));
s = ((count_horiz==65 && count_verti==160)||(count_horiz==64 && count_verti==162)||(count_horiz==63 && count_verti==164)
     ||(count_horiz==62 && count_verti==166)||(count_horiz==61 && count_verti==168)||(count_horiz==60 && count_verti==170));
t = (((count_horiz==60 && count_verti==170)||(count_horiz==61 && count_verti==172)||(count_horiz==62 && count_verti==174)
     ||(count_horiz==63 && count_verti==176)||(count_horiz==64 && count_verti==178)||(count_horiz==65 && count_verti==180))
	  ||(count_verti==175&&((count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)))
	  ||(count_verti>170 && count_verti<180 &&  count_horiz==75)
	  ||(count_verti>170 && count_verti<175 && (count_horiz==82||count_horiz==83))
	  ||(count_verti>175 && count_verti<180 && (count_horiz==77||count_horiz==88)));
end
16'h2133 : begin
n = (count_verti==160 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>115&& count_horiz<125)));
o = (count_verti==170 && ((count_horiz>40 && count_horiz<50)||(count_horiz>75 && count_horiz<80)||(count_horiz>85 && count_horiz<95)
								   ||(count_horiz>100 && count_horiz<110)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
p = (count_verti==180 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>85&& count_horiz<95) || (count_horiz==136)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==25 || count_horiz==40 || count_horiz==55 
                                            || count_horiz==70 || count_horiz==85|| count_horiz==100|| count_horiz==110
														  || count_horiz==115 || count_horiz==120|| count_horiz==125));
s = (count_verti>160 && count_verti<170 && (count_horiz==80));
t = (((count_horiz==75 && count_verti==170)||(count_horiz==76 && count_verti==172)||(count_horiz==77 && count_verti==174)
     ||(count_horiz==78 && count_verti==176)||(count_horiz==79 && count_verti==178)||(count_horiz==80 && count_verti==180))
	  ||(count_verti==175 && count_horiz>130 && count_horiz<135)
	  ||(count_verti>170 && count_verti<180 && (count_horiz==137||count_horiz==142||count_horiz==143||count_horiz==148))
	  ||(count_verti>170 && count_verti<175 && count_horiz==130)
	  ||(count_verti>175 && count_verti<180 && count_horiz==135));
end
16'h2431 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90)));
o = (count_verti==170 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
p = (count_verti==180 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)||(count_horiz==96)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==75|| count_horiz==80|| count_horiz==90));
s = (count_verti>160 && count_verti<170 && (count_horiz==45));
t = (((count_horiz==40 && count_verti==170)||(count_horiz==41 && count_verti==172)||(count_horiz==42 && count_verti==174)
     ||(count_horiz==43 && count_verti==176)||(count_horiz==44 && count_verti==178)||(count_horiz==45 && count_verti==180))
	  ||(count_verti==175 && ((count_horiz>97&&count_horiz<102)))
	  ||(count_verti>170 && count_verti<180 && (count_horiz==95||count_horiz==103||count_horiz==108))
	  ||(count_verti>170 && count_verti<175 && count_horiz==97)
	  ||(count_verti>175 && count_verti<180 && count_horiz==102));
end
16'h1411 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>110&& count_horiz<120) || (count_horiz>125&& count_horiz<135)
									|| (count_horiz>140&& count_horiz<150)));
o = (count_verti==170 && ((count_horiz>35 && count_horiz<45)||(count_horiz>110 && count_horiz<120)||(count_horiz>140 && count_horiz<150)
                           ||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)));
p = (count_verti==180 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)
									|| (count_horiz>140&& count_horiz<150)||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)
									||(count_horiz==161)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==60 || count_horiz==65 || count_horiz==80 || count_horiz==90
														  || count_horiz==95 || count_horiz==110 || count_horiz==120|| count_horiz==130|| count_horiz==140));
s = (count_verti==175 && count_horiz>155 && count_horiz<160);
t=((count_verti>170 && count_verti<180 && (count_horiz==160||count_horiz==162||count_horiz==167||count_horiz==168||count_horiz==173))
    ||(count_verti>170&&count_verti<175&&count_horiz==155));
end
16'h2321 : begin
n = (count_verti==160 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)));
o = (count_verti==170 && ((count_horiz>25 && count_horiz<30)||(count_horiz>55 && count_horiz<65)
                          ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
p = (count_verti==180 && ((count_horiz>40 && count_horiz<50)||(count_horiz>55 && count_horiz<65) || (count_horiz==76)
                           ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
r = (count_verti>160 && count_verti<180 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40|| count_horiz==55));
s = (count_verti>160 && count_verti<170 && (count_horiz==30));
t = (((count_horiz==25 && count_verti==170)||(count_horiz==26 && count_verti==172)||(count_horiz==27 && count_verti==174)
     ||(count_horiz==28 && count_verti==176)||(count_horiz==29 && count_verti==178)||(count_horiz==30 && count_verti==180))
	  ||(count_verti==175 && count_horiz>70 && count_horiz<75)
	  ||(count_verti>170 && count_verti<180 && (count_horiz==77||count_horiz==82||count_horiz==83||count_horiz==88)
	  ||(count_verti>170 && count_verti<175 && count_horiz==70)
	  ||(count_verti>175 && count_verti<180 && count_horiz==75)));
end
endcase
end
 
always @(posedge CLK_25MHz)
begin
case (product4)
16'h0000 : begin
u = 0;
v = 0;
y = 0;
z = 0;
aa = 0;
bb = 0;
end
16'h3124 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<55)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<85) || (count_horiz>95 && count_horiz<105)));
v = (count_verti==200 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<105)
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>123 && count_horiz<128)));
y = (count_verti==210 && ((count_horiz>20 && count_horiz<30) || (count_horiz>55 && count_horiz<60)
                           || (count_horiz>85 && count_horiz<90) || (count_horiz==116) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>123 && count_horiz<128) ));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 || count_horiz==30 || count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 || count_horiz==80 
														  || count_horiz==85 || count_horiz==90 || count_horiz==95 || count_horiz==105));
aa=(count_verti==205 && ((count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)));
bb=((count_verti>205 && count_verti<210 && (count_horiz==110 || count_horiz==122))
  ||(count_verti>200 && count_verti<205 && (count_horiz==115||count_horiz==117)) 
  ||(count_verti>200 && count_verti<210 && (count_horiz==123 || count_horiz==128)));
end
16'h4133 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
v = (count_verti==200 && ((count_horiz>65 && count_horiz<75) || (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)
                          || (count_horiz>123 && count_horiz<128)));
y = (count_verti==210 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115)
                           || (count_horiz>123 && count_horiz<128) ||(count_horiz==116)));
z = (count_verti>190 && count_verti<210 && (count_horiz==25 ||  count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 
														  || count_horiz==85 || count_horiz==95 || count_horiz==105));
aa=((count_verti>200 && count_verti<205 && count_horiz==123)||(count_verti>205 && count_verti<210 && count_horiz==128));
bb=((count_verti>200 && count_verti<210 && ((count_horiz==110)||(count_horiz==115)||(count_horiz==122)))
    ||(count_verti==205&& count_horiz>123 && count_horiz<128));
end
16'h4132 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
v = (count_verti==200 && ((count_horiz>20 && count_horiz<30)||(count_horiz>65 && count_horiz<75)||(count_horiz>110 && count_horiz<115)
                            ||(count_horiz>117 && count_horiz<122) ||(count_horiz>123 && count_horiz<128)));
y = (count_verti==210 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115) 
                            || (count_horiz>117 && count_horiz<122) || (count_horiz>123 && count_horiz<128) || (count_horiz==116)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 || count_horiz==55 
                                            || count_horiz==65 || count_horiz==75 || count_horiz==85 || count_horiz==95 || count_horiz==105));
aa = (count_verti>190 && count_verti<200 && (count_horiz==30));
bb=(((count_verti>200 && count_verti<210 && (count_horiz==110 || count_horiz==115 || count_horiz==123 || count_horiz==128))
    ||(count_verti>200 && count_verti<205 && count_horiz==117)||(count_verti>205 && count_verti<210 && count_horiz==122))
	 ||(count_verti==205&&count_horiz>117&&count_horiz<122));
end
16'h3121 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75)));
v = (count_verti==200 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>95 && count_horiz<100)||(count_horiz>102 && count_horiz<107)
									||(count_horiz>108 && count_horiz<113)));
y = (count_verti==210 && ((count_horiz>35 && count_horiz<45) || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<100)
                           || (count_horiz>102 && count_horiz<107) || (count_horiz>108 && count_horiz<113)|| (count_horiz==101)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==60 
                                            || count_horiz==65 || count_horiz==80 || count_horiz==90));
aa = (count_verti>190 && count_verti<200 && (count_horiz==30));
bb=(((count_verti>200 && count_verti<205 && count_horiz==100)||(count_verti>205 && count_verti<210 && count_horiz==95)
     ||(count_verti>200 && count_verti<210 && (count_horiz==102||count_horiz==107||count_horiz==108||count_horiz==113)))
	  ||(count_verti==205 && count_horiz>95 && count_horiz<100));
end
16'h3133 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>80 && count_horiz<90)));
v = (count_verti==200 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
y = (count_verti==210 && ((count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90)|| (count_horiz>97 && count_horiz<102)
                            || (count_horiz>103 && count_horiz<108) ||(count_horiz==96)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==80));
aa = (count_verti>190 && count_verti<200 && (count_horiz==45 || count_horiz==60));
bb=(count_verti>200 && count_verti<210 && (count_horiz==95 || count_horiz==97 || count_horiz==102 || count_horiz==103 || count_horiz==108));
end
16'h3214 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>130&& count_horiz<140)));
v = (count_verti==200 && ((count_horiz>20 && count_horiz<30)||(count_horiz>55 && count_horiz<65)||(count_horiz>70 && count_horiz<80)
								   ||(count_horiz>85 && count_horiz<95)||(count_horiz>105 && count_horiz<110)||(count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)));
y = (count_verti==210 && ((count_horiz>45 && count_horiz<50) || (count_horiz>55 && count_horiz<65)|| (count_horiz>115 && count_horiz<125) 
                           || (count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)
									|| (count_horiz==151)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==55 || count_horiz==70 || count_horiz==80 || count_horiz==85
														  || count_horiz==100 || count_horiz==115 || count_horiz==130));
aa = (count_verti>190 && count_verti<200 && (count_horiz==30 || count_horiz==95 || count_horiz==110));
bb=((count_verti==205 && ((count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)))
   ||(count_verti>200 && count_verti<205&&(count_horiz==145|| count_horiz==152||count_horiz==158))
	||(count_verti>205 && count_verti<210&&(count_horiz==163))
	||(count_verti>200 && count_verti<210&&(count_horiz==150||count_horiz==157)));
end
16'h1243 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)));
v = (count_verti==200 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>80 && count_horiz<90)||(count_horiz>100 && count_horiz<105)
									||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)));
y = (count_verti==210 && ((count_horiz>35 && count_horiz<45) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)||(count_horiz==111)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==65 
                                            || count_horiz==80 || count_horiz==95));
aa = (count_verti>190 && count_verti<200 && (count_horiz==30 || count_horiz==60 || count_horiz==75 || count_horiz==105));
bb = (((count_horiz==100 && count_verti==200)||(count_horiz==101 && count_verti==202)||(count_horiz==102 && count_verti==204)
     ||(count_horiz==103 && count_verti==206)||(count_horiz==104 && count_verti==208)||(count_horiz==105 && count_verti==210))
	  ||(count_verti>200 && count_verti<210 && (count_horiz==110||count_horiz==112||count_horiz==117||count_horiz==118||count_horiz==123)));
end
16'h1344 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)));
v = (count_verti==200 && ((count_horiz>55 && count_horiz<60)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                         ||(count_horiz>83 && count_horiz<88)));
y = (count_verti==210 && ((count_horiz>40 && count_horiz<50)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                          ||(count_horiz>83 && count_horiz<88)||(count_horiz==76)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==25 || count_horiz==30 || count_horiz==35 
                                            || count_horiz==40 || count_horiz==55));
aa = ((count_horiz==65 && count_verti==190)||(count_horiz==64 && count_verti==192)||(count_horiz==63 && count_verti==194)
     ||(count_horiz==62 && count_verti==196)||(count_horiz==61 && count_verti==198)||(count_horiz==60 && count_verti==200));
bb = (((count_horiz==60 && count_verti==200)||(count_horiz==61 && count_verti==202)||(count_horiz==62 && count_verti==204)
     ||(count_horiz==63 && count_verti==206)||(count_horiz==64 && count_verti==208)||(count_horiz==65 && count_verti==210))
	  ||(count_verti==205&&((count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)))
	  ||(count_verti>200 && count_verti<210 &&  count_horiz==75)
	  ||(count_verti>200 && count_verti<205 && (count_horiz==82||count_horiz==83))
	  ||(count_verti>205 && count_verti<210 && (count_horiz==77||count_horiz==88)));
end
16'h2133 : begin
u = (count_verti==190 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>115&& count_horiz<125)));
v = (count_verti==200 && ((count_horiz>40 && count_horiz<50)||(count_horiz>75 && count_horiz<80)||(count_horiz>85 && count_horiz<95)
								   ||(count_horiz>100 && count_horiz<110)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
y = (count_verti==210 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>85&& count_horiz<95) || (count_horiz==136)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==25 || count_horiz==40 || count_horiz==55 
                                            || count_horiz==70 || count_horiz==85|| count_horiz==100|| count_horiz==110
														  || count_horiz==115 || count_horiz==120|| count_horiz==125));
aa = (count_verti>190 && count_verti<200 && (count_horiz==80));
bb = (((count_horiz==75 && count_verti==200)||(count_horiz==76 && count_verti==202)||(count_horiz==77 && count_verti==204)
     ||(count_horiz==78 && count_verti==206)||(count_horiz==79 && count_verti==208)||(count_horiz==80 && count_verti==210))
	  ||(count_verti==205 && count_horiz>130 && count_horiz<135)
	  ||(count_verti>200 && count_verti<210 && (count_horiz==137||count_horiz==142||count_horiz==143||count_horiz==148))
	  ||(count_verti>200 && count_verti<205 && count_horiz==130)
	  ||(count_verti>205 && count_verti<210 && count_horiz==135));
end
16'h2431 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90)));
v = (count_verti==200 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
y = (count_verti==210 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)||(count_horiz==96)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==75|| count_horiz==80|| count_horiz==90));
aa = (count_verti>190 && count_verti<200 && (count_horiz==45));
bb = (((count_horiz==40 && count_verti==200)||(count_horiz==41 && count_verti==202)||(count_horiz==42 && count_verti==204)
     ||(count_horiz==43 && count_verti==206)||(count_horiz==44 && count_verti==208)||(count_horiz==45 && count_verti==210))
	  ||(count_verti==205 && ((count_horiz>97&&count_horiz<102)))
	  ||(count_verti>200 && count_verti<210 && (count_horiz==95||count_horiz==103||count_horiz==108))
	  ||(count_verti>200 && count_verti<205 && count_horiz==97)
	  ||(count_verti>205 && count_verti<210 && count_horiz==102));
end
16'h1411 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>110&& count_horiz<120) || (count_horiz>125&& count_horiz<135)
									|| (count_horiz>140&& count_horiz<150)));
v = (count_verti==200 && ((count_horiz>35 && count_horiz<45)||(count_horiz>110 && count_horiz<120)||(count_horiz>140 && count_horiz<150)
                           ||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)));
y = (count_verti==210 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)
									|| (count_horiz>140&& count_horiz<150)||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)
									||(count_horiz==161)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==60 || count_horiz==65 || count_horiz==80 || count_horiz==90
														  || count_horiz==95 || count_horiz==110 || count_horiz==120|| count_horiz==130|| count_horiz==140));
aa = (count_verti==205 && count_horiz>155 && count_horiz<160);
bb=((count_verti>200 && count_verti<210 && (count_horiz==160||count_horiz==162||count_horiz==167||count_horiz==168||count_horiz==173))
    ||(count_verti>200&&count_verti<205&&count_horiz==155));
end
16'h2321 : begin
u = (count_verti==190 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)));
v = (count_verti==200 && ((count_horiz>25 && count_horiz<30)||(count_horiz>55 && count_horiz<65)
                          ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
y = (count_verti==210 && ((count_horiz>40 && count_horiz<50)||(count_horiz>55 && count_horiz<65) || (count_horiz==76)
                           ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
z = (count_verti>190 && count_verti<210 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40|| count_horiz==55));
aa = (count_verti>190 && count_verti<200 && (count_horiz==30));
bb = (((count_horiz==25 && count_verti==200)||(count_horiz==26 && count_verti==202)||(count_horiz==27 && count_verti==204)
     ||(count_horiz==28 && count_verti==206)||(count_horiz==29 && count_verti==208)||(count_horiz==30 && count_verti==210))
	  ||(count_verti==205 && count_horiz>70 && count_horiz<75)
	  ||(count_verti>200 && count_verti<210 && (count_horiz==77||count_horiz==82||count_horiz==83||count_horiz==88)
	  ||(count_verti>200 && count_verti<205 && count_horiz==70)
	  ||(count_verti>205 && count_verti<210 && count_horiz==75)));
end
endcase
end 

always @(posedge CLK_25MHz)
begin
case (product5)
16'h0000 : begin
cc = 0;
dd = 0;
ee = 0;
ff = 0;
gg = 0;
hh = 0;
end
16'h3124 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<55)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<85) || (count_horiz>95 && count_horiz<105)));
dd = (count_verti==230 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<105)
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>123 && count_horiz<128)));
ee = (count_verti==240 && ((count_horiz>20 && count_horiz<30) || (count_horiz>55 && count_horiz<60)
                           || (count_horiz>85 && count_horiz<90) || (count_horiz==116) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>123 && count_horiz<128) ));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 || count_horiz==30 || count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 || count_horiz==80 
														  || count_horiz==85 || count_horiz==90 || count_horiz==95 || count_horiz==105));
gg=(count_verti==235 && ((count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)));
hh=((count_verti>235 && count_verti<240 && (count_horiz==110 || count_horiz==122))
  ||(count_verti>230 && count_verti<235 && (count_horiz==115||count_horiz==117)) 
  ||(count_verti>230 && count_verti<240 && (count_horiz==123 || count_horiz==128)));
end
16'h4133 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
dd = (count_verti==230 && ((count_horiz>65 && count_horiz<75) || (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)
                          || (count_horiz>123 && count_horiz<128)));
ee = (count_verti==240 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115)
                           || (count_horiz>123 && count_horiz<128) ||(count_horiz==116)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==25 ||  count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 
														  || count_horiz==85 || count_horiz==95 || count_horiz==105));
gg=((count_verti>230 && count_verti<235 && count_horiz==123)||(count_verti>235 && count_verti<240 && count_horiz==128));
hh=((count_verti>230 && count_verti<240 && ((count_horiz==110)||(count_horiz==115)||(count_horiz==122)))
    ||(count_verti==235&& count_horiz>123 && count_horiz<128));;
end
16'h4132 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
dd = (count_verti==230 && ((count_horiz>20 && count_horiz<30)||(count_horiz>65 && count_horiz<75)||(count_horiz>110 && count_horiz<115)
                            ||(count_horiz>117 && count_horiz<122) ||(count_horiz>123 && count_horiz<128)));
ee = (count_verti==240 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115) 
                            || (count_horiz>117 && count_horiz<122) || (count_horiz>123 && count_horiz<128) || (count_horiz==116)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 || count_horiz==55 
                                            || count_horiz==65 || count_horiz==75 || count_horiz==85 || count_horiz==95 || count_horiz==105));
gg = (count_verti>220 && count_verti<230 && (count_horiz==30));
hh=(((count_verti>230 && count_verti<240 && (count_horiz==110 || count_horiz==115 || count_horiz==123 || count_horiz==128))
    ||(count_verti>230 && count_verti<235 && count_horiz==117)||(count_verti>235 && count_verti<240 && count_horiz==122))
	 ||(count_verti==235&&count_horiz>117&&count_horiz<122));
end
16'h3121 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75)));
dd = (count_verti==230 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>95 && count_horiz<100)||(count_horiz>102 && count_horiz<107)
									||(count_horiz>108 && count_horiz<113)));
ee = (count_verti==240 && ((count_horiz>35 && count_horiz<45) || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<100)
                           || (count_horiz>102 && count_horiz<107) || (count_horiz>108 && count_horiz<113)|| (count_horiz==101)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==60 
                                            || count_horiz==65 || count_horiz==80 || count_horiz==90));
gg = (count_verti>220 && count_verti<230 && (count_horiz==30));
hh=(((count_verti>230 && count_verti<235 && count_horiz==100)||(count_verti>235 && count_verti<240 && count_horiz==95)
     ||(count_verti>230 && count_verti<240 && (count_horiz==102||count_horiz==107||count_horiz==108||count_horiz==113)))
	  ||(count_verti==235 && count_horiz>95 && count_horiz<100));
end
16'h3133 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>80 && count_horiz<90)));
dd = (count_verti==230 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
ee = (count_verti==240 && ((count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90)|| (count_horiz>97 && count_horiz<102)
                            || (count_horiz>103 && count_horiz<108) ||(count_horiz==96)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==80));
gg = (count_verti>220 && count_verti<230 && (count_horiz==45 || count_horiz==60));
hh=(count_verti>230 && count_verti<240 && (count_horiz==95 || count_horiz==97 || count_horiz==102 || count_horiz==103 || count_horiz==108));
end
16'h3214 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>130&& count_horiz<140)));
dd = (count_verti==230 && ((count_horiz>20 && count_horiz<30)||(count_horiz>55 && count_horiz<65)||(count_horiz>70 && count_horiz<80)
								   ||(count_horiz>85 && count_horiz<95)||(count_horiz>105 && count_horiz<110)||(count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)));
ee = (count_verti==240 && ((count_horiz>45 && count_horiz<50) || (count_horiz>55 && count_horiz<65)|| (count_horiz>115 && count_horiz<125) 
                           || (count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)
									|| (count_horiz==151)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==55 || count_horiz==70 || count_horiz==80 || count_horiz==85
														  || count_horiz==100 || count_horiz==115 || count_horiz==130));
gg = (count_verti>220 && count_verti<230 && (count_horiz==30 || count_horiz==95 || count_horiz==110));
hh=((count_verti==235 && ((count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)))
   ||(count_verti>230 && count_verti<235&&(count_horiz==145|| count_horiz==152||count_horiz==158))
	||(count_verti>235 && count_verti<240&&(count_horiz==163))
	||(count_verti>230 && count_verti<240&&(count_horiz==150||count_horiz==157)));
end
16'h1243 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)));
dd = (count_verti==230 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>80 && count_horiz<90)||(count_horiz>100 && count_horiz<105)
									||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)));
ee = (count_verti==240 && ((count_horiz>35 && count_horiz<45) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)||(count_horiz==111)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==65 
                                            || count_horiz==80 || count_horiz==95));
gg = (count_verti>220 && count_verti<230 && (count_horiz==30 || count_horiz==60 || count_horiz==75 || count_horiz==105));
hh = (((count_horiz==100 && count_verti==230)||(count_horiz==101 && count_verti==232)||(count_horiz==102 && count_verti==234)
     ||(count_horiz==103 && count_verti==236)||(count_horiz==104 && count_verti==238)||(count_horiz==105 && count_verti==240))
	  ||(count_verti>230 && count_verti<240 && (count_horiz==110||count_horiz==112||count_horiz==117||count_horiz==118||count_horiz==123)));
end
16'h1344 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)));
dd = (count_verti==230 && ((count_horiz>55 && count_horiz<60)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                         ||(count_horiz>83 && count_horiz<88)));
ee = (count_verti==240 && ((count_horiz>40 && count_horiz<50)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                          ||(count_horiz>83 && count_horiz<88)||(count_horiz==76)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==25 || count_horiz==30 || count_horiz==35 
                                            || count_horiz==40 || count_horiz==55));
gg = ((count_horiz==65 && count_verti==220)||(count_horiz==64 && count_verti==222)||(count_horiz==63 && count_verti==224)
     ||(count_horiz==62 && count_verti==226)||(count_horiz==61 && count_verti==228)||(count_horiz==60 && count_verti==230));
hh = (((count_horiz==60 && count_verti==230)||(count_horiz==61 && count_verti==232)||(count_horiz==62 && count_verti==234)
     ||(count_horiz==63 && count_verti==236)||(count_horiz==64 && count_verti==238)||(count_horiz==65 && count_verti==240))
	  ||(count_verti==235&&((count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)))
	  ||(count_verti>230 && count_verti<240 &&  count_horiz==75)
	  ||(count_verti>230 && count_verti<235 && (count_horiz==82||count_horiz==83))
	  ||(count_verti>235 && count_verti<240 && (count_horiz==77||count_horiz==88)));
end
16'h2133 : begin
cc = (count_verti==220 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>115&& count_horiz<125)));
dd = (count_verti==230 && ((count_horiz>40 && count_horiz<50)||(count_horiz>75 && count_horiz<80)||(count_horiz>85 && count_horiz<95)
								   ||(count_horiz>100 && count_horiz<110)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
ee = (count_verti==240 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>85&& count_horiz<95) || (count_horiz==136)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==25 || count_horiz==40 || count_horiz==55 
                                            || count_horiz==70 || count_horiz==85|| count_horiz==100|| count_horiz==110
														  || count_horiz==115 || count_horiz==120|| count_horiz==125));
gg = (count_verti>220 && count_verti<230 && (count_horiz==80));
hh = (((count_horiz==75 && count_verti==230)||(count_horiz==76 && count_verti==232)||(count_horiz==77 && count_verti==234)
     ||(count_horiz==78 && count_verti==236)||(count_horiz==79 && count_verti==238)||(count_horiz==80 && count_verti==240))
	  ||(count_verti==235 && count_horiz>130 && count_horiz<135)
	  ||(count_verti>230 && count_verti<240 && (count_horiz==137||count_horiz==142||count_horiz==143||count_horiz==148))
	  ||(count_verti>230 && count_verti<235 && count_horiz==130)
	  ||(count_verti>235 && count_verti<240 && count_horiz==135));
end
16'h2431 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90)));
dd = (count_verti==230 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)));
ee = (count_verti==240 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)||(count_horiz==96)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==75|| count_horiz==80|| count_horiz==90));
gg = (count_verti>220 && count_verti<230 && (count_horiz==45));
hh = (((count_horiz==40 && count_verti==230)||(count_horiz==41 && count_verti==232)||(count_horiz==42 && count_verti==234)
     ||(count_horiz==43 && count_verti==236)||(count_horiz==44 && count_verti==238)||(count_horiz==45 && count_verti==240))
	  ||(count_verti==235 && ((count_horiz>97&&count_horiz<102)))
	  ||(count_verti>230 && count_verti<240 && (count_horiz==95||count_horiz==103||count_horiz==108))
	  ||(count_verti>230 && count_verti<235 && count_horiz==97)
	  ||(count_verti>235 && count_verti<240 && count_horiz==102));
end
16'h1411 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>110&& count_horiz<120) || (count_horiz>125&& count_horiz<135)
									|| (count_horiz>140&& count_horiz<150)));
dd = (count_verti==230 && ((count_horiz>35 && count_horiz<45)||(count_horiz>110 && count_horiz<120)||(count_horiz>140 && count_horiz<150)
                           ||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)));
ee = (count_verti==240 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)
									|| (count_horiz>140&& count_horiz<150)||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)
									||(count_horiz==161)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==60 || count_horiz==65 || count_horiz==80 || count_horiz==90
														  || count_horiz==95 || count_horiz==110 || count_horiz==120|| count_horiz==130|| count_horiz==140));
gg = (count_verti==235 && count_horiz>155 && count_horiz<160);
hh=((count_verti>230 && count_verti<240 && (count_horiz==160||count_horiz==162||count_horiz==167||count_horiz==168||count_horiz==173))
    ||(count_verti>230&&count_verti<235&&count_horiz==155));
end
16'h2321 : begin
cc = (count_verti==220 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)));
dd = (count_verti==230 && ((count_horiz>25 && count_horiz<30)||(count_horiz>55 && count_horiz<65)
                          ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
ee = (count_verti==240 && ((count_horiz>40 && count_horiz<50)||(count_horiz>55 && count_horiz<65) || (count_horiz==76)
                           ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
ff = (count_verti>220 && count_verti<240 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40|| count_horiz==55));
gg = (count_verti>220 && count_verti<230 && (count_horiz==30));
hh = (((count_horiz==25 && count_verti==230)||(count_horiz==26 && count_verti==232)||(count_horiz==27 && count_verti==234)
     ||(count_horiz==28 && count_verti==236)||(count_horiz==29 && count_verti==238)||(count_horiz==30 && count_verti==240))
	  ||(count_verti==235 && count_horiz>70 && count_horiz<75)
	  ||(count_verti>230 && count_verti<240 && (count_horiz==77||count_horiz==82||count_horiz==83||count_horiz==88)
	  ||(count_verti>230 && count_verti<235 && count_horiz==70)
	  ||(count_verti>235 && count_verti<240 && count_horiz==75)));
end
endcase
end 

always @(posedge CLK_25MHz)
begin
case (product6)
16'h0000 : begin
jj = 0;
kk = 0;
ll = 0;
mm = 0;
nn = 0;
oo = 0;
end
16'h3124 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<55)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<85) || (count_horiz>95 && count_horiz<105)));
kk = (count_verti==260 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<105)
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>123 && count_horiz<128)));
ll = (count_verti==270 && ((count_horiz>20 && count_horiz<30) || (count_horiz>55 && count_horiz<60)
                           || (count_horiz>85 && count_horiz<90) || (count_horiz==116) || (count_horiz>117 && count_horiz<122) 
									|| (count_horiz>110 && count_horiz<115) || (count_horiz>123 && count_horiz<128) ));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 || count_horiz==30 || count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 || count_horiz==80 
														  || count_horiz==85 || count_horiz==90 || count_horiz==95 || count_horiz==105));
nn=(count_verti==265 && ((count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)));
oo=((count_verti>265 && count_verti<270 && (count_horiz==110 || count_horiz==122))
  ||(count_verti>260 && count_verti<265 && (count_horiz==115||count_horiz==117)) 
  ||(count_verti>260 && count_verti<270 && (count_horiz==123 || count_horiz==128)));
end
16'h4133 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
kk = (count_verti==260 && ((count_horiz>65 && count_horiz<75) || (count_horiz>110 && count_horiz<115) || (count_horiz>117 && count_horiz<122)
                          || (count_horiz>123 && count_horiz<128)));
ll = (count_verti==270 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115)
                           || (count_horiz>123 && count_horiz<128) ||(count_horiz==116)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==25 ||  count_horiz==35 || count_horiz==45 || count_horiz==50 
                                            || count_horiz==55 || count_horiz==60 || count_horiz==65 || count_horiz==75 
														  || count_horiz==85 || count_horiz==95 || count_horiz==105));
nn=((count_verti>260 && count_verti<265 && count_horiz==123)||(count_verti>265 && count_verti<270 && count_horiz==128));
oo=((count_verti>260 && count_verti<270 && ((count_horiz==110)||(count_horiz==115)||(count_horiz==122)))
   ||(count_verti==265&& count_horiz>123 && count_horiz<128));
end
16'h4132 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90) || (count_horiz>95 && count_horiz<105)));
kk = (count_verti==260 && ((count_horiz>20 && count_horiz<30)||(count_horiz>65 && count_horiz<75)||(count_horiz>110 && count_horiz<115)
                            ||(count_horiz>117 && count_horiz<122) ||(count_horiz>123 && count_horiz<128)));
ll = (count_verti==270 && ((count_horiz>35 && count_horiz<45) || (count_horiz>95 && count_horiz<105) || (count_horiz>110 && count_horiz<115) 
                            || (count_horiz>117 && count_horiz<122) || (count_horiz>123 && count_horiz<128) || (count_horiz==116)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 || count_horiz==55 
                                            || count_horiz==65 || count_horiz==75 || count_horiz==85 || count_horiz==95 || count_horiz==105));
nn = (count_verti>250 && count_verti<260 && (count_horiz==30));
oo=(((count_verti>260 && count_verti<270 && (count_horiz==110 || count_horiz==115 || count_horiz==123 || count_horiz==128))
    ||(count_verti>260 && count_verti<265 && count_horiz==117)||(count_verti>265 && count_verti<270 && count_horiz==122))
	 ||(count_verti==265&&count_horiz>117&&count_horiz<122));
end
16'h3121 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65 && count_horiz<75)));
kk = (count_verti==260 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>95 && count_horiz<100)||(count_horiz>102 && count_horiz<107)
									||(count_horiz>108 && count_horiz<113)));
ll = (count_verti==270 && ((count_horiz>35 && count_horiz<45) || (count_horiz>65 && count_horiz<75) || (count_horiz>95 && count_horiz<100)
                           || (count_horiz>102 && count_horiz<107) || (count_horiz>108 && count_horiz<113)|| (count_horiz==101)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==60 
                                            || count_horiz==65 || count_horiz==80 || count_horiz==90));
nn = (count_verti>250 && count_verti<260 && (count_horiz==30));
oo=(((count_verti>260 && count_verti<265 && count_horiz==100)||(count_verti>265 && count_verti<270 && count_horiz==95)
     ||(count_verti>260 && count_verti<270 && (count_horiz==102||count_horiz==107||count_horiz==108||count_horiz==113)))
	  ||(count_verti==265 && count_horiz>95 && count_horiz<100));
end
16'h3133 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>80 && count_horiz<90)));
kk = (count_verti==260 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>80 && count_horiz<90)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
ll = (count_verti==270 && ((count_horiz>65 && count_horiz<75) || (count_horiz>80 && count_horiz<90)|| (count_horiz>97 && count_horiz<102)
                            || (count_horiz>103 && count_horiz<108) ||(count_horiz==96)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==80));
nn = (count_verti>250 && count_verti<260 && (count_horiz==45 || count_horiz==60));
oo=(count_verti>260 && count_verti<270 && (count_horiz==95 || count_horiz==97 || count_horiz==102 || count_horiz==103 || count_horiz==108));
end
16'h3214 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>130&& count_horiz<140)));
kk = (count_verti==260 && ((count_horiz>20 && count_horiz<30)||(count_horiz>55 && count_horiz<65)||(count_horiz>70 && count_horiz<80)
								   ||(count_horiz>85 && count_horiz<95)||(count_horiz>105 && count_horiz<110)||(count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)));
ll = (count_verti==270 && ((count_horiz>45 && count_horiz<50) || (count_horiz>55 && count_horiz<65)|| (count_horiz>115 && count_horiz<125) 
                           || (count_horiz>130 && count_horiz<140)
									||(count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)
									|| (count_horiz==151)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==55 || count_horiz==70 || count_horiz==80 || count_horiz==85
														  || count_horiz==100 || count_horiz==115 || count_horiz==130));
nn = (count_verti>250 && count_verti<260 && (count_horiz==30 || count_horiz==95 || count_horiz==110));
oo=((count_verti==265 && ((count_horiz>145 && count_horiz<150)||(count_horiz>152 && count_horiz<157)||(count_horiz>158 && count_horiz<163)))
   ||(count_verti>260 && count_verti<265&&(count_horiz==145|| count_horiz==152||count_horiz==158))
	||(count_verti>265 && count_verti<270&&(count_horiz==163))
	||(count_verti>260 && count_verti<270&&(count_horiz==150||count_horiz==157)));
end
16'h1243 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)));
kk = (count_verti==260 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>80 && count_horiz<90)||(count_horiz>100 && count_horiz<105)
									||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)));
ll = (count_verti==270 && ((count_horiz>35 && count_horiz<45) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>112 && count_horiz<117)||(count_horiz>118 && count_horiz<123)||(count_horiz==111)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==35 || count_horiz==50 || count_horiz==65 
                                            || count_horiz==80 || count_horiz==95));
nn = (count_verti>250 && count_verti<260 && (count_horiz==30 || count_horiz==60 || count_horiz==75 || count_horiz==105));
oo = (((count_horiz==100 && count_verti==260)||(count_horiz==101 && count_verti==262)||(count_horiz==102 && count_verti==264)
     ||(count_horiz==103 && count_verti==266)||(count_horiz==104 && count_verti==268)||(count_horiz==105 && count_verti==270))
	  ||(count_verti>260 && count_verti<270 && (count_horiz==110||count_horiz==112||count_horiz==117||count_horiz==118||count_horiz==123)));;
end
16'h1344 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)));
kk = (count_verti==260 && ((count_horiz>55 && count_horiz<60)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                         ||(count_horiz>83 && count_horiz<88)));
ll = (count_verti==270 && ((count_horiz>40 && count_horiz<50)||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)
                          ||(count_horiz>83 && count_horiz<88)||(count_horiz==76)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==25 || count_horiz==30 || count_horiz==35 
                                            || count_horiz==40 || count_horiz==55));
nn = ((count_horiz==65 && count_verti==250)||(count_horiz==64 && count_verti==252)||(count_horiz==63 && count_verti==254)
     ||(count_horiz==62 && count_verti==256)||(count_horiz==61 && count_verti==258)||(count_horiz==60 && count_verti==260));
oo = (((count_horiz==60 && count_verti==260)||(count_horiz==61 && count_verti==262)||(count_horiz==62 && count_verti==264)
     ||(count_horiz==63 && count_verti==266)||(count_horiz==64 && count_verti==268)||(count_horiz==65 && count_verti==270))
	  ||(count_verti==265&&((count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)))
	  ||(count_verti>260 && count_verti<270 &&  count_horiz==75)
	  ||(count_verti>260 && count_verti<265 && (count_horiz==82||count_horiz==83))
	  ||(count_verti>265 && count_verti<270 && (count_horiz==77||count_horiz==88)));
end
16'h2133 : begin
jj = (count_verti==250 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>70&& count_horiz<80) || (count_horiz>85&& count_horiz<95) || (count_horiz>100&& count_horiz<110)
									|| (count_horiz>115&& count_horiz<125)));
kk = (count_verti==260 && ((count_horiz>40 && count_horiz<50)||(count_horiz>75 && count_horiz<80)||(count_horiz>85 && count_horiz<95)
								   ||(count_horiz>100 && count_horiz<110)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
ll = (count_verti==270 && ((count_horiz>25 && count_horiz<35)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)
                           || (count_horiz>85&& count_horiz<95) || (count_horiz==136)
									||(count_horiz>130 && count_horiz<135)||(count_horiz>137 && count_horiz<142)||(count_horiz>143 && count_horiz<148)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==25 || count_horiz==40 || count_horiz==55 
                                            || count_horiz==70 || count_horiz==85|| count_horiz==100|| count_horiz==110
														  || count_horiz==115 || count_horiz==120|| count_horiz==125));
nn = (count_verti>250 && count_verti<260 && (count_horiz==80));
oo = (((count_horiz==75 && count_verti==260)||(count_horiz==76 && count_verti==262)||(count_horiz==77 && count_verti==264)
     ||(count_horiz==78 && count_verti==266)||(count_horiz==79 && count_verti==268)||(count_horiz==80 && count_verti==270))
	  ||(count_verti==265 && count_horiz>130 && count_horiz<135)
	  ||(count_verti>260 && count_verti<270 && (count_horiz==137||count_horiz==142||count_horiz==143||count_horiz==148))
	  ||(count_verti>260 && count_verti<265 && count_horiz==130)
	  ||(count_verti>265 && count_verti<270 && count_horiz==135));
end
16'h2431 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>35 && count_horiz<45) || (count_horiz>50 && count_horiz<60)
                           || (count_horiz>65&& count_horiz<75) || (count_horiz>80&& count_horiz<90)));
kk = (count_verti==260 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<45)||(count_horiz>50 && count_horiz<60)
								   ||(count_horiz>65 && count_horiz<75)||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)));
ll = (count_verti==270 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>80 && count_horiz<90)
                           ||(count_horiz>97 && count_horiz<102)||(count_horiz>103 && count_horiz<108)||(count_horiz==96)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==30 || count_horiz==35 || count_horiz==50 
                                            || count_horiz==65 || count_horiz==75|| count_horiz==80|| count_horiz==90));
nn = (count_verti>250 && count_verti<260 && (count_horiz==45));
oo = (((count_horiz==40 && count_verti==260)||(count_horiz==41 && count_verti==262)||(count_horiz==42 && count_verti==264)
     ||(count_horiz==43 && count_verti==266)||(count_horiz==44 && count_verti==268)||(count_horiz==45 && count_verti==270))
	  ||(count_verti==265 && ((count_horiz>97&&count_horiz<102)))
	  ||(count_verti>260 && count_verti<270 && (count_horiz==95||count_horiz==103||count_horiz==108))
	  ||(count_verti>260 && count_verti<265 && count_horiz==97)
	  ||(count_verti>265 && count_verti<270 && count_horiz==102));
end
16'h1411 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>110&& count_horiz<120) || (count_horiz>125&& count_horiz<135)
									|| (count_horiz>140&& count_horiz<150)));
kk = (count_verti==260 &&((count_horiz>35 && count_horiz<45)||(count_horiz>110 && count_horiz<120)||(count_horiz>140 && count_horiz<150)
                           ||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)));
ll = (count_verti==270 && ((count_horiz>20 && count_horiz<30)||(count_horiz>50 && count_horiz<60) || (count_horiz>65 && count_horiz<75)
                           || (count_horiz>80&& count_horiz<90) || (count_horiz>95&& count_horiz<105)
									|| (count_horiz>140&& count_horiz<150)||(count_horiz>162 && count_horiz<167)||(count_horiz>168 && count_horiz<173)
									||(count_horiz==161)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==35 || count_horiz==45 
                                            || count_horiz==50 || count_horiz==60 || count_horiz==65 || count_horiz==80 || count_horiz==90
														  || count_horiz==95 || count_horiz==110 || count_horiz==120|| count_horiz==130|| count_horiz==140));
nn = (count_verti==265 && count_horiz>155 && count_horiz<160);
oo=((count_verti>260 && count_verti<270 && (count_horiz==160||count_horiz==162||count_horiz==167||count_horiz==168||count_horiz==173))
    ||(count_verti>260&&count_verti<265&&count_horiz==155));
end
16'h2321 : begin
jj = (count_verti==250 && ((count_horiz>20 && count_horiz<30)||(count_horiz>40 && count_horiz<50) || (count_horiz>55 && count_horiz<65)));
kk = (count_verti==260 && ((count_horiz>25 && count_horiz<30)||(count_horiz>55 && count_horiz<65)
                          ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
ll = (count_verti==270 && ((count_horiz>40 && count_horiz<50)||(count_horiz>55 && count_horiz<65) || (count_horiz==76)
                           ||(count_horiz>70 && count_horiz<75)||(count_horiz>77 && count_horiz<82)||(count_horiz>83 && count_horiz<88)));
mm = (count_verti>250 && count_verti<270 && (count_horiz==20 ||  count_horiz==35 || count_horiz==40|| count_horiz==55));
nn = (count_verti>250 && count_verti<260 && (count_horiz==30));
oo = (((count_horiz==25 && count_verti==260)||(count_horiz==26 && count_verti==262)||(count_horiz==27 && count_verti==264)
     ||(count_horiz==28 && count_verti==266)||(count_horiz==29 && count_verti==268)||(count_horiz==30 && count_verti==270))
	  ||(count_verti==265 && count_horiz>70 && count_horiz<75)
	  ||(count_verti>260 && count_verti<270 && (count_horiz==77||count_horiz==82||count_horiz==83||count_horiz==88)
	  ||(count_verti>260 && count_verti<265 && count_horiz==70)
	  ||(count_verti>265 && count_verti<270 && count_horiz==75)));
end
endcase
end 

//binarytoBCD converter

reg [19:0] bcd;
reg [3:0] i;

initial begin
bcd=0;
end

always @(sum) begin
            bcd = 0; //initialize bcd to zero.
            for (i = 0; i < 15; i = i+1) //run for 8 iterations
            begin
                bcd = {bcd[18:0],sum[14-i]}; //concatenation
                    
                //if a hex digit of 'bcd' is more than 4, add 3 to it.  
                if(i < 14 && bcd[3:0] > 4) 
                    bcd[3:0] = bcd[3:0] + 3;
                if(i < 14 && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 3;
                if(i < 14 && bcd[11:8] > 4)
                    bcd[11:8] = bcd[11:8] + 3; 
					if(i < 14 && bcd[15:12] > 4)
                    bcd[15:12] = bcd[15:12] + 3; 
					 if(i < 14 && bcd[19:16] > 4)
                    bcd[19:16] = bcd[19:16] + 3; 
            end   
end 

reg a0,a1,a2,a3,a4,a5,a6,a7;
reg b0,b1,b2,b3,b4,b5,b6,b7;
reg c0,c1,c2,c3,c4,c5,c6,c7;
reg d0,d1,d2,d3,d4,d5,d6,d7;
reg e0,e1,e2,e3,e4,e5,e6,e7;
reg f0,f1,f2,f3,f4,f5,f6,f7;
reg g0,g1,g2,g3,g4,g5,g6,g7;
reg h0,h1,h2,h3,h4,h5,h6,h7;
reg j0,j1,j2,j3,j4,j5,j6,j7;
reg k0,k1,k2,k3,k4,k5,k6,k7;
reg dot;

always @(posedge CLK_25MHz)
begin
case (bcd [19:16])
0: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = (count_verti == 420 && (count_horiz >20 && count_horiz<30));
a4 = (count_horiz == 20 && (count_verti >410 && count_verti<420));
a5 = (count_horiz == 20 && (count_verti >400 && count_verti<410));
a6 = 0;
end
1: begin
a0 = 0;
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = 0;
a4 = 0;
a5 = 0;
a6 = 0;
end
2: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = 0;
a3 = (count_verti == 420 && (count_horiz >20 && count_horiz<30));
a4 = (count_horiz == 20 && (count_verti >410 && count_verti<420));
a5 = 0;
a6 = (count_verti == 410 && (count_horiz >20 && count_horiz<30));
end
3: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = (count_verti == 420 && (count_horiz >20 && count_horiz<30));
a4 = 0;
a5 = 0;
a6 = (count_verti == 410 && (count_horiz >20 && count_horiz<30));
end
4: begin
a0 = 0;
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = 0;
a4 = 0;
a5 = (count_horiz == 20 && (count_verti >400 && count_verti<410));
a6 = (count_verti == 410 && (count_horiz >20 && count_horiz<30));
end
5: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = 0;
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = (count_verti == 420 && (count_horiz >20 && count_horiz<30));
a4 = 0;
a5 = (count_horiz == 20 && (count_verti >400 && count_verti<410));
a6 = (count_verti == 410 && (count_horiz >20 && count_horiz<30));
end
6: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = 0;
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = (count_verti == 420 && (count_horiz >20 && count_horiz<30));
a4 = (count_horiz == 20 && (count_verti >410 && count_verti<420));
a5 = (count_horiz == 20 && (count_verti >400 && count_verti<410));
a6 = (count_verti == 410 && (count_horiz >20 && count_horiz<30));
end
7: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = 0;
a4 = 0;
a5 = 0;
a6 = 0;
end
8: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = (count_verti == 420 && (count_horiz >20 && count_horiz<30));
a4 = (count_horiz == 20 && (count_verti >410 && count_verti<420));
a5 = (count_horiz == 20 && (count_verti >400 && count_verti<410));
a6 = (count_verti == 410 && (count_horiz >20 && count_horiz<30));
end
9: begin
a0 = (count_verti == 400 && (count_horiz >20 && count_horiz<30));
a1 = (count_horiz == 30 && (count_verti >400 && count_verti<410));
a2 = (count_horiz == 30 && (count_verti >410 && count_verti<420));
a3 = (count_verti == 420 && (count_horiz >20 && count_horiz<30));
a4 = 0;
a5 = (count_horiz == 20 && (count_verti >400 && count_verti<410));
a6 = (count_verti == 410 && (count_horiz >20 && count_horiz<30));
end
endcase
end


always @(posedge CLK_25MHz)
begin
case (bcd [15:12])
0: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = (count_verti == 420 && (count_horiz >40 && count_horiz<50));
b4 = (count_horiz == 40 && (count_verti >410 && count_verti<420));
b5 = (count_horiz == 40 && (count_verti >400 && count_verti<410));
b6 = 0;
end
1: begin
b0 = 0;
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = 0;
b4 = 0;
b5 = 0;
b6 = 0;
end
2: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = 0;
b3 = (count_verti == 420 && (count_horiz >40 && count_horiz<50));
b4 = (count_horiz == 40 && (count_verti >410 && count_verti<420));
b5 = 0;
b6 = (count_verti == 410 && (count_horiz >40 && count_horiz<50));
end
3: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = (count_verti == 420 && (count_horiz >40 && count_horiz<50));
b4 = 0;
b5 = 0;
b6 = (count_verti == 410 && (count_horiz >40 && count_horiz<50));
end
4: begin
b0 = 0;
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = 0;
b4 = 0;
b5 = (count_horiz == 40 && (count_verti >400 && count_verti<410));
b6 = (count_verti == 410 && (count_horiz >40 && count_horiz<50));
end
5: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = 0;
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = (count_verti == 420 && (count_horiz >40 && count_horiz<50));
b4 = 0;
b5 = (count_horiz == 40 && (count_verti >400 && count_verti<410));
b6 = (count_verti == 410 && (count_horiz >40 && count_horiz<50));
end
6: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = 0;
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = (count_verti == 420 && (count_horiz >40 && count_horiz<50));
b4 = (count_horiz == 40 && (count_verti >410 && count_verti<420));
b5 = (count_horiz == 40 && (count_verti >400 && count_verti<410));
b6 = (count_verti == 410 && (count_horiz >40 && count_horiz<50));
end
7: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = 0;
b4 = 0;
b5 = 0;
b6 = 0;
end
8: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = (count_verti == 420 && (count_horiz >40 && count_horiz<50));
b4 = (count_horiz == 40 && (count_verti >410 && count_verti<420));
b5 = (count_horiz == 40 && (count_verti >400 && count_verti<410));
b6 = (count_verti == 410 && (count_horiz >40 && count_horiz<50));
end
9: begin
b0 = (count_verti == 400 && (count_horiz >40 && count_horiz<50));
b1 = (count_horiz == 50 && (count_verti >400 && count_verti<410));
b2 = (count_horiz == 50 && (count_verti >410 && count_verti<420));
b3 = (count_verti == 420 && (count_horiz >40 && count_horiz<50));
b4 = 0;
b5 = (count_horiz == 40 && (count_verti >400 && count_verti<410));
b6 = (count_verti == 410 && (count_horiz >40 && count_horiz<50));
end
endcase
end

always @(posedge CLK_25MHz)
begin
case (bcd [11:8])
0: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = (count_verti == 420 && (count_horiz >60 && count_horiz<70));
c4 = (count_horiz == 60 && (count_verti >410 && count_verti<420));
c5 = (count_horiz == 60 && (count_verti >400 && count_verti<410));
c6 = 0;
end
1: begin
c0 = 0;
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = 0;
c4 = 0;
c5 = 0;
c6 = 0;
end
2: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = 0;
c3 = (count_verti == 420 && (count_horiz >60 && count_horiz<70));
c4 = (count_horiz == 60 && (count_verti >410 && count_verti<420));
c5 = 0;
c6 = (count_verti == 410 && (count_horiz >60 && count_horiz<70));
end
3: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = (count_verti == 420 && (count_horiz >60 && count_horiz<70));
c4 = 0;
c5 = 0;
c6 = (count_verti == 410 && (count_horiz >60 && count_horiz<70));
end
4: begin
c0 = 0;
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = 0;
c4 = 0;
c5 = (count_horiz == 60 && (count_verti >400 && count_verti<410));
c6 = (count_verti == 410 && (count_horiz >60 && count_horiz<70));
end
5: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = 0;
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = (count_verti == 420 && (count_horiz >60 && count_horiz<70));
c4 = 0;
c5 = (count_horiz == 60 && (count_verti >400 && count_verti<410));
c6 = (count_verti == 410 && (count_horiz >60 && count_horiz<70));
end
6: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = 0;
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = (count_verti == 420 && (count_horiz >60 && count_horiz<70));
c4 = (count_horiz == 60 && (count_verti >410 && count_verti<420));
c5 = (count_horiz == 60 && (count_verti >400 && count_verti<410));
c6 = (count_verti == 410 && (count_horiz >60 && count_horiz<70));
end
7: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = 0;
c4 = 0;
c5 = 0;
c6 = 0;
end
8: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = (count_verti == 420 && (count_horiz >60 && count_horiz<70));
c4 = (count_horiz == 60 && (count_verti >410 && count_verti<420));
c5 = (count_horiz == 60 && (count_verti >400 && count_verti<410));
c6 = (count_verti == 410 && (count_horiz >60 && count_horiz<70));
end
9: begin
c0 = (count_verti == 400 && (count_horiz >60 && count_horiz<70));
c1 = (count_horiz == 70 && (count_verti >400 && count_verti<410));
c2 = (count_horiz == 70 && (count_verti >410 && count_verti<420));
c3 = (count_verti == 420 && (count_horiz >60 && count_horiz<70));
c4 = 0;
c5 = (count_horiz == 60 && (count_verti >400 && count_verti<410));
c6 = (count_verti == 410 && (count_horiz >60 && count_horiz<70));
end
endcase
end

always @(posedge CLK_25MHz)
begin
case (bcd [7:4])
0: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = (count_verti == 420 && (count_horiz >80 && count_horiz<90));
d4 = (count_horiz == 80 && (count_verti >410 && count_verti<420));
d5 = (count_horiz == 80 && (count_verti >400 && count_verti<410));
d6 = 0;
end
1: begin
d0 = 0;
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = 0;
d4 = 0;
d5 = 0;
d6 = 0;
end
2: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = 0;
d3 = (count_verti == 420 && (count_horiz >80 && count_horiz<90));
d4 = (count_horiz == 80 && (count_verti >410 && count_verti<420));
d5 = 0;
d6 = (count_verti == 410 && (count_horiz >80 && count_horiz<90));
end
3: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = (count_verti == 420 && (count_horiz >80 && count_horiz<90));
d4 = 0;
d5 = 0;
d6 = (count_verti == 410 && (count_horiz >80 && count_horiz<90));
end
4: begin
d0 = 0;
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = 0;
d4 = 0;
d5 = (count_horiz == 80 && (count_verti >400 && count_verti<410));
d6 = (count_verti == 410 && (count_horiz >80 && count_horiz<90));
end
5: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = 0;
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = (count_verti == 420 && (count_horiz >80 && count_horiz<90));
d4 = 0;
d5 = (count_horiz == 80 && (count_verti >400 && count_verti<410));
d6 = (count_verti == 410 && (count_horiz >80 && count_horiz<90));
end
6: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = 0;
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = (count_verti == 420 && (count_horiz >80 && count_horiz<90));
d4 = (count_horiz == 80 && (count_verti >410 && count_verti<420));
d5 = (count_horiz == 80 && (count_verti >400 && count_verti<410));
d6 = (count_verti == 410 && (count_horiz >80 && count_horiz<90));
end
7: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = 0;
d4 = 0;
d5 = 0;
d6 = 0;
end
8: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = (count_verti == 420 && (count_horiz >80 && count_horiz<90));
d4 = (count_horiz == 80 && (count_verti >410 && count_verti<420));
d5 = (count_horiz == 80 && (count_verti >400 && count_verti<410));
d6 = (count_verti == 410 && (count_horiz >80 && count_horiz<90));
end
9: begin
d0 = (count_verti == 400 && (count_horiz >80 && count_horiz<90));
d1 = (count_horiz == 90 && (count_verti >400 && count_verti<410));
d2 = (count_horiz == 90 && (count_verti >410 && count_verti<420));
d3 = (count_verti == 420 && (count_horiz >80 && count_horiz<90));
d4 = 0;
d5 = (count_horiz == 80 && (count_verti >400 && count_verti<410));
d6 = (count_verti == 410 && (count_horiz >80 && count_horiz<90));
end
endcase
end

always @(posedge CLK_25MHz)
begin
case (bcd [3:0])
0: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = (count_verti == 420 && (count_horiz >100 && count_horiz<110));
e4 = (count_horiz == 100 && (count_verti >410 && count_verti<420));
e5 = (count_horiz == 100 && (count_verti >400 && count_verti<410));
e6 = 0;
end
1: begin
e0 = 0;
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = 0;
e4 = 0;
e5 = 0;
e6 = 0;
end
2: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = 0;
e3 = (count_verti == 420 && (count_horiz >100 && count_horiz<110));
e4 = (count_horiz == 100 && (count_verti >410 && count_verti<420));
e5 = 0;
e6 = (count_verti == 410 && (count_horiz >100 && count_horiz<110));
end
3: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = (count_verti == 420 && (count_horiz >100 && count_horiz<110));
e4 = 0;
e5 = 0;
e6 = (count_verti == 410 && (count_horiz >100 && count_horiz<110));
end
4: begin
e0 = 0;
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = 0;
e4 = 0;
e5 = (count_horiz == 100 && (count_verti >400 && count_verti<410));
e6 = (count_verti == 410 && (count_horiz >100 && count_horiz<110));
end
5: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = 0;
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = (count_verti == 420 && (count_horiz >100 && count_horiz<110));
e4 = 0;
e5 = (count_horiz == 100 && (count_verti >400 && count_verti<410));
e6 = (count_verti == 410 && (count_horiz >100 && count_horiz<110));
end
6: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = 0;
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = (count_verti == 420 && (count_horiz >100 && count_horiz<110));
e4 = (count_horiz == 100 && (count_verti >410 && count_verti<420));
e5 = (count_horiz == 100 && (count_verti >400 && count_verti<410));
e6 = (count_verti == 410 && (count_horiz >100 && count_horiz<110));
end
7: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = 0;
e4 = 0;
e5 = 0;
e6 = 0;
end
8: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = (count_verti == 420 && (count_horiz >100 && count_horiz<110));
e4 = (count_horiz == 100 && (count_verti >410 && count_verti<420));
e5 = (count_horiz == 100 && (count_verti >400 && count_verti<410));
e6 = (count_verti == 410 && (count_horiz >100 && count_horiz<110));
end
9: begin
e0 = (count_verti == 400 && (count_horiz >100 && count_horiz<110));
e1 = (count_horiz == 110 && (count_verti >400 && count_verti<410));
e2 = (count_horiz == 110 && (count_verti >410 && count_verti<420));
e3 = (count_verti == 420 && (count_horiz >100 && count_horiz<110));
e4 = 0;
e5 = (count_horiz == 100 && (count_verti >400 && count_verti<410));
e6 = (count_verti == 410 && (count_horiz >100 && count_horiz<110));
end
endcase
end

			
always @(posedge CLK_25MHz)
begin
case (barcode [15:12])
0: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = (count_verti == 420 && (count_horiz >200 && count_horiz<210));
f4 = (count_horiz == 200 && (count_verti >410 && count_verti<420));
f5 = (count_horiz == 200 && (count_verti >400 && count_verti<410));
f6 = 0;
end
1: begin
f0 = 0;
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = 0;
f4 = 0;
f5 = 0;
f6 = 0;
end
2: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = 0;
f3 = (count_verti == 420 && (count_horiz >200 && count_horiz<210));
f4 = (count_horiz == 200 && (count_verti >410 && count_verti<420));
f5 = 0;
f6 = (count_verti == 410 && (count_horiz >200 && count_horiz<210));
end
3: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = (count_verti == 420 && (count_horiz >200 && count_horiz<210));
f4 = 0;
f5 = 0;
f6 = (count_verti == 410 && (count_horiz >200 && count_horiz<210));
end
4: begin
f0 = 0;
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = 0;
f4 = 0;
f5 = (count_horiz == 200 && (count_verti >400 && count_verti<410));
f6 = (count_verti == 410 && (count_horiz >200 && count_horiz<210));
end
5: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = 0;
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = (count_verti == 420 && (count_horiz >200 && count_horiz<210));
f4 = 0;
f5 = (count_horiz == 200 && (count_verti >400 && count_verti<410));
f6 = (count_verti == 410 && (count_horiz >200 && count_horiz<210));
end
6: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = 0;
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = (count_verti == 420 && (count_horiz >200 && count_horiz<210));
f4 = (count_horiz == 200 && (count_verti >410 && count_verti<420));
f5 = (count_horiz == 200 && (count_verti >400 && count_verti<410));
f6 = (count_verti == 410 && (count_horiz >200 && count_horiz<210));
end
7: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = 0;
f4 = 0;
f5 = 0;
f6 = 0;
end
8: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = (count_verti == 420 && (count_horiz >200 && count_horiz<210));
f4 = (count_horiz == 200 && (count_verti >410 && count_verti<420));
f5 = (count_horiz == 200 && (count_verti >400 && count_verti<410));
f6 = (count_verti == 410 && (count_horiz >200 && count_horiz<210));
end
9: begin
f0 = (count_verti == 400 && (count_horiz >200 && count_horiz<210));
f1 = (count_horiz == 210 && (count_verti >400 && count_verti<410));
f2 = (count_horiz == 210 && (count_verti >410 && count_verti<420));
f3 = (count_verti == 420 && (count_horiz >200 && count_horiz<210));
f4 = 0;
f5 = (count_horiz == 200 && (count_verti >400 && count_verti<410));
f6 = (count_verti == 410 && (count_horiz >200 && count_horiz<210));
end
endcase
end

always @(posedge CLK_25MHz)
begin
case (barcode [11:8])
0: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = (count_verti == 420 && (count_horiz >220 && count_horiz<230));
g4 = (count_horiz == 220 && (count_verti >410 && count_verti<420));
g5 = (count_horiz == 220 && (count_verti >400 && count_verti<410));
g6 = 0;
end
1: begin
g0 = 0;
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = 0;
g4 = 0;
g5 = 0;
g6 = 0;
end
2: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = 0;
g3 = (count_verti == 420 && (count_horiz >220 && count_horiz<230));
g4 = (count_horiz == 220 && (count_verti >410 && count_verti<420));
g5 = 0;
g6 = (count_verti == 410 && (count_horiz >220 && count_horiz<230));
end
3: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = (count_verti == 420 && (count_horiz >220 && count_horiz<230));
g4 = 0;
g5 = 0;
g6 = (count_verti == 410 && (count_horiz >220 && count_horiz<230));
end
4: begin
g0 = 0;
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = 0;
g4 = 0;
g5 = (count_horiz == 220 && (count_verti >400 && count_verti<410));
g6 = (count_verti == 410 && (count_horiz >220 && count_horiz<230));
end
5: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = 0;
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = (count_verti == 420 && (count_horiz >220 && count_horiz<230));
g4 = 0;
g5 = (count_horiz == 220 && (count_verti >400 && count_verti<410));
g6 = (count_verti == 410 && (count_horiz >220 && count_horiz<230));
end
6: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = 0;
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = (count_verti == 420 && (count_horiz >220 && count_horiz<230));
g4 = (count_horiz == 220 && (count_verti >410 && count_verti<420));
g5 = (count_horiz == 220 && (count_verti >400 && count_verti<410));
g6 = (count_verti == 410 && (count_horiz >220 && count_horiz<230));
end
7: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = 0;
g4 = 0;
g5 = 0;
g6 = 0;
end
8: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = (count_verti == 420 && (count_horiz >220 && count_horiz<230));
g4 = (count_horiz == 220 && (count_verti >410 && count_verti<420));
g5 = (count_horiz == 220 && (count_verti >400 && count_verti<410));
g6 = (count_verti == 410 && (count_horiz >220 && count_horiz<230));
end
9: begin
g0 = (count_verti == 400 && (count_horiz >220 && count_horiz<230));
g1 = (count_horiz == 230 && (count_verti >400 && count_verti<410));
g2 = (count_horiz == 230 && (count_verti >410 && count_verti<420));
g3 = (count_verti == 420 && (count_horiz >220 && count_horiz<230));
g4 = 0;
g5 = (count_horiz == 220 && (count_verti >400 && count_verti<410));
g6 = (count_verti == 410 && (count_horiz >220 && count_horiz<230));
end
endcase
end

always @(posedge CLK_25MHz)
begin
case (barcode [7:4])
0: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = (count_verti == 420 && (count_horiz >240 && count_horiz<250));
h4 = (count_horiz == 240 && (count_verti >410 && count_verti<420));
h5 = (count_horiz == 240 && (count_verti >400 && count_verti<410));
h6 = 0;
end
1: begin
h0 = 0;
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = 0;
h4 = 0;
h5 = 0;
h6 = 0;
end
2: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = 0;
h3 = (count_verti == 420 && (count_horiz >240 && count_horiz<250));
h4 = (count_horiz == 240 && (count_verti >410 && count_verti<420));
h5 = 0;
h6 = (count_verti == 410 && (count_horiz >240 && count_horiz<250));
end
3: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = (count_verti == 420 && (count_horiz >240 && count_horiz<250));
h4 = 0;
h5 = 0;
h6 = (count_verti == 410 && (count_horiz >240 && count_horiz<250));
end
4: begin
h0 = 0;
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = 0;
h4 = 0;
h5 = (count_horiz == 240 && (count_verti >400 && count_verti<410));
h6 = (count_verti == 410 && (count_horiz >240 && count_horiz<250));
end
5: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = 0;
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = (count_verti == 420 && (count_horiz >240 && count_horiz<250));
h4 = 0;
h5 = (count_horiz == 240 && (count_verti >400 && count_verti<410));
h6 = (count_verti == 410 && (count_horiz >240 && count_horiz<250));
end
6: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = 0;
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = (count_verti == 420 && (count_horiz >240 && count_horiz<250));
h4 = (count_horiz == 240 && (count_verti >410 && count_verti<420));
h5 = (count_horiz == 240 && (count_verti >400 && count_verti<410));
h6 = (count_verti == 410 && (count_horiz >240 && count_horiz<250));
end
7: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = 0;
h4 = 0;
h5 = 0;
h6 = 0;
end
8: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = (count_verti == 420 && (count_horiz >240 && count_horiz<250));
h4 = (count_horiz == 240 && (count_verti >410 && count_verti<420));
h5 = (count_horiz == 240 && (count_verti >400 && count_verti<410));
h6 = (count_verti == 410 && (count_horiz >240 && count_horiz<250));
end
9: begin
h0 = (count_verti == 400 && (count_horiz >240 && count_horiz<250));
h1 = (count_horiz == 250 && (count_verti >400 && count_verti<410));
h2 = (count_horiz == 250 && (count_verti >410 && count_verti<420));
h3 = (count_verti == 420 && (count_horiz >240 && count_horiz<250));
h4 = 0;
h5 = (count_horiz == 240 && (count_verti >400 && count_verti<410));
h6 = (count_verti == 410 && (count_horiz >240 && count_horiz<250));
end
endcase
end

always @(posedge CLK_25MHz)
begin
case (barcode [3:0])
0: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = (count_verti == 420 && (count_horiz >260 && count_horiz<270));
j4 = (count_horiz == 260 && (count_verti >410 && count_verti<420));
j5 = (count_horiz == 260 && (count_verti >400 && count_verti<410));
j6 = 0;
end
1: begin
j0 = 0;
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = 0;
j4 = 0;
j5 = 0;
j6 = 0;
end
2: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = 0;
j3 = (count_verti == 420 && (count_horiz >260 && count_horiz<270));
j4 = (count_horiz == 260 && (count_verti >410 && count_verti<420));
j5 = 0;
j6 = (count_verti == 410 && (count_horiz >260 && count_horiz<270));
end
3: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = (count_verti == 420 && (count_horiz >260 && count_horiz<270));
j4 = 0;
j5 = 0;
j6 = (count_verti == 410 && (count_horiz >260 && count_horiz<270));
end
4: begin
j0 = 0;
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = 0;
j4 = 0;
j5 = (count_horiz == 260 && (count_verti >400 && count_verti<410));
j6 = (count_verti == 410 && (count_horiz >260 && count_horiz<270));
end
5: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = 0;
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = (count_verti == 420 && (count_horiz >260 && count_horiz<270));
j4 = 0;
j5 = (count_horiz == 260 && (count_verti >400 && count_verti<410));
j6 = (count_verti == 410 && (count_horiz >260 && count_horiz<270));
end
6: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = 0;
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = (count_verti == 420 && (count_horiz >260 && count_horiz<270));
j4 = (count_horiz == 260 && (count_verti >410 && count_verti<420));
j5 = (count_horiz == 260 && (count_verti >400 && count_verti<410));
j6 = (count_verti == 410 && (count_horiz >260 && count_horiz<270));
end
7: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = 0;
j4 = 0;
j5 = 0;
j6 = 0;
end
8: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = (count_verti == 420 && (count_horiz >260 && count_horiz<270));
j4 = (count_horiz == 260 && (count_verti >410 && count_verti<420));
j5 = (count_horiz == 260 && (count_verti >400 && count_verti<410));
j6 = (count_verti == 410 && (count_horiz >260 && count_horiz<270));
end
9: begin
j0 = (count_verti == 400 && (count_horiz >260 && count_horiz<270));
j1 = (count_horiz == 270 && (count_verti >400 && count_verti<410));
j2 = (count_horiz == 270 && (count_verti >410 && count_verti<420));
j3 = (count_verti == 420 && (count_horiz >260 && count_horiz<270));
j4 = 0;
j5 = (count_horiz == 260 && (count_verti >400 && count_verti<410));
j6 = (count_verti == 410 && (count_horiz >260 && count_horiz<270));
end
endcase
end

always @(posedge CLK_25MHz)
begin
case (quantity)
0: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = (count_verti == 420 && (count_horiz >290 && count_horiz<300));
k4 = (count_horiz == 290 && (count_verti >410 && count_verti<420));
k5 = (count_horiz == 290 && (count_verti >400 && count_verti<410));
k6 = 0;
end
1: begin
k0 = 0;
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = 0;
k4 = 0;
k5 = 0;
k6 = 0;
end
2: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = 0;
k3 = (count_verti == 420 && (count_horiz >290 && count_horiz<300));
k4 = (count_horiz == 290 && (count_verti >410 && count_verti<420));
k5 = 0;
k6 = (count_verti == 410 && (count_horiz >290 && count_horiz<300));
end
3: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = (count_verti == 420 && (count_horiz >290 && count_horiz<300));
k4 = 0;
k5 = 0;
k6 = (count_verti == 410 && (count_horiz >290 && count_horiz<300));
end
4: begin
k0 = 0;
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = 0;
k4 = 0;
k5 = (count_horiz == 290 && (count_verti >400 && count_verti<410));
k6 = (count_verti == 410 && (count_horiz >290 && count_horiz<300));
end
5: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = 0;
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = (count_verti == 420 && (count_horiz >290 && count_horiz<300));
k4 = 0;
k5 = (count_horiz == 290 && (count_verti >400 && count_verti<410));
k6 = (count_verti == 410 && (count_horiz >290 && count_horiz<300));
end
6: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = 0;
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = (count_verti == 420 && (count_horiz >290 && count_horiz<300));
k4 = (count_horiz == 290 && (count_verti >410 && count_verti<420));
k5 = (count_horiz == 290 && (count_verti >400 && count_verti<410));
k6 = (count_verti == 410 && (count_horiz >290 && count_horiz<300));
end
7: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = 0;
k4 = 0;
k5 = 0;
k6 = 0;
end
8: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = (count_verti == 420 && (count_horiz >290 && count_horiz<300));
k4 = (count_horiz == 290 && (count_verti >410 && count_verti<420));
k5 = (count_horiz == 290 && (count_verti >400 && count_verti<410));
k6 = (count_verti == 410 && (count_horiz >290 && count_horiz<300));
end
9: begin
k0 = (count_verti == 400 && (count_horiz >290 && count_horiz<300));
k1 = (count_horiz == 300 && (count_verti >400 && count_verti<410));
k2 = (count_horiz == 300 && (count_verti >410 && count_verti<420));
k3 = (count_verti == 420 && (count_horiz >290 && count_horiz<300));
k4 = 0;
k5 = (count_horiz == 290 && (count_verti >400 && count_verti<410));
k6 = (count_verti == 410 && (count_horiz >290 && count_horiz<300));
end
endcase
end

wire A = a0 || a1 || a2 || a3 || a4 || a5 || a6 || 
			b0 || b1 || b2 || b3 || b4 || b5 || b6 ||
		   c0 || c1 || c2 || c3 || c4 || c5 || c6 ||
		   d0 || d1 || d2 || d3 || d4 || d5 || d6 ||
		   e0 || e1 || e2 || e3 || e4 || e5 || e6 ||
			f0 || f1 || f2 || f3 || f4 || f5 || f6 ||
			g0 || g1 || g2 || g3 || g4 || g5 || g6 ||
			h0 || h1 || h2 || h3 || h4 || h5 || h6 ||
			j0 || j1 || j2 || j3 || j4 || j5 || j6 ||
			k0 || k1 || k2 || k3 || k4 || k5 || k6 ;	
	


endmodule