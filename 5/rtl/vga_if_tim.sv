
interface vga_if_tim;
    logic [10:0] vcount;
    logic vsync;
    logic vblnk;
    logic [10:0] hcount;
    logic hsync;
    logic hblnk;

    modport in( 
        input vcount, 
        input hcount, 
        input vsync, 
        input hsync, 
        input vblnk, 
        input hblnk
    );

    modport out( 
        output vcount, 
        output hcount, 
        output vsync, 
        output hsync, 
        output vblnk, 
        output hblnk
    );





endinterface