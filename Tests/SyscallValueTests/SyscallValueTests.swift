import XCTest
import SyscallValue

final class SyscallValueTests: XCTestCase {
  func testExample() {
    let string = "ABCDEFG👌"
    let copied: String = string.withCString { cstr in
      let count = strlen(cstr)
      return String(capacity: count) { ptr in
        ptr.copyMemory(from: cstr, byteCount: count)
        return count
      }
    }

    XCTAssertEqual(string, copied)
  }
}
