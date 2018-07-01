import JavaScriptCore

@dynamicMemberLookup
public final class JavaScript {
    public enum Error: Swift.Error {
        case exception
    }

    public static let context = JavaScript()
    fileprivate let context = JSContext()!

    @discardableResult
    public static func `import`(_ script: String) throws -> JSValue {
        let value = JSValue(context.context.evaluateScript(script))
        if context.context.exception != nil { throw Error.exception }
        return value
    }

    @discardableResult
    public static func `import`(_ url: URL) throws -> JSValue {
        return try `import`(String(contentsOf: url))
    }
}

@dynamicMemberLookup
public final class JSValue {
    internal let value: JavaScriptCore.JSValue

    fileprivate init(_ value: JavaScriptCore.JSValue) {
        self.value = value
    }
}

public extension JSValue {
    var isUndefined: Bool {
        return value.isUndefined
    }

    var isNull: Bool {
        return value.isNull
    }

    var isBool: Bool {
        return value.isBoolean
    }

    var bool: Bool? {
        return value.isBoolean ? value.toBool() : nil
    }

    var isNumber: Bool {
        return value.isNumber
    }

    var int: Int? {
        return value.isNumber ? Int(value.toInt32()) : nil
    }

    var double: Double? {
        return value.isNumber ? value.toDouble() : nil
    }

    var isString: Bool {
        return value.isString
    }

    var string: String? {
        return value.isString ? value.toString() : nil
    }
}

extension JSValue: ExpressibleByNilLiteral {
    public convenience init(nilLiteral: ()) {
        self.init(.init(nullIn: JavaScript.context.context))
    }
}

extension JSValue: ExpressibleByBooleanLiteral {
    public convenience init(booleanLiteral value: Bool) {
        self.init(.init(bool: value, in: JavaScript.context.context))
    }
}

extension JSValue: ExpressibleByIntegerLiteral {
    public convenience init(integerLiteral value: Int32) {
        self.init(.init(int32: value, in: JavaScript.context.context))
    }
}

extension JSValue: ExpressibleByFloatLiteral {
    public convenience init(floatLiteral value: Double) {
        self.init(.init(double: value, in: JavaScript.context.context))
    }
}

extension JSValue: ExpressibleByStringLiteral {
    public convenience init(stringLiteral value: String) {
        self.init(.init(object: value, in: JavaScript.context.context))
    }
}

extension JSValue: Equatable {
    public static func == (lhs: JSValue, rhs: JSValue) -> Bool {
        return lhs.value.isEqualWithTypeCoercion(to: rhs.value)
    }
}

extension JSValue: CustomStringConvertible {
    public var description: String {
        return value.toString()
    }
}

public extension JavaScript {
    subscript(dynamicMember member: String) -> JSValue {
        get {
            return JSValue(context.objectForKeyedSubscript(member))
        }
        set {
            context.setObject(newValue.value, forKeyedSubscript: member as NSString)
        }
    }
}

public extension JSValue {
    public subscript(index: Int) -> JSValue {
        get {
            return JSValue(value.atIndex(index))
        }
        set {
            value.setValue(newValue.value, at: index)
        }
    }

    public subscript(dynamicMember member: String) -> JSValue {
        get {
            return JSValue(value.forProperty(member)!)
        }
        set {
            value.setValue(newValue.value, forProperty: member)
        }
    }
}
