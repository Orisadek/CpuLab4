onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_top4/Board_swtch
add wave -noupdate -radix hexadecimal /tb_top4/key0
add wave -noupdate -radix hexadecimal /tb_top4/key1
add wave -noupdate -radix hexadecimal /tb_top4/key2
add wave -noupdate -radix hexadecimal /tb_top4/ALUout4_o
add wave -noupdate -radix hexadecimal /tb_top4/hex32
add wave -noupdate -radix hexadecimal /tb_top4/hex10
add wave -noupdate -radix hexadecimal /tb_top4/LED95
add wave -noupdate -radix hexadecimal /tb_top4/N_o
add wave -noupdate -radix hexadecimal /tb_top4/C_o
add wave -noupdate -radix hexadecimal /tb_top4/Z_o
add wave -noupdate -radix hexadecimal /tb_top4/top4_tb/top4_p/Y_i
add wave -noupdate -radix hexadecimal /tb_top4/top4_tb/top4_p/X_i
add wave -noupdate -radix hexadecimal /tb_top4/top4_tb/top4_p/ALUFN_i
add wave -noupdate -radix hexadecimal /tb_top4/top4_tb/top4_p/ALUout_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {144245 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {888832 ps}
