public protocol SyscallValue {
  init(capacity: Int, _ initializer: (UnsafeMutableRawPointer) throws -> Int) rethrows

  func withSyscallValueBuffer(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows
}
