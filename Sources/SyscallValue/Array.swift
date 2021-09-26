extension Array: SyscallValue {

  public init(capacity: Int, _ initializer: (UnsafeMutableRawPointer) throws -> Int) rethrows {
    guard capacity > 0 else {
      self.init()
      return
    }
    let ratio = MemoryLayout<Element>.size / MemoryLayout<UInt8>.size
    let capacity = ratio * capacity
    assert(MemoryLayout<Element>.size % MemoryLayout<UInt8>.size == 0)
    try self.init(unsafeUninitializedCapacity: capacity) { buffer, initializedCount in
      initializedCount = try initializer(buffer.baseAddress!) / ratio
    }
  }

  public func withSyscallValueBuffer(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    try withUnsafeBytes(body)
  }

}

extension ContiguousArray: SyscallValue {

  public init(capacity: Int, _ initializer: (UnsafeMutableRawPointer) throws -> Int) rethrows {
    guard capacity > 0 else {
      self.init()
      return
    }
    let ratio = MemoryLayout<Element>.size / MemoryLayout<UInt8>.size
    let capacity = ratio * capacity
    assert(MemoryLayout<Element>.size % MemoryLayout<UInt8>.size == 0)
    try self.init(unsafeUninitializedCapacity: capacity) { buffer, initializedCount in
      initializedCount = try initializer(buffer.baseAddress!) / ratio
    }
  }

  public func withSyscallValueBuffer(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    try withUnsafeBytes(body)
  }

}
