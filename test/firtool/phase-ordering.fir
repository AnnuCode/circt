; RUN: firtool %s --format=fir --ir-fir | FileCheck %s

; Temporary wires should not be introduced by type lowering, and if they are,
; they should be cleaned up by canonicalize.

; CHECK-LABEL: firrtl.module @Issue794
; CHECK-SAME: (in %clock: !firrtl.clock,
; CHECK:       %[[memory_0:.+]] = firrtl.reg %clock {{.*}}: !firrtl.clock, !firrtl.uint<8>
; CHECK:       firrtl.mux(%[[v14:.+]], %wData_0, %[[memory_0]])
; CHECK:       firrtl.mux(%[[v19:.+]], %wData_1, %[[v5:.+]])
; CHECK:       firrtl.matchingconnect %[[memory_0]], %[[v22:.+]]
FIRRTL version 4.0.0
circuit Issue794: %[[{
    "class": "sifive.enterprise.firrtl.MarkDUTAnnotation",
    "target":"~Issue794|Issue794"
  },
  {
    "class": "sifive.enterprise.firrtl.ConvertMemToRegOfVecAnnotation$"
  }]]
  public module Issue794:
    input clock: Clock
    input rAddr: UInt<2>
    input rEn: UInt<1>
    output rData: UInt<8>
    input wAddr: UInt<2>[2]
    input wEn: UInt<1>[2]
    input wMask: UInt<1>[2]
    input wData: UInt<8>[2]

    mem memory:
      data-type => UInt<8>
      depth => 4
      reader => r
      writer => w0
      writer => w1
      read-latency => 0
      write-latency => 1
      read-under-write => undefined

    connect memory.r.clk, clock
    connect memory.r.en, rEn
    connect memory.r.addr, rAddr
    connect rData, memory.r.data

    connect memory.w0.clk, clock
    connect memory.w0.en, wEn[0]
    connect memory.w0.addr, wAddr[0]
    connect memory.w0.mask, wMask[0]
    connect memory.w0.data, wData[0]

    connect memory.w1.clk, clock
    connect memory.w1.en, wEn[1]
    connect memory.w1.addr, wAddr[1]
    connect memory.w1.mask, wMask[1]
    connect memory.w1.data, wData[1]
