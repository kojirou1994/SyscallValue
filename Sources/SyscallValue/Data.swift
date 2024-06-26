import Foundation

extension Data: SyscallValue {

  @inlinable
  public init(bytesCapacity capacity: Int, initializingBufferWith initializer: (UnsafeMutableRawBufferPointer) throws -> Int) rethrows {
    let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: capacity, alignment: MemoryLayout<UInt8>.alignment)
    do {
      let realCount = try initializer(buffer)
      self.init(bytesNoCopy: buffer.baseAddress.unsafelyUnwrapped, count: realCount, deallocator: .free)
    } catch {
      buffer.deallocate()
      throw error
    }
  }

  @inlinable
  public func withUnsafeSyscallValueBytes(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    try withUnsafeBytes(body)
  }
}
