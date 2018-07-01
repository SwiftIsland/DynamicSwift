import JavaScriptCore

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

public final class JSValue {
    internal let value: JavaScriptCore.JSValue

    fileprivate init(_ value: JavaScriptCore.JSValue) {
        self.value = value
    }
}
