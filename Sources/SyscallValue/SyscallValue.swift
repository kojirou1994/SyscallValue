public protocol SyscallValue {
  /// create SyscallValue
  /// - Parameters:
  ///   - capacity: capacity to pre-allocate buffer
  ///   - initializer: closure to fill the buffer, returns initialized bytes count
  init(bytesCapacity capacity: Int, initializingBufferWith initializer: (UnsafeMutableRawBufferPointer) throws -> Int) rethrows

  func withUnsafeSyscallValueBytes(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows
}
