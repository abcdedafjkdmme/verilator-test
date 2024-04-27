; SMT-LIBv2 description generated by Yosys 0.40+25 (git sha1 171577f90, clang++ 14.0.0-1ubuntu1.1 -fPIC -Os)
; yosys-smt2-module uart_tx_comb
(declare-sort |uart_tx_comb_s| 0)
(declare-fun |uart_tx_comb_is| (|uart_tx_comb_s|) Bool)
(declare-fun |uart_tx_comb#0| (|uart_tx_comb_s|) (_ BitVec 32)) ; \r_state
; yosys-smt2-input r_state 32
; yosys-smt2-wire r_state 32
; yosys-smt2-witness {"offset": 0, "path": ["\\r_state"], "smtname": "r_state", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |uart_tx_comb_n r_state| ((state |uart_tx_comb_s|)) (_ BitVec 32) (|uart_tx_comb#0| state))
(declare-fun |uart_tx_comb#1| (|uart_tx_comb_s|) (_ BitVec 8)) ; \r_data
; yosys-smt2-input r_data 8
; yosys-smt2-wire r_data 8
; yosys-smt2-witness {"offset": 0, "path": ["\\r_data"], "smtname": "r_data", "smtoffset": 0, "type": "input", "width": 8}
(define-fun |uart_tx_comb_n r_data| ((state |uart_tx_comb_s|)) (_ BitVec 8) (|uart_tx_comb#1| state))
(define-fun |uart_tx_comb#2| ((state |uart_tx_comb_s|)) Bool (= (|uart_tx_comb#0| state) #b00000000000000000000000000001010)) ; $eq$uart_tx_comb.v:20$67_Y
(define-fun |uart_tx_comb#3| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#2| state) #b1 #b0)) ; $4\o_uart_tx[0:0]
(define-fun |uart_tx_comb#4| ((state |uart_tx_comb_s|)) (_ BitVec 32) (bvsub (|uart_tx_comb#0| state) #b00000000000000000000000000000010)) ; $sub$uart_tx_comb.v:19$65_Y
(define-fun |uart_tx_comb#5| ((state |uart_tx_comb_s|)) (_ BitVec 1) ((_ extract 0 0) (ite (bvsge (|uart_tx_comb#4| state) #b00000000000000000000000000000000) (bvlshr (concat #b000000000000000000000000 (|uart_tx_comb#1| state)) (|uart_tx_comb#4| state)) (bvshl (concat #b000000000000000000000000 (|uart_tx_comb#1| state)) (bvneg (|uart_tx_comb#4| state)))))) ; $shiftx$uart_tx_comb.v:0$66_Y
(define-fun |uart_tx_comb#6| ((state |uart_tx_comb_s|)) Bool (bvugt (|uart_tx_comb#0| state) #b00000000000000000000000000000001)) ; $gt$uart_tx_comb.v:19$62_Y
(define-fun |uart_tx_comb#7| ((state |uart_tx_comb_s|)) Bool (bvult (|uart_tx_comb#0| state) #b00000000000000000000000000001010)) ; $lt$uart_tx_comb.v:19$63_Y
(define-fun |uart_tx_comb#8| ((state |uart_tx_comb_s|)) Bool (and (or  (|uart_tx_comb#6| state) false) (or  (|uart_tx_comb#7| state) false))) ; $logic_and$uart_tx_comb.v:19$64_Y
(define-fun |uart_tx_comb#9| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#8| state) (|uart_tx_comb#5| state) (|uart_tx_comb#3| state))) ; $3\o_uart_tx[0:0]
(define-fun |uart_tx_comb#10| ((state |uart_tx_comb_s|)) Bool (= (|uart_tx_comb#0| state) #b00000000000000000000000000000001)) ; $eq$uart_tx_comb.v:18$61_Y
(define-fun |uart_tx_comb#11| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#10| state) #b0 (|uart_tx_comb#9| state))) ; $2\o_uart_tx[0:0]
(define-fun |uart_tx_comb#12| ((state |uart_tx_comb_s|)) Bool (not (or  (= ((_ extract 0 0) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 1 1) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 2 2) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 3 3) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 4 4) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 5 5) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 6 6) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 7 7) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 8 8) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 9 9) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 10 10) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 11 11) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 12 12) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 13 13) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 14 14) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 15 15) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 16 16) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 17 17) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 18 18) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 19 19) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 20 20) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 21 21) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 22 22) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 23 23) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 24 24) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 25 25) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 26 26) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 27 27) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 28 28) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 29 29) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 30 30) (|uart_tx_comb#0| state)) #b1) (= ((_ extract 31 31) (|uart_tx_comb#0| state)) #b1)))) ; $eq$uart_tx_comb.v:17$60_Y
(define-fun |uart_tx_comb#13| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#12| state) #b1 (|uart_tx_comb#11| state))) ; \o_uart_tx
; yosys-smt2-output o_uart_tx 1
; yosys-smt2-wire o_uart_tx 1
(define-fun |uart_tx_comb_n o_uart_tx| ((state |uart_tx_comb_s|)) Bool (= ((_ extract 0 0) (|uart_tx_comb#13| state)) #b1))
(define-fun |uart_tx_comb#14| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#2| state) #b0 #b1)) ; $procmux$102_Y
(define-fun |uart_tx_comb#15| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#8| state) #b0 (|uart_tx_comb#14| state))) ; $procmux$105_Y
(define-fun |uart_tx_comb#16| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#10| state) #b0 (|uart_tx_comb#15| state))) ; $procmux$108_Y
(define-fun |uart_tx_comb#17| ((state |uart_tx_comb_s|)) (_ BitVec 1) (ite (|uart_tx_comb#12| state) #b0 (|uart_tx_comb#16| state))) ; $assert$uart_tx_comb.v:23$68_EN
; yosys-smt2-assert 0 _witness_.check_assert_uart_tx_comb_v_23_68 uart_tx_comb.v:23.7-23.17
(define-fun |uart_tx_comb_a 0| ((state |uart_tx_comb_s|)) Bool (or false (not (= ((_ extract 0 0) (|uart_tx_comb#17| state)) #b1)))) ; _witness_.check_assert_uart_tx_comb_v_23_68
(define-fun |uart_tx_comb_a| ((state |uart_tx_comb_s|)) Bool 
  (|uart_tx_comb_a 0| state)
)
(define-fun |uart_tx_comb_u| ((state |uart_tx_comb_s|)) Bool true)
(define-fun |uart_tx_comb_i| ((state |uart_tx_comb_s|)) Bool true)
(define-fun |uart_tx_comb_h| ((state |uart_tx_comb_s|)) Bool true)
(define-fun |uart_tx_comb_t| ((state |uart_tx_comb_s|) (next_state |uart_tx_comb_s|)) Bool true) ; end of module uart_tx_comb
; yosys-smt2-module uart_tx
(declare-sort |uart_tx_s| 0)
(declare-fun |uart_tx_is| (|uart_tx_s|) Bool)
; yosys-smt2-witness {"offset": 0, "path": ["\\r_state"], "smtname": 0, "smtoffset": 0, "type": "reg", "width": 32}
(declare-fun |uart_tx#0| (|uart_tx_s|) (_ BitVec 32)) ; \r_state
; yosys-smt2-register r_state 32
; yosys-smt2-wire r_state 32
(define-fun |uart_tx_n r_state| ((state |uart_tx_s|)) (_ BitVec 32) (|uart_tx#0| state))
; yosys-smt2-witness {"offset": 0, "path": ["\\r_data"], "smtname": 1, "smtoffset": 0, "type": "reg", "width": 8}
(declare-fun |uart_tx#1| (|uart_tx_s|) (_ BitVec 8)) ; \r_data
; yosys-smt2-register r_data 8
; yosys-smt2-wire r_data 8
(define-fun |uart_tx_n r_data| ((state |uart_tx_s|)) (_ BitVec 8) (|uart_tx#1| state))
; yosys-smt2-cell uart_tx_comb uart_tx_comb_inst
; yosys-smt2-witness {"path": ["\\uart_tx_comb_inst"], "smtname": "uart_tx_comb_inst", "type": "cell"}
(declare-fun |uart_tx#2| (|uart_tx_s|) Bool) ; \o_uart_tx
(declare-fun |uart_tx_h uart_tx_comb_inst| (|uart_tx_s|) |uart_tx_comb_s|)
; yosys-smt2-output o_uart_tx 1
; yosys-smt2-wire o_uart_tx 1
(define-fun |uart_tx_n o_uart_tx| ((state |uart_tx_s|)) Bool (|uart_tx#2| state))
(define-fun |uart_tx#3| ((state |uart_tx_s|)) Bool (not (or  (= ((_ extract 0 0) (|uart_tx#0| state)) #b1) (= ((_ extract 1 1) (|uart_tx#0| state)) #b1) (= ((_ extract 2 2) (|uart_tx#0| state)) #b1) (= ((_ extract 3 3) (|uart_tx#0| state)) #b1) (= ((_ extract 4 4) (|uart_tx#0| state)) #b1) (= ((_ extract 5 5) (|uart_tx#0| state)) #b1) (= ((_ extract 6 6) (|uart_tx#0| state)) #b1) (= ((_ extract 7 7) (|uart_tx#0| state)) #b1) (= ((_ extract 8 8) (|uart_tx#0| state)) #b1) (= ((_ extract 9 9) (|uart_tx#0| state)) #b1) (= ((_ extract 10 10) (|uart_tx#0| state)) #b1) (= ((_ extract 11 11) (|uart_tx#0| state)) #b1) (= ((_ extract 12 12) (|uart_tx#0| state)) #b1) (= ((_ extract 13 13) (|uart_tx#0| state)) #b1) (= ((_ extract 14 14) (|uart_tx#0| state)) #b1) (= ((_ extract 15 15) (|uart_tx#0| state)) #b1) (= ((_ extract 16 16) (|uart_tx#0| state)) #b1) (= ((_ extract 17 17) (|uart_tx#0| state)) #b1) (= ((_ extract 18 18) (|uart_tx#0| state)) #b1) (= ((_ extract 19 19) (|uart_tx#0| state)) #b1) (= ((_ extract 20 20) (|uart_tx#0| state)) #b1) (= ((_ extract 21 21) (|uart_tx#0| state)) #b1) (= ((_ extract 22 22) (|uart_tx#0| state)) #b1) (= ((_ extract 23 23) (|uart_tx#0| state)) #b1) (= ((_ extract 24 24) (|uart_tx#0| state)) #b1) (= ((_ extract 25 25) (|uart_tx#0| state)) #b1) (= ((_ extract 26 26) (|uart_tx#0| state)) #b1) (= ((_ extract 27 27) (|uart_tx#0| state)) #b1) (= ((_ extract 28 28) (|uart_tx#0| state)) #b1) (= ((_ extract 29 29) (|uart_tx#0| state)) #b1) (= ((_ extract 30 30) (|uart_tx#0| state)) #b1) (= ((_ extract 31 31) (|uart_tx#0| state)) #b1)))) ; $eq$uart_tx.v:31$14_Y
(define-fun |uart_tx#4| ((state |uart_tx_s|)) Bool (not (or  (|uart_tx#3| state) false))) ; \o_busy
; yosys-smt2-output o_busy 1
; yosys-smt2-wire o_busy 1
(define-fun |uart_tx_n o_busy| ((state |uart_tx_s|)) Bool (|uart_tx#4| state))
; yosys-smt2-witness {"offset": 0, "path": ["\\is_past_valid"], "smtname": 5, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |uart_tx#5| (|uart_tx_s|) (_ BitVec 1)) ; \is_past_valid
; yosys-smt2-register is_past_valid 1
; yosys-smt2-wire is_past_valid 1
(define-fun |uart_tx_n is_past_valid| ((state |uart_tx_s|)) Bool (= ((_ extract 0 0) (|uart_tx#5| state)) #b1))
(declare-fun |uart_tx#6| (|uart_tx_s|) Bool) ; \i_wr
; yosys-smt2-input i_wr 1
; yosys-smt2-wire i_wr 1
; yosys-smt2-witness {"offset": 0, "path": ["\\i_wr"], "smtname": "i_wr", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |uart_tx_n i_wr| ((state |uart_tx_s|)) Bool (|uart_tx#6| state))
(declare-fun |uart_tx#7| (|uart_tx_s|) Bool) ; \i_stb
; yosys-smt2-input i_stb 1
; yosys-smt2-wire i_stb 1
; yosys-smt2-witness {"offset": 0, "path": ["\\i_stb"], "smtname": "i_stb", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |uart_tx_n i_stb| ((state |uart_tx_s|)) Bool (|uart_tx#7| state))
(declare-fun |uart_tx#8| (|uart_tx_s|) (_ BitVec 8)) ; \i_data
; yosys-smt2-input i_data 8
; yosys-smt2-wire i_data 8
; yosys-smt2-witness {"offset": 0, "path": ["\\i_data"], "smtname": "i_data", "smtoffset": 0, "type": "input", "width": 8}
(define-fun |uart_tx_n i_data| ((state |uart_tx_s|)) (_ BitVec 8) (|uart_tx#8| state))
(declare-fun |uart_tx#9| (|uart_tx_s|) Bool) ; \i_clk
; yosys-smt2-input i_clk 1
; yosys-smt2-wire i_clk 1
; yosys-smt2-clock i_clk posedge
; yosys-smt2-witness {"offset": 0, "path": ["\\i_clk"], "smtname": "i_clk", "smtoffset": 0, "type": "posedge", "width": 1}
; yosys-smt2-witness {"offset": 0, "path": ["\\i_clk"], "smtname": "i_clk", "smtoffset": 0, "type": "input", "width": 1}
(define-fun |uart_tx_n i_clk| ((state |uart_tx_s|)) Bool (|uart_tx#9| state))
; yosys-smt2-anyinit uart_tx#10 32 uart_tx.v:52.3-56.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_138"], "smtname": 10, "smtoffset": 0, "type": "init", "width": 32}
(declare-fun |uart_tx#10| (|uart_tx_s|) (_ BitVec 32)) ; \_witness_.anyinit_procdff_138
; yosys-smt2-register _witness_.anyinit_procdff_138 32
; yosys-smt2-wire _witness_.anyinit_procdff_138 32
(define-fun |uart_tx_n _witness_.anyinit_procdff_138| ((state |uart_tx_s|)) (_ BitVec 32) (|uart_tx#10| state))
; yosys-smt2-anyinit uart_tx#11 32 uart_tx.v:52.3-56.6
; yosys-smt2-witness {"offset": 0, "path": ["\\_witness_", "\\anyinit_procdff_137"], "smtname": 11, "smtoffset": 0, "type": "init", "width": 32}
(declare-fun |uart_tx#11| (|uart_tx_s|) (_ BitVec 32)) ; \_witness_.anyinit_procdff_137
; yosys-smt2-register _witness_.anyinit_procdff_137 32
; yosys-smt2-wire _witness_.anyinit_procdff_137 32
(define-fun |uart_tx_n _witness_.anyinit_procdff_137| ((state |uart_tx_s|)) (_ BitVec 32) (|uart_tx#11| state))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:110:execute$152"], "smtname": 12, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |uart_tx#12| (|uart_tx_s|) (_ BitVec 1)) ; $auto$async2sync.cc:110:execute$152
; yosys-smt2-register $auto$async2sync.cc:110:execute$152 1
(define-fun |uart_tx_n $auto$async2sync.cc:110:execute$152| ((state |uart_tx_s|)) Bool (= ((_ extract 0 0) (|uart_tx#12| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:110:execute$146"], "smtname": 13, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |uart_tx#13| (|uart_tx_s|) (_ BitVec 1)) ; $auto$async2sync.cc:110:execute$146
; yosys-smt2-register $auto$async2sync.cc:110:execute$146 1
(define-fun |uart_tx_n $auto$async2sync.cc:110:execute$146| ((state |uart_tx_s|)) Bool (= ((_ extract 0 0) (|uart_tx#13| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:101:execute$148"], "smtname": 14, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |uart_tx#14| (|uart_tx_s|) (_ BitVec 1)) ; $auto$async2sync.cc:101:execute$148
; yosys-smt2-register $auto$async2sync.cc:101:execute$148 1
(define-fun |uart_tx_n $auto$async2sync.cc:101:execute$148| ((state |uart_tx_s|)) Bool (= ((_ extract 0 0) (|uart_tx#14| state)) #b1))
; yosys-smt2-witness {"offset": 0, "path": ["$auto$async2sync.cc:101:execute$142"], "smtname": 15, "smtoffset": 0, "type": "reg", "width": 1}
(declare-fun |uart_tx#15| (|uart_tx_s|) (_ BitVec 1)) ; $auto$async2sync.cc:101:execute$142
; yosys-smt2-register $auto$async2sync.cc:101:execute$142 1
(define-fun |uart_tx_n $auto$async2sync.cc:101:execute$142| ((state |uart_tx_s|)) Bool (= ((_ extract 0 0) (|uart_tx#15| state)) #b1))
(define-fun |uart_tx#16| ((state |uart_tx_s|)) (_ BitVec 1) (bvnot (ite (|uart_tx#9| state) #b1 #b0))) ; $auto$rtlil.cc:2485:Not$205
; yosys-smt2-assume 0 $auto$formalff.cc:758:execute$206
(define-fun |uart_tx_u 0| ((state |uart_tx_s|)) Bool (or (= ((_ extract 0 0) (|uart_tx#16| state)) #b1) (not true))) ; $auto$formalff.cc:758:execute$206
(define-fun |uart_tx#17| ((state |uart_tx_s|)) (_ BitVec 32) (bvsub (|uart_tx#0| state) #b00000000000000000000000000000010)) ; $sub$uart_tx.v:66$51_Y
(define-fun |uart_tx#18| ((state |uart_tx_s|)) (_ BitVec 1) ((_ extract 0 0) (ite (bvsge (|uart_tx#17| state) #b00000000000000000000000000000000) (bvlshr (concat #b000000000000000000000000 (|uart_tx#1| state)) (|uart_tx#17| state)) (bvshl (concat #b000000000000000000000000 (|uart_tx#1| state)) (bvneg (|uart_tx#17| state)))))) ; $shiftx$uart_tx.v:0$52_Y
(define-fun |uart_tx#19| ((state |uart_tx_s|)) Bool (= (ite (|uart_tx#2| state) #b1 #b0) (|uart_tx#18| state))) ; $eq$uart_tx.v:66$53_Y
(define-fun |uart_tx#20| ((state |uart_tx_s|)) Bool (bvsgt (|uart_tx#0| state) #b00000000000000000000000000000001)) ; $gt$uart_tx.v:65$47_Y
(define-fun |uart_tx#21| ((state |uart_tx_s|)) Bool (bvslt (|uart_tx#0| state) #b00000000000000000000000000001010)) ; $lt$uart_tx.v:27$11_Y
(define-fun |uart_tx#22| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#20| state) false) (or  (|uart_tx#21| state) false))) ; $logic_and$uart_tx.v:65$49_Y
(define-fun |uart_tx#23| ((state |uart_tx_s|)) (_ BitVec 1) (ite (|uart_tx#22| state) #b1 #b0)) ; $assert$uart_tx.v:66$50_EN
; yosys-smt2-assert 0 _witness_.check_assert_uart_tx_v_66_50 uart_tx.v:66.7-66.46
(define-fun |uart_tx_a 0| ((state |uart_tx_s|)) Bool (or (|uart_tx#19| state) (not (= ((_ extract 0 0) (|uart_tx#23| state)) #b1)))) ; _witness_.check_assert_uart_tx_v_66_50
(define-fun |uart_tx#24| ((state |uart_tx_s|)) Bool (= (|uart_tx#0| state) #b00000000000000000000000000001010)) ; $eq$uart_tx.v:64$44_Y
(define-fun |uart_tx#25| ((state |uart_tx_s|)) (_ BitVec 1) (ite (|uart_tx#24| state) #b1 #b0)) ; $assert$uart_tx.v:64$45_EN
; yosys-smt2-assert 1 _witness_.check_assert_uart_tx_v_64_45 uart_tx.v:64.35-64.64
(define-fun |uart_tx_a 1| ((state |uart_tx_s|)) Bool (or (|uart_tx#2| state) (not (= ((_ extract 0 0) (|uart_tx#25| state)) #b1)))) ; _witness_.check_assert_uart_tx_v_64_45
(define-fun |uart_tx#26| ((state |uart_tx_s|)) (_ BitVec 1) (ite (|uart_tx#3| state) #b1 #b0)) ; $assert$uart_tx.v:60$36_EN
; yosys-smt2-assert 2 _witness_.check_assert_uart_tx_v_63_42 uart_tx.v:63.25-63.55
(define-fun |uart_tx_a 2| ((state |uart_tx_s|)) Bool (or (|uart_tx#2| state) (not (= ((_ extract 0 0) (|uart_tx#26| state)) #b1)))) ; _witness_.check_assert_uart_tx_v_63_42
; yosys-smt2-assert 3 _witness_.check_assert_uart_tx_v_60_36 uart_tx.v:60.18-60.42
(define-fun |uart_tx_a 3| ((state |uart_tx_s|)) Bool (or (|uart_tx#3| state) (not (= ((_ extract 0 0) (|uart_tx#26| state)) #b1)))) ; _witness_.check_assert_uart_tx_v_60_36
(define-fun |uart_tx#27| ((state |uart_tx_s|)) (_ BitVec 1) (bvnot (ite (|uart_tx#2| state) #b1 #b0))) ; $eq$uart_tx.v:59$34_Y
(define-fun |uart_tx#28| ((state |uart_tx_s|)) Bool (= (|uart_tx#0| state) #b00000000000000000000000000000001)) ; $eq$uart_tx.v:59$32_Y
(define-fun |uart_tx#29| ((state |uart_tx_s|)) (_ BitVec 1) (ite (|uart_tx#28| state) #b1 #b0)) ; $assert$uart_tx.v:59$33_EN
; yosys-smt2-assert 4 _witness_.check_assert_uart_tx_v_59_33 uart_tx.v:59.27-59.58
(define-fun |uart_tx_a 4| ((state |uart_tx_s|)) Bool (or (= ((_ extract 0 0) (|uart_tx#27| state)) #b1) (not (= ((_ extract 0 0) (|uart_tx#29| state)) #b1)))) ; _witness_.check_assert_uart_tx_v_59_33
; yosys-smt2-assert 5 _witness_.check_assert_uart_tx_v_55_29 uart_tx.v:55.57-55.81
(define-fun |uart_tx_a 5| ((state |uart_tx_s|)) Bool (or (= ((_ extract 0 0) (|uart_tx#13| state)) #b1) (not (= ((_ extract 0 0) (|uart_tx#15| state)) #b1)))) ; _witness_.check_assert_uart_tx_v_55_29
; yosys-smt2-assert 6 _witness_.check_assert_uart_tx_v_54_24 uart_tx.v:54.7-54.45
(define-fun |uart_tx_a 6| ((state |uart_tx_s|)) Bool (or (= ((_ extract 0 0) (|uart_tx#12| state)) #b1) (not (= ((_ extract 0 0) (|uart_tx#14| state)) #b1)))) ; _witness_.check_assert_uart_tx_v_54_24
(define-fun |uart_tx#30| ((state |uart_tx_s|)) Bool (= (|uart_tx#10| state) #b00000000000000000000000000001010)) ; $eq$uart_tx.v:55$27_Y
(define-fun |uart_tx#31| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#30| state) false) (or  (= ((_ extract 0 0) (|uart_tx#5| state)) #b1) false))) ; $logic_and$uart_tx.v:55$28_Y
(define-fun |uart_tx#32| ((state |uart_tx_s|)) (_ BitVec 1) (ite (|uart_tx#31| state) #b1 #b0)) ; $assert$uart_tx.v:55$29_EN
(define-fun |uart_tx#33| ((state |uart_tx_s|)) Bool (distinct (|uart_tx#0| state) #b00000000000000000000000000000000)) ; $ne$uart_tx.v:53$20_Y
(define-fun |uart_tx#34| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#6| state) false) (or  (|uart_tx#33| state) false))) ; $logic_and$uart_tx.v:53$21_Y
(define-fun |uart_tx#35| ((state |uart_tx_s|)) Bool (distinct (|uart_tx#0| state) #b00000000000000000000000000001010)) ; $ne$uart_tx.v:53$22_Y
(define-fun |uart_tx#36| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#34| state) false) (or  (|uart_tx#35| state) false))) ; $logic_and$uart_tx.v:53$23_Y
(define-fun |uart_tx#37| ((state |uart_tx_s|)) (_ BitVec 1) (ite (|uart_tx#36| state) #b1 #b0)) ; $assert$uart_tx.v:54$24_EN
(define-fun |uart_tx#38| ((state |uart_tx_s|)) (_ BitVec 32) (bvadd (|uart_tx#11| state) #b00000000000000000000000000000001)) ; $add$uart_tx.v:54$25_Y
(define-fun |uart_tx#39| ((state |uart_tx_s|)) Bool (= (|uart_tx#0| state) (|uart_tx#38| state))) ; $eq$uart_tx.v:54$26_Y
(define-fun |uart_tx#40| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#6| state) false) (or  (|uart_tx#3| state) false))) ; $logic_and$uart_tx.v:17$5_Y
(define-fun |uart_tx#41| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#40| state) false) (or  (|uart_tx#7| state) false))) ; $logic_and$uart_tx.v:17$6_Y
(define-fun |uart_tx#42| ((state |uart_tx_s|)) (_ BitVec 8) (ite (|uart_tx#41| state) (|uart_tx#8| state) (|uart_tx#1| state))) ; $0\r_data[7:0]
(define-fun |uart_tx#43| ((state |uart_tx_s|)) (_ BitVec 32) (bvadd (|uart_tx#0| state) #b00000000000000000000000000000001)) ; $add$uart_tx.v:27$13_Y
(define-fun |uart_tx#44| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#21| state) false) (or  (|uart_tx#7| state) false))) ; $logic_and$uart_tx.v:27$12_Y
(define-fun |uart_tx#45| ((state |uart_tx_s|)) (_ BitVec 32) (ite (|uart_tx#44| state) (|uart_tx#43| state) #b00000000000000000000000000000000)) ; $procmux$130_Y
(define-fun |uart_tx#46| ((state |uart_tx_s|)) Bool (not (or  (|uart_tx#6| state) false))) ; $logic_not$uart_tx.v:26$8_Y
(define-fun |uart_tx#47| ((state |uart_tx_s|)) Bool (and (or  (|uart_tx#46| state) false) (or  (|uart_tx#3| state) false))) ; $logic_and$uart_tx.v:26$10_Y
(define-fun |uart_tx#48| ((state |uart_tx_s|)) (_ BitVec 32) (ite (|uart_tx#47| state) #b00000000000000000000000000000000 (|uart_tx#45| state))) ; $0\r_state[31:0]
(define-fun |uart_tx_a| ((state |uart_tx_s|)) Bool (and
  (|uart_tx_a 0| state)
  (|uart_tx_a 1| state)
  (|uart_tx_a 2| state)
  (|uart_tx_a 3| state)
  (|uart_tx_a 4| state)
  (|uart_tx_a 5| state)
  (|uart_tx_a 6| state)
  (|uart_tx_comb_a| (|uart_tx_h uart_tx_comb_inst| state))
))
(define-fun |uart_tx_u| ((state |uart_tx_s|)) Bool (and
  (|uart_tx_u 0| state)
  (|uart_tx_comb_u| (|uart_tx_h uart_tx_comb_inst| state))
))
(define-fun |uart_tx_i| ((state |uart_tx_s|)) Bool (and
  (= (|uart_tx#0| state) #b00000000000000000000000000000000) ; r_state
  (= (|uart_tx#1| state) #b00000000) ; r_data
  (= (= ((_ extract 0 0) (|uart_tx#5| state)) #b1) false) ; is_past_valid
  (= (= ((_ extract 0 0) (|uart_tx#12| state)) #b1) true) ; $auto$async2sync.cc:110:execute$152
  (= (= ((_ extract 0 0) (|uart_tx#13| state)) #b1) true) ; $auto$async2sync.cc:110:execute$146
  (= (= ((_ extract 0 0) (|uart_tx#14| state)) #b1) false) ; $auto$async2sync.cc:101:execute$148
  (= (= ((_ extract 0 0) (|uart_tx#15| state)) #b1) false) ; $auto$async2sync.cc:101:execute$142
  (|uart_tx_comb_i| (|uart_tx_h uart_tx_comb_inst| state))
))
(define-fun |uart_tx_h| ((state |uart_tx_s|)) Bool (and
  (= (|uart_tx_is| state) (|uart_tx_comb_is| (|uart_tx_h uart_tx_comb_inst| state)))
  (= (|uart_tx#0| state) (|uart_tx_comb_n r_state| (|uart_tx_h uart_tx_comb_inst| state))) ; uart_tx_comb.r_state
  (= (|uart_tx#1| state) (|uart_tx_comb_n r_data| (|uart_tx_h uart_tx_comb_inst| state))) ; uart_tx_comb.r_data
  (= (|uart_tx#2| state) (|uart_tx_comb_n o_uart_tx| (|uart_tx_h uart_tx_comb_inst| state))) ; uart_tx_comb.o_uart_tx
  (|uart_tx_comb_h| (|uart_tx_h uart_tx_comb_inst| state))
))
(define-fun |uart_tx_t| ((state |uart_tx_s|) (next_state |uart_tx_s|)) Bool (and
  (= (|uart_tx#32| state) (|uart_tx#15| next_state)) ; $auto$async2sync.cc:104:execute$144 $auto$async2sync.cc:101:execute$142
  (= (|uart_tx#37| state) (|uart_tx#14| next_state)) ; $auto$async2sync.cc:104:execute$150 $auto$async2sync.cc:101:execute$148
  (= (ite (|uart_tx#3| state) #b1 #b0) (|uart_tx#13| next_state)) ; $auto$async2sync.cc:112:execute$147 $auto$async2sync.cc:110:execute$146
  (= (ite (|uart_tx#39| state) #b1 #b0) (|uart_tx#12| next_state)) ; $auto$async2sync.cc:112:execute$153 $auto$async2sync.cc:110:execute$152
  (= (|uart_tx#0| state) (|uart_tx#11| next_state)) ; $procdff$137 \_witness_.anyinit_procdff_137
  (= (|uart_tx#0| state) (|uart_tx#10| next_state)) ; $procdff$138 \_witness_.anyinit_procdff_138
  (= #b1 (|uart_tx#5| next_state)) ; $procdff$139 \is_past_valid
  (= (|uart_tx#42| state) (|uart_tx#1| next_state)) ; $procdff$141 \r_data
  (= (|uart_tx#48| state) (|uart_tx#0| next_state)) ; $procdff$140 \r_state
  (|uart_tx_comb_t| (|uart_tx_h uart_tx_comb_inst| state) (|uart_tx_h uart_tx_comb_inst| next_state))
)) ; end of module uart_tx
; yosys-smt2-topmod uart_tx
; end of yosys output
