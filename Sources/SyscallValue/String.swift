extension String: SyscallValue {

  public init(capacity: Int, _ initializer: (UnsafeMutableRawPointer) throws -> Int) rethrows {
    guard capacity > 0 else {
      self.init()
      return
    }
    if #available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
      try self.init(unsafeUninitializedCapacity: capacity) { buffer in
        let realCount = try initializer(.init(buffer.baseAddress!))
        if realCount > 0, buffer[realCount-1] == 0 {
          // remove trailing \0
          return realCount-1
        }
        return realCount
      }
    } else {
      let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity)
      defer {
        buffer.deinitialize(count: capacity).deallocate()
      }
      _ = try initializer(.init(buffer))
      self.init(decodingCString: buffer, as: UTF8.self)
    }
  }

  public func withSyscallValueBuffer(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    var copy = self
    try copy.withUTF8 { try body(.init($0)) }
  }
  
}
