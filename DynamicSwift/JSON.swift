import Foundation

public enum JSON {
    case undefined
    case null
    case bool(Bool)
    case int(Int)
    case double(Double)
    case string(String)
    case array([JSON])
    case dictionary([String: JSON])
}

public extension JSON {
    var isUndefined: Bool {
        if case .undefined = self {
            return true
        } else {
            return false
        }
    }

    var isNull: Bool {
        if case .null = self {
            return true
        } else {
            return false
        }
    }

    var isBool: Bool {
        if case .bool = self {
            return true
        } else {
            return false
        }
    }

    var bool: Bool? {
        if case .bool(let bool) = self {
            return bool
        } else {
            return nil
        }
    }

    var isInt: Bool {
        if case .int = self {
            return true
        } else {
            return false
        }
    }

    var int: Int? {
        if case .int(let int) = self {
            return int
        } else {
            return nil
        }
    }

    var isDouble: Bool {
        if case .double = self {
            return true
        } else {
            return false
        }
    }

    var double: Double? {
        if case .double(let double) = self {
            return double
        } else {
            return nil
        }
    }

    var isString: Bool {
        if case .string = self {
            return true
        } else {
            return false
        }
    }

    var string: String? {
        if case .string(let string) = self {
            return string
        } else {
            return nil
        }
    }

    var isArray: Bool {
        if case .array = self {
            return true
        } else {
            return false
        }
    }

    var array: [JSON]? {
        if case .array(let array) = self {
            return array
        } else {
            return nil
        }
    }

    var isDictionary: Bool {
        if case .dictionary = self {
            return true
        } else {
            return false
        }
    }

    var dictionary: [String: JSON]? {
        if case .dictionary(let dictionary) = self {
            return dictionary
        } else {
            return nil
        }
    }
}

extension JSON: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .null
    }
}

extension JSON: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }
}

extension JSON: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
}

extension JSON: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
}

extension JSON: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension JSON: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: JSON...) {
        self = .array(elements)
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, JSON)...) {
        self = .dictionary(Dictionary(uniqueKeysWithValues: elements))
    }
}

extension JSON: Equatable {
    public static func == (lhs: JSON, rhs: JSON) -> Bool {
        switch (lhs, rhs) {
        case (.null, .null):
            return true
        case (.bool(let lhsBool), .bool(let rhsBool)):
            return lhsBool == rhsBool
        case (.int(let lhsInt), .int(let rhsInt)):
            return lhsInt == rhsInt
        case (.double(let lhsDouble), .double(let rhsDouble)):
            return lhsDouble == rhsDouble
        case (.string(let lhsString), .string(let rhsString)):
            return lhsString == rhsString
        case (.array(let lhsArray), .array(let rhsArray)):
            return lhsArray == rhsArray
        case (.dictionary(let lhsDictionary), .dictionary(let rhsDictionary)):
            return lhsDictionary == rhsDictionary
        default:
            return false
        }
    }
}
