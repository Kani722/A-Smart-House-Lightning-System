module DimmingControl(
    input wire clk,                 // Clock input
    input wire [7:0] dim_value,     // Dimming value (0-255) controlling brightness
    output reg pwm_signal           // PWM output to control light intensity
);
    reg [7:0] counter = 0;          // Counter to compare with dim_value

    always @(posedge clk) begin
        counter <= counter + 1;     // Increment counter
        pwm_signal <= (counter < dim_value) ? 1 : 0; // PWM logic
    end
endmodule
