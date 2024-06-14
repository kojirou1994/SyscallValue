extension Array: SyscallValue {

  @inlinable
  public init(bytesCapacity capacity: Int, initializingBufferWith initializer: (UnsafeMutableRawBufferPointer) throws -> Int) rethrows {
    self = try .init(ContiguousArray<Element>(bytesCapacity: capacity, initializingBufferWith: initializer))
  }

  @inlinable
  public func withUnsafeSyscallValueBytes(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    try withUnsafeBytes(body)
  }

}

extension ContiguousArray: SyscallValue {

  @inlinable
  public init(bytesCapacity capacity: Int, initializingBufferWith initializer: (UnsafeMutableRawBufferPointer) throws -> Int) rethrows {
    assert(capacity % MemoryLayout<Element>.stride == 0, "capacity not well-calculated?")

    let count = capacity / MemoryLayout<Element>.stride

    try self.init(unsafeUninitializedCapacity: count) { buffer, initializedCount in
      initializedCount = try initializer(.init(buffer)) / MemoryLayout<Element>.stride
    }
  }

  @inlinable
  public func withUnsafeSyscallValueBytes(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    try withUnsafeBytes(body)
  }

}
