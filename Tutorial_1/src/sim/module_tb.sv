`timescale 1ns/1ps                         //Escala de tiempo, se representa en 1ns o 1ps
 
module module_tb;                           //se declara el nombre del tb


    logic clk;                              //Estimulos
    logic rst;
    logic [5 : 0] count_o;

    module_contador # (10) COUNTER (        //Instancia del modulo
        .clk (clk),
        .rst (rst),
        .count_o (count_o)
    );

   initial begin                           //Pruebas

     clk = 0;    //inicia clock en 0.
     rst = 1;

     #30;

     rst = 0;    //Se resetea despues de 30 unidades de timepo

     #30;

     rst = 1;    //Se deja de resetear despues de 30 unidades de tiempo

     #300000;    
     $finish;    //Despues de 300000 unidades de tiempo, se finaliza
    end

    always begin        //Genera un clock cada 10 ns
        clk = ~clk;
        #10;
    end

    initial begin                               //Para diagrama de tiempos
        $dumpfile("module_counter_tb.vcd");
        $dumpvars(0, module_tb);
    end

endmodule