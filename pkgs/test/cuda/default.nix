{
  lib,
  recurseIntoAttrs,

  cudaPackages,

  cudaPackages_11_0,
  cudaPackages_11_1,
  cudaPackages_11_2,
  cudaPackages_11_3,
  cudaPackages_11_4,
  cudaPackages_11_5,
  cudaPackages_11_6,
  cudaPackages_11_7,
  cudaPackages_11_8,
  cudaPackages_11,

  cudaPackages_12_0,
  cudaPackages_12_1,
  cudaPackages_12_2,
  cudaPackages_12_3,
  cudaPackages_12_4,
  cudaPackages_12_5,
  cudaPackages_12_6,
  cudaPackages_12_8,
  cudaPackages_12_9,
  cudaPackages_12,
}@args:

let
  isTest =
    name: package:
    builtins.elem (package.pname or null) [
      "cuda-samples"
      "cuda-library-samples"
      "saxpy"
    ];
in
(lib.trivial.pipe args [
  (lib.filterAttrs (name: _: lib.hasPrefix "cudaPackages" name))
  (lib.mapAttrs (
    _: ps:
    lib.pipe ps [
      (lib.filterAttrs isTest)
      recurseIntoAttrs
    ]
  ))
  recurseIntoAttrs
])
