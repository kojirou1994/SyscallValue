// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "SyscallValue",
  products: [
    .library(name: "SyscallValue", targets: ["SyscallValue"]),
  ],
  targets: [
    .target(name: "SyscallValue"),
    .testTarget(
      name: "SyscallValueTests",
      dependencies: ["SyscallValue"]),
  ]
)
