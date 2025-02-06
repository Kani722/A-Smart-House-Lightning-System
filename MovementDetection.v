module MovementDetection(
    input wire movement,     // Movement sensor input (1 = movement detected)
    input wire dark,         // Dark sensor input (1 = dark environment detected)
    output reg auto_light    // Automatic light control output
);
    always @ (movement or dark) begin
        auto_light = movement && dark; // Light ON only if both movement and darkness are detected
    end
endmodule
