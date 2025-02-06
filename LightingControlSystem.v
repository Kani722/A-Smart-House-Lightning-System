module LightingControlSystem(
    input wire app_switch,           // Input from the app switch
    input wire [7:0] room_intensity, // Desired room intensity level
    input wire movement,             // Movement detection input
    input wire dark,                 // Darkness detection input
    input wire clk,                  // Clock input
    output wire light_control        // Output light control signal
);
    wire manual_light, auto_light;    // Intermediate signals for manual and auto control
    wire [7:0] dim_level;             // Dimming level from IntensitySetting module
    wire pwm_signal;                  // PWM signal from DimmingControl module

    // Module Instantiations
    SwitchControl switch_control (.app_switch(app_switch), .light_on(manual_light));
    IntensitySetting intensity_setting (.room_intensity(room_intensity), .dim_level(dim_level));
    DimmingControl dimming_control (.clk(clk), .dim_value(dim_level), .pwm_signal(pwm_signal));
    MovementDetection movement_detection (.movement(movement), .dark(dark), .auto_light(auto_light));

    // Logic to determine the final light control output
    assign light_control = (manual_light | auto_light) ? pwm_signal : 0;
endmodule
