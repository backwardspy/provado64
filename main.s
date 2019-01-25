* = $0801

.byte $0C,$08,$0A,$00,$9E,$20,$33,$32,$37,$36,$38,$00,$00,$00

* = $1000

.binary "music.sid", $7e

* = $8000

sid_init = $1000
sid_play = $1003

entry           lda $0001       ; switch out basic rom to free up $a000
                and #%11111110
                sta $0001

                lda $dd00       ; select vic bank 2
                and #%11111100
                ora #%00000001
                sta $dd00

                jsr initscr     ; blackout

                jsr initspr     ; initialise sprites

                lda #$00
                tax
                tay
                jsr sid_init    ; start music

                sei

                lda #$7f        ; disable cia/vic interrupts
                sta $dc0d
                sta $dd0d

                lda #$01        ; enable raster interrupts
                sta $d01a

                lda #<irq       ; hijack interrupt routine
                ldx #>irq
                sta $0314
                stx $0315

                ldy #0          ; interrupt at line 0
                sty $d012

                lda $dc0d       ; clear existing interrupts
                lda $dd0d
                asl $d019

                cli             ; re-enable interrupts
                jmp *

initscr         ldx #0
                stx $d020
                stx $d021

clear           lda #$20        ; space char
                sta $8400, x    ; screen ram
                sta $8500, x
                sta $8600, x
                sta $86e8, x
                lda #$0e
                sta $d800, x
                sta $d900, x
                sta $da00, x
                sta $dae8, x
                inx
                bne clear       ; loop until overflow
                rts

initspr         lda #50         ; set sprite 0 pos
                sta $d000
                sta $d001

                lda #0          ; set x coord 9th bits to 0
                sta $d010

                lda #$0b        ; sprite multicolour 1
                sta $d025
                lda #$0a        ; sprite multicolour 2
                sta $d026

                lda #$ff        ; set all sprites to MCM
                sta $d01c
                sta $d017       ; ... and make them L A R G E
                sta $d01d

                lda #(pigeon_neutral - $8000) / 64
                sta $87f8

                lda #1          ; enable sprite 0
                sta $d015

                rts

irq             jsr sid_play    ; continue music

                ldx $87f8
                inx
                cpx #(pigeon_flap - $8000) / 64
                bne _noreset
                ldx #(pigeon_neutral - $8000) / 64
_noreset        stx $87f8

                dec $d019       ; ack irq
                jmp $ea81       ; hand off to kernal irq

* = $a000

.include "pigeon.s"
