extension String: SyscallValue {

  @inlinable
  public init(bytesCapacity capacity: Int, initializingBufferWith initializer: (UnsafeMutableRawBufferPointer) throws -> Int) rethrows {
    if #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
      try self.init(unsafeUninitializedCapacity: capacity) { buffer in
        let realCount = try initializer(.init(buffer))
        if realCount > 0, buffer[realCount-1] == 0 {
          // remove trailing \0
          return realCount-1
        }
        return realCount
      }
    } else {
      self = try withUnsafeTemporaryAllocation(of: UInt8.self, capacity: capacity) { buffer in
        var realCount = try initializer(.init(buffer))
        if realCount > 0, buffer[realCount-1] == 0 {
          // remove trailing \0
          realCount -= 1
        }
        return String(decoding: buffer.prefix(realCount), as: UTF8.self)
      }
    }
  }

  @inlinable
  public func withUnsafeSyscallValueBytes(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    var copy = self
    try copy.withUTF8 { try body(.init($0)) }
  }
  
}
