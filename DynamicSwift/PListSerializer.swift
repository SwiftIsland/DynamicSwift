import Foundation

enum SerializationError: Error {
    case invalidProperty(String)
    case unknownTypeName(String)
    case invalidType(String, Any)
    case missingValue(String)
}

public final class PListSerializer {
    public init() {
    }

    public func serialize<T: TextOutputStream>(_ object: Any, to stream: inout T) {
    }
}

private extension PListSerializer {
    func write<T: TextOutputStream>(
        _ string: String,
        to stream: inout T,
        indentationLevel: Int
    ) {
        let indentation = String(repeating: "    ", count: indentationLevel)
        stream.write("\(indentation)\(string)\n")
    }
}
