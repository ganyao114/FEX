%ifdef CONFIG
{
  "RegData": {
    "MM0": ["0x4142434445464748", "0x0"],
    "MM1": ["0x4142434445464748", "0x0"]
  },
  "MemoryRegions": {
    "0x100000000": "4096"
  }
}
%endif

mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

movq mm0, [rdx + 8 * 0]
movq mm1, [rdx + 8 * 1]
pminub mm0, mm1
pminub mm1, [rdx + 8 * 0]

hlt
