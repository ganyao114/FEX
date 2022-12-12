%ifdef CONFIG
{
  "HostFeatures": ["AVX"],
  "RegData": {
    "XMM0":  ["0x0000000000000000", "0x0000000000000000", "0x0000000000000000", "0x0000000000000000"],
    "XMM1":  ["0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF"],
    "XMM2":  ["0x0001000100010001", "0x0001000100010001", "0x0001000100010001", "0x0001000100010001"],
    "XMM3":  ["0xFFFFFFFF00000000", "0x00010001FFFF0000", "0xFFFFFFFF00000000", "0x00010001FFFF0000"],
    "XMM4":  ["0x0000000000000000", "0x0000000000000000", "0x0000000000000000", "0x0000000000000000"],
    "XMM5":  ["0x0001000100010001", "0x0001000100010001", "0x0001000100010001", "0x0001000100010001"],
    "XMM6":  ["0x0001000100010001", "0x0001000100010001", "0x0001000100010001", "0x0001000100010001"],
    "XMM7":  ["0x0001000100000000", "0x0001000100010000", "0x0001000100000000", "0x0001000100010000"],
    "XMM8":  ["0x0000000000000000", "0x0000000000000000", "0x0000000000000000", "0x0000000000000000"],
    "XMM9":  ["0x0001000100010001", "0x0001000100010001", "0x0000000000000000", "0x0000000000000000"],
    "XMM10": ["0x0001000100010001", "0x0001000100010001", "0x0000000000000000", "0x0000000000000000"],
    "XMM11": ["0x0001000100000000", "0x0001000100010000", "0x0000000000000000", "0x0000000000000000"],
    "XMM12": ["0x0001000100010001", "0x0001000100010001", "0x0001000100010001", "0x0001000100010001"],
    "XMM13": ["0x0001000100010001", "0x0001000100010001", "0x0000000000000000", "0x0000000000000000"],
    "XMM14": ["0x0001000100010001", "0x0001000100010001", "0x0001000100010001", "0x0001000100010001"],
    "XMM15": ["0x0001000100010001", "0x0001000100010001", "0x0000000000000000", "0x0000000000000000"]
  }
}
%endif

lea rdx, [rel .data]

vmovapd ymm0, [rdx + 32 * 0]
vmovaps ymm1, [rdx + 32 * 1]
vmovaps ymm2, [rdx + 32 * 2]
vmovaps ymm3, [rdx + 32 * 3]

; Test with full zero
vpabsw ymm4, [rdx + 32 * 0]
vpabsw xmm8, [rdx + 32 * 0]

; Test with full negative
vpabsw ymm5, [rdx + 32 * 1]
vpabsw xmm9, [rdx + 32 * 1]
vpabsw ymm12, ymm1
vpabsw xmm13, xmm1

; Test with full positive
vpabsw ymm6, [rdx + 32 * 2]
vpabsw xmm10, [rdx + 32 * 2]
vpabsw ymm14, ymm2
vpabsw xmm15, xmm2

; Test a mix
vpabsw ymm7, [rdx + 32 * 3]
vpabsw xmm11, [rdx + 32 * 3]

hlt

align 32
.data:
dq 0x0000000000000000
dq 0x0000000000000000
dq 0x0000000000000000
dq 0x0000000000000000

dq 0xFFFFFFFFFFFFFFFF
dq 0xFFFFFFFFFFFFFFFF
dq 0xFFFFFFFFFFFFFFFF
dq 0xFFFFFFFFFFFFFFFF

dq 0x0001000100010001
dq 0x0001000100010001
dq 0x0001000100010001
dq 0x0001000100010001

dq 0xFFFFFFFF00000000
dq 0x00010001FFFF0000
dq 0xFFFFFFFF00000000
dq 0x00010001FFFF0000
