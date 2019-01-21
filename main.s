;;; basic header
* = $0801

  .word (+), 10                 ; load address, basic line number
  .null $9e, format("%d", start); sys 4096
+
  .word 0                       ; end of basic line

;;; program code
* = $1000

start
  lda #1
  sta is_running                ; needed to resume from basic
  #m0
  #m0_fillchar

  #setborder #0                 ; black out screen
  #setbackground #0

  #m0_fillcolour #6

  lda #spr_smile / 64           ; point sprite 0 to smiley face
  sta $07f8

  lda #80                       ; set initial sprite position
  sta $d000
  sta $d001

  lda #$01                      ; enable sprite 0
  sta $d015

mainloop
  .include "input.s"

  jsr put_msg

  lda is_running
  beq quit                      ; quit if is_running == 0

  #vsync

  jmp mainloop

quit
  lda #0
  sta $d015                     ; disable all sprites
  #m0_fillchar                  ; clear screen
  #m0_fillcolour                ; reset text colour
  #setborder                    ; reset border colour
  #setbackground                ; reset background colour
  rts

vsync .macro                    ; await raster line 0
-
  lda $d011
  bpl -
-
  lda $d011
  bmi -
  .endm

m0 .macro                       ; select vic mode 0 (standard character mode)
  lda $d011
  and #%10011111
  sta $d011
  lda $d016
  and #%11101111
  sta $d016
  .endm

m0_fillchar .macro char=#$20    ; fill character ram with \char
  lda \char
  ldx #0
-
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inx
  bne -                         ; loop until X == 0 (overflow)
  .endm

m0_fillcolour .macro colour=#$e ; fill colour ram with \colour
  lda \colour
  ldx #0
-
  sta $d800, x
  sta $d900, x
  sta $da00, x
  sta $db00, x
  inx
  bne -                         ; loop until X == 0 (overflow)
  .endm

setborder .macro colour=#$e     ; set border colour to \colour
  lda \colour
  sta $D020
  .endm

setbackground .macro colour=#$6 ; set background colour to \colour
  lda \colour
  sta $D021
  .endm

put_msg
  ldx #0
-
  lda msg, x
  beq _cycle
  sta $07c0, x
  lda palette, x
  sta $dbc0, x
  inx
  bne -
_cycle
  ldx #40
-
  lda palette - 1, x
  sta palette, x
  dex
  bne -
  lda palette + 40
  sta palette
  rts

is_running                      ; escape flag for main loop
  .byte $01

msg
  .enc "screen"
  .null "palette cycling is still cool in 2019 :)"
  .enc "none"

palette
  .byte $d, $d, $3, $3, $e, $e, $4, $4
  .byte $6, $6, $4, $4, $e, $e, $3, $3
  .byte $d, $d, $3, $3, $e, $e, $4, $4
  .byte $6, $6, $4, $4, $e, $e, $3, $3
  .byte $d, $3, $e, $4, $6, $4, $e, $3
  .byte $0

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
