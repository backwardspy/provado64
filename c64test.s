* = $0801
.word (+), 10 ; load addr, BASIC line number
.null $9e, format("%d", start) ; sys $1000
+ .word 0 ; end of BASIC line

* = $1000
start
  jsr m0
  jsr m0_cls

  ;; set ptr & enable sprite 0
  lda #spr_smile / 64
  sta $07f8
  sta $d000
  sta $d001
  lda #$01
  sta $d015

-
  jmp -

  rts

;;; select vic mode 0 (standard character mode)
;;; input:
;;; output:
;;; uses: A
m0
  lda $d011
  and #%10011111
  sta $d011
  lda $d016
  and #%11101111
  sta $d016
  rts

;;; clear the screen. only valid in mode 0.
;;; input:
;;; output:
;;; uses: A, X
m0_cls
  lda #$20
  ldx #0
-
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inx
  bne -
  rts

;;; sprites
* = $2000
spr_smile
  .byte $00,$ff,$00,$07,$ff,$e0,$0f,$00
  .byte $f0,$18,$00,$18,$30,$00,$0c,$60
  .byte $00,$06,$61,$83,$06,$c1,$c3,$83
  .byte $c1,$c3,$83,$c0,$00,$03,$c0,$00
  .byte $03,$c0,$00,$03,$c0,$ff,$03,$c0
  .byte $ff,$03,$60,$7e,$06,$60,$3c,$06
  .byte $30,$00,$0c,$18,$00,$18,$0f,$00
  .byte $f0,$07,$ff,$e0,$00,$ff,$00,$01
