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
