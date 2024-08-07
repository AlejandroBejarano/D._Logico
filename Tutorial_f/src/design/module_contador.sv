
module module_contador # (                              //Modulo contador parametrizable
    parameter COUNT = 13500000                          //Parametro que cuenta hasta 13500000
) (
    input logic clk,                                    //Entrada clock
    input logic rst,                                    //Entrada reset

    output logic [5:0] count_o                          //Salida de 6 bits llamada count_o
);

    localparam WIDTH_COUNT = $clog2(COUNT);             //Parametro local, ancho en bits de la cuenta, clog2, saca el log base 2 de COUNT, para ver el numero de bits que se necesitan para representar 13500000       

    logic [WIDTH_COUNT -1 : 0] clk_counter = '0;        //Variable tipo logic, cuenta ciclos de reloj, inicia en '0, (') bits a cero
    logic [5:0] led_count_r;                            //Variable registrada de 6 bits, flip flops, almacena valores de cada bit, de COUNT

    always_ff @ (posedge clk) begin                     //Flip Flop, se actualiza en los flancos positivos del clock
        
        if (!rst) begin                                 //rst activo en bajo, all va a cero
            led_count_r <= '0;
            clk_counter <= '0;
    end
        else if (clk_counter == COUNT - 1) begin        //Si no pasa !rst, pero lega a clk_counter == COUNT - 1, clk_counter se reinicia, y se aumenta en la FPGA en 1 el contador led_count_r
            clk_counter <= '0;
            led_count_r <= led_count_r + 1'b1;
        end

        else begin                                      //Si no pasa !rst, y clk_counter == COUNT - 1, el clk_counter los cuenta, y led_count_r se mantiene igual 
            clk_counter <= clk_counter + 1'b1;
            led_count_r <= led_count_r;
        end
    end

    assign count_o = -led_count_r;                      //Salida combinacional, la cuenta que va a los leds -led_count_r.

endmodule