add_circt_dialect_library(CIRCTCalyxTransforms
  CompileControl.cpp
  GICM.cpp
  GoInsertion.cpp
  ClkResetInsertion.cpp
  RemoveGroups.cpp
  RemoveCombGroups.cpp
  CalyxHelpers.cpp
  CalyxLoweringUtils.cpp
  AffineParallelUnroll.cpp
  AffineToSCF.cpp
  AffinePloopUnparallelize.cpp
  ExcludeExecuteRegionCanonicalize.cpp

  DEPENDS
  CIRCTCalyxTransformsIncGen

  LINK_LIBS PUBLIC
  CIRCTCalyx
  CIRCTComb
  CIRCTHW
  CIRCTPipelineOps
  CIRCTSupport
  MLIRArithDialect
  MLIRFuncDialect
  MLIRIR
  MLIRPass
  MLIRSCFDialect
  MLIRTransformUtils
  MLIRAffineUtils
  )
