import Foundation

extension Data: SyscallValue {

  public init(capacity: Int, _ initializer: (UnsafeMutableRawPointer) throws -> Int) rethrows {
    guard capacity > 0 else {
      self.init()
      return
    }
    let ptr = UnsafeMutableRawPointer.allocate(byteCount: capacity, alignment: MemoryLayout<UInt8>.alignment)
    do {
      let realCount = try initializer(ptr)
      self.init(bytesNoCopy: ptr, count: realCount, deallocator: .free)
    } catch {
      ptr.deallocate()
      throw error
    }
  }

  public func withSyscallValueBuffer(_ body: (UnsafeRawBufferPointer) throws -> Void) rethrows {
    try withUnsafeBytes(body)
  }
}
