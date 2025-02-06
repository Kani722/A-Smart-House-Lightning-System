module SwitchControl(
    input wire app_switch,    // Input from the mobile app (1 = manual control ON, 0 = OFF)
    output reg light_on       // Output to lighting control
);
    always @ (app_switch) begin
        light_on = app_switch; // Directly assign the app_switch value to light_on
    end
endmodule
