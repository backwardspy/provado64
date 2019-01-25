
; 7 sprites generated with spritemate on 25/01/2019, 22:36:58
; Byte 64 of each sprite contains multicolor (high nibble) & color (low nibble) information

;; LDA #$0b ; sprite multicolor 1
;; STA $D025
;; LDA #$0a ; sprite multicolor 2
;; STA $D026


; sprite 1 / multicolor / color: $0f
pigeon_neutral
.byte $00,$00,$14,$00,$00,$14,$00,$00
.byte $19,$00,$00,$14,$00,$00,$14,$00
.byte $00,$54,$00,$00,$54,$00,$02,$94
.byte $00,$0a,$a4,$00,$0a,$a4,$00,$29
.byte $a8,$00,$2a,$68,$00,$a6,$a8,$00
.byte $a5,$a8,$02,$99,$a0,$06,$96,$a0
.byte $1a,$5a,$80,$54,$4a,$00,$50,$03
.byte $00,$00,$03,$00,$00,$03,$c0,$8f

; sprite 2 / multicolor / color: $0f
pigeon_walk1
.byte $00,$00,$00,$00,$00,$14,$00,$00
.byte $14,$00,$00,$19,$00,$00,$14,$00
.byte $00,$54,$00,$00,$54,$00,$02,$94
.byte $00,$0a,$a4,$00,$0a,$a4,$00,$29
.byte $a8,$00,$2a,$68,$00,$a6,$a8,$00
.byte $a5,$a8,$02,$99,$a0,$06,$96,$a0
.byte $1a,$5a,$80,$14,$4a,$c0,$50,$3c
.byte $fc,$40,$30,$30,$00,$30,$00,$8f

; sprite 3 / multicolor / color: $0f
pigeon_walk2
.byte $00,$00,$14,$00,$00,$14,$00,$00
.byte $19,$00,$00,$14,$00,$00,$14,$00
.byte $00,$54,$00,$00,$54,$00,$02,$94
.byte $00,$0a,$a4,$00,$0a,$a4,$00,$29
.byte $a8,$00,$2a,$68,$00,$a6,$a8,$00
.byte $a5,$a8,$02,$99,$a0,$06,$96,$a0
.byte $1a,$5a,$80,$14,$4e,$80,$50,$3c
.byte $fc,$40,$30,$30,$00,$30,$00,$8f

; sprite 4 / multicolor / color: $0f
pigeon_peck
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$01
.byte $00,$00,$01,$00,$00,$41,$82,$a0
.byte $40,$9a,$a8,$50,$6a,$aa,$64,$26
.byte $a9,$29,$9a,$a5,$1a,$a9,$95,$05
.byte $a6,$a5,$01,$aa,$a5,$02,$aa,$a5
.byte $00,$aa,$85,$00,$0a,$05,$00,$03
.byte $05,$00,$03,$08,$00,$03,$c4,$8f

; sprite 5 / multicolor / color: $0f
pigeon_sit1
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$14,$00
.byte $00,$14,$00,$00,$19,$00,$00,$14
.byte $00,$00,$14,$00,$00,$54,$00,$00
.byte $54,$00,$02,$94,$00,$0a,$a4,$00
.byte $2a,$a8,$00,$aa,$a8,$02,$a6,$a8
.byte $0a,$a9,$a8,$0a,$9a,$a8,$1a,$66
.byte $a0,$59,$96,$80,$56,$5a,$c0,$8f

; sprite 6 / multicolor / color: $0f
pigeon_sit2
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$14,$00
.byte $00,$14,$00,$00,$64,$00,$00,$14
.byte $00,$00,$14,$00,$00,$54,$00,$00
.byte $54,$00,$02,$94,$00,$0a,$a4,$00
.byte $2a,$a8,$00,$aa,$a8,$02,$a6,$a8
.byte $0a,$a9,$a8,$0a,$9a,$a8,$1a,$66
.byte $a0,$59,$96,$80,$56,$5a,$c0,$8f

; sprite 7 / multicolor / color: $0f
pigeon_flap
.byte $a0,$68,$14,$a8,$1a,$14,$6a,$1a
.byte $99,$9a,$86,$94,$6a,$a2,$54,$66
.byte $aa,$54,$5a,$aa,$94,$16,$6a,$a4
.byte $16,$aa,$a4,$05,$aa,$a8,$01,$6a
.byte $a8,$00,$aa,$a8,$00,$aa,$a8,$01
.byte $aa,$a0,$01,$9a,$80,$06,$9b,$00
.byte $06,$7c,$00,$05,$30,$00,$15,$00
.byte $00,$14,$00,$00,$00,$00,$00,$8f
