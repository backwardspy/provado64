  ;; CIA#1 port register A
pra = $dc00

  ;; CIA#1 port register B
prb = $dc01

  ;; CIA#1 data direction register A
ddra = $dc02

  ;; CIA#1 data direction register B
ddrb = $dc03

  ;; set ddra to input and ddrb to output
  lda #$ff
  sta ddra
  lda #0
  sta ddrb

  ;; clear key display
  lda #$a0
  sta $0400
  sta $0401
  sta $0402
  sta $0403

row1                            ; keys: W, A, S, Z
  lda #%11111101
  sta pra
key_z
  lda prb
  and #%00010000
  bne key_w
  lda #0
  sta is_running
  jmp end
key_w
  lda prb
  and #%00000010
  bne key_a
  dec $d001
  lda #$97
  sta $0400
key_a
  lda prb
  and #%00000100
  bne key_s
  dec $d000
  lda #$81
  sta $0401
key_s
  lda prb
  and #%00100000
  bne row2
  inc $d001
  lda #$93
  sta $0402
row2                            ; keys: D
  lda #%11111011
  sta pra
key_d
  lda prb
  and #%00000100
  bne end
  inc $d000
  lda #$84
  sta $0403
end
