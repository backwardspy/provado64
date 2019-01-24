* = $0801

  .byte $0C,$08,$0A,$00,$9E,$20,$38,$31,$39,$32,$00,$00,$00

* = $1000

.binary "music.sid", $7e

* = $2000

sid_init = $1000
sid_play = $1006

entry           sei             ; disable interrupts

                jsr initscr     ; blackout
                jsr putmsg      ; write text
                jsr sid_init    ; start music

                ldy #$7f        ; turn off CIA interrupts
                sty $dc0d
                sty $dd0d
                lda $dc0d       ; consume exciting CIA interrupts
                lda $dd0d

                lda #$01
                sta $d01a       ; request interrupt for raster beam

                lda #<irq       ; point irq to custom handler
                ldx #>irq
                sta $0314
                stx $0315

                lda #$00
                sta $d012       ; trigger irq on first line
                lda $d011       ; ensure 9th bit is zero
                and #$7f
                sta $d011

                cli             ; re-enable interrupts
                jmp *

initscr         ldx #0
                stx $d020
                stx $d021

clear           lda #$20        ; space char
                sta $0400, x    ; screen ram
                sta $0500, x
                sta $0600, x
                sta $06e8, x
                lda #$0e
                sta $d800, x
                sta $d900, x
                sta $da00, x
                sta $dae8, x
                inx
                bne clear       ; loop until overflow
                rts

.enc "screen"
line1           .text "      what if that doesn't happen       "
line2           .text " because our security is amazingly good "
.enc "none"

putmsg          ldx #0
_loop           lda line1, x
                sta $0590, x
                lda line2, x
                sta $05e0, x
                inx
                cpx #40         ; 40 columns
                bne _loop
                rts

colwash         ldx #39         ; iterate columns 39-0
                lda pal+39      ; start on last colour
_cycle1         ldy pal-1, x
                sta pal-1, x
                sta $d990, x    ; store to colour ram
                tya             ; transfer original colour to a
                dex
                bne _cycle1     ; repeat until zero
                sta pal+39      ; store last colour at end
                sta $d990       ; ^ and colour ram

                ldy #0          ; iterate columns 0-39
                ldx #39         ; while iterating palette 39-0
_cycle2         lda pal, x
                sta $d9e0, y
                iny
                dex
                bne _cycle2
                rts

irq             dec $d019       ; ack irq
                jsr colwash     ; update palette
                jsr sid_play    ; continue music
                jmp $ea81       ; hand off to kernal irq

pal             .byte $0d, $0d, $0f, $0f, $05, $05, $0c, $0c
                .byte $08, $08, $0b, $0b, $09, $09, $09, $09
                .byte $09, $09, $09, $09, $09, $09, $09, $09
                .byte $09, $09, $09, $09, $0b, $0b, $08, $08
                .byte $0c, $0c, $05, $05, $0f, $0f, $0d, $0d
