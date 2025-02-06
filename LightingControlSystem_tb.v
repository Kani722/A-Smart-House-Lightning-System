`timescale 1ns / 1ps

module LightingControlSystem_tb;
    reg app_switch;
    reg movement;
    reg dark;
    reg [7:0] room_intensity;
    reg clk;
    wire light_control;

    // Instantiate the top-level module
    LightingControlSystem uut (
        .app_switch(app_switch),
        .room_intensity(room_intensity),
        .movement(movement),
        .dark(dark),
        .clk(clk),
        .light_control(light_control)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    initial begin
        // Initialize Inputs
        app_switch = 0;
        movement = 0;
        dark = 0;
        room_intensity = 8'd0;

        // Monitor output changes
        $monitor("Time=%0t | App_Switch=%b | Movement=%b | Dark=%b | Room_Intensity=%d | Light_Control=%b", 
                 $time, app_switch, movement, dark, room_intensity, light_control);

        // Test 1: Manual ON
        #10 app_switch = 1; room_intensity = 8'd128; // Manual override to turn on light at 50% intensity
        #20 app_switch = 0;

        // Test 2: Auto ON with movement in darkness
        #10 dark = 1; movement = 1; room_intensity = 8'd200; // Should turn on light automatically
        #20 movement = 0; // Movement stops, light should turn off

        // Test 3: No light in daylight even with movement
        #10 dark = 0; movement = 1; room_intensity = 8'd255;
        #20 movement = 0;

        // Test 4: Auto ON with manual intensity adjustment
        #10 dark = 1; movement = 1; room_intensity = 8'd64; // Dim light in darkness
        #20 dark = 0; movement = 0; // Should turn off as it's no longer dark and movement has stopped

        // Finish Simulation
        #50 $finish;
    end
endmodule
