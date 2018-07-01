import Foundation

enum SerializationError: Error {
    case invalidProperty(String)
    case unknownTypeName(String)
    case invalidType(String, Any)
    case missingValue(String)
}

public final class PListSerializer {
    private let shouldAnnotateTypes: Bool

    public init(shouldAnnotateTypes: Bool = false) {
        self.shouldAnnotateTypes = shouldAnnotateTypes
    }

    public func serialize<T: TextOutputStream>(_ object: Any, to stream: inout T) {
        stream.write("""
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">

            """)

        serialize(object, to: &stream, indentationLevel: 0)

        stream.write("""
            </plist>
            """)
    }
}

private let dateFormatter = ISO8601DateFormatter()

private extension PListSerializer {
    func write<T: TextOutputStream>(
        _ string: String,
        to stream: inout T,
        indentationLevel: Int,
        type: Any.Type? = nil
    ) {
        let indentation = String(repeating: "    ", count: indentationLevel)
        stream.write("\(indentation)\(string)")

        if let type = type, shouldAnnotateTypes {
            stream.write(" <!-- \(String(describing: type)) -->")
        }

        stream.write("\n")
    }

    func serialize<T: TextOutputStream>(_ object: Any, to stream: inout T, indentationLevel: Int) {
        switch object {
        case let bool as Bool:
            serialize(bool: bool, to: &stream, indentationLevel: indentationLevel)
        case let int as Int:
            serialize(int: int, to: &stream, indentationLevel: indentationLevel)
        case let double as Double:
            serialize(double: double, to: &stream, indentationLevel: indentationLevel)
        case let date as Date:
            serialize(date: date, to: &stream, indentationLevel: indentationLevel)
        case let data as Data:
            serialize(data: data, to: &stream, indentationLevel: indentationLevel)
        case let string as String:
            serialize(string: string, to: &stream, indentationLevel: indentationLevel)
        case let array as [Any]:
            serialize(array: array, to: &stream, indentationLevel: indentationLevel)
        case let dictionary as [String: Any]:
            serialize(dictionary: dictionary, to: &stream, indentationLevel: indentationLevel)
        case let stringConvertible as CustomStringConvertible:
            serialize(
                string: stringConvertible.description,
                to: &stream,
                indentationLevel: indentationLevel,
                type: type(of: stringConvertible))
        default:
            serialize(reflecting: object, to: &stream, indentationLevel: indentationLevel)
        }
    }

    func serialize<T: TextOutputStream>(bool: Bool, to stream: inout T, indentationLevel: Int) {
        write("<\(bool)/>", to: &stream, indentationLevel: indentationLevel)
    }

    func serialize<T: TextOutputStream>(int: Int, to stream: inout T, indentationLevel: Int) {
        write("<integer>\(int)</integer>", to: &stream, indentationLevel: indentationLevel)
    }

    func serialize<T: TextOutputStream>(double: Double, to stream: inout T, indentationLevel: Int) {
        write("<real>\(double)</real>", to: &stream, indentationLevel: indentationLevel)
    }

    func serialize<T: TextOutputStream>(
        string: String,
        to stream: inout T,
        indentationLevel: Int,
        type: Any.Type? = nil
    ) {
        write("<string>\(string)</string>", to: &stream, indentationLevel: indentationLevel, type: type)
    }

    func serialize<T: TextOutputStream>(date: Date, to stream: inout T, indentationLevel: Int) {
        let dateString = dateFormatter.string(from: date)
        write("<date>\(dateString)</date>", to: &stream, indentationLevel: indentationLevel)
    }

    func serialize<T: TextOutputStream>(data: Data, to stream: inout T, indentationLevel: Int) {
        let dataString = data.base64EncodedString()
        write("<data>\(dataString)</data>", to: &stream, indentationLevel: indentationLevel)
    }

    func serialize<T: TextOutputStream>(array: [Any], to stream: inout T, indentationLevel: Int) {
        write("<array>", to: &stream, indentationLevel: indentationLevel)

        for element in array {
            serialize(element, to: &stream, indentationLevel: indentationLevel + 1)
        }

        write("</array>", to: &stream, indentationLevel: indentationLevel)
    }

    func serialize<T: TextOutputStream>(
        dictionary: [String: Any],
        to stream: inout T,
        indentationLevel: Int,
        type: Any.Type? = nil
    ) {
        write("<dict>", to: &stream, indentationLevel: indentationLevel, type: type)

        for (key, value) in dictionary.sorted(by: { $0.0 < $1.0 }) {
            write("<key>\(key)</key>", to: &stream, indentationLevel: indentationLevel + 1)
            serialize(value, to: &stream, indentationLevel: indentationLevel + 1)
        }

        write("</dict>", to: &stream, indentationLevel: indentationLevel)
    }

    func serialize<T: TextOutputStream>(reflecting object: Any, to stream: inout T, indentationLevel: Int) {
        let mirror = Mirror(reflecting: object)

        guard mirror.displayStyle != .enum else {
            serialize(
                string: String(describing: object),
                to: &stream,
                indentationLevel: indentationLevel,
                type: mirror.subjectType)
            return
        }

        let dictionary = Dictionary(uniqueKeysWithValues: mirror.children
            .filter({ label, _ in label != nil })
            .map({ label, value in (label!, value) }))
        serialize(dictionary: dictionary, to: &stream, indentationLevel: indentationLevel, type: mirror.subjectType)
    }
}
