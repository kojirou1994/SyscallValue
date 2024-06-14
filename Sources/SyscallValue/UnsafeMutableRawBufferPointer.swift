extension UnsafeMutableRawBufferPointer: SyscallValue {

  @inlinable
  public init(bytesCapacity capacity: Int, initializingBufferWith initializer: (UnsafeMutableRawBufferPointer) throws -> Int) rethrows {
    let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: capacity, alignment: MemoryLayout<UInt8>.alignment)
    do {
      let realCount = try initializer(buffer)
      self = .init(rebasing: buffer.prefix(realCount))
    } catch {
      buffer.deallocate()
      throw error
    }
  }

  @inlinable
  public func withUnsafeSyscallValueBytes(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    try body(.init(self))
  }

}
