* = $0801
.word (+), 10 ; load addr, BASIC line number
.null $9e, format("%d", start) ; sys $1000
+ .word 0 ; end of BASIC line

* = $1000

start
  ;; set mode 0 (ecm/bmm/mcm 0)
  lda $d011
  and #%10011111
  sta $d011
  lda $d016
  and #%11101111
  sta $d016

  ;; clear the screen
  lda #$20
  ldx #0
cls_loop
  sta $0400, x
  inx
  bne cls_loop

loop
  ;; set background & border colours
  lda col
  sta $d020

  lda col+1
  sta $d021

  ;; set text colour
  lda col+2
  sta $0286

  ;; print msg
  ldx #0
p_loop
  lda msg, x
  beq done
  sta $05c0,x
  lda col+2
  sta $d9c0,x
  inx
  jmp p_loop
done
  inc col
  inc col+1
  inc col+2

  ;; wait for jiffy clock low byte/high nibble to change
  lda $00a2
  and #$f0
  sta time
wait
  lda $00a2
  and #$f0
  cmp time
  beq wait

  jmp loop
  rts

msg
  .enc screen
  .text "hello from 6502 asm", 0
  .enc none

col
  .byte $00, $01, $02           ; border, background, text

time
  .byte $00
