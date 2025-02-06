module IntensitySetting(
    input wire [7:0] room_intensity, // Target intensity level for the room (0-255)
    output reg [7:0] dim_level       // Output to the DimmingControl module
);
    always @ (room_intensity) begin
        dim_level = room_intensity;   // Directly pass room_intensity to dim_level
    end
endmodule
