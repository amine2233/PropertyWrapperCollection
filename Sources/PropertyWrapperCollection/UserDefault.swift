//
//  UserDefault.swift
//  UsersDefault
//
//  Created by Amine Bensalah on 11/12/2019.
//  Copyright © 2019 Amine Bensalah. All rights reserved.
//

import Foundation
import Combine

public protocol PropertyListValue {}

@propertyWrapper
public struct UserDefault<T: PropertyListValue> {
    public let key: Key
    public let defaultValue: T
    private(set) var userDefaults: UserDefaults

    public var projectedValue: UserDefault<T> { return self }

    public init(key: Key, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    public var wrappedValue: T {
        get { userDefaults.object(forKey: key.rawValue) as? T ?? defaultValue }
        set { userDefaults.set(newValue, forKey: key.rawValue) }
    }
}

public struct Key: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        rawValue = value
    }
}

extension Data: PropertyListValue {}
extension NSData: PropertyListValue {}

extension String: PropertyListValue {}
extension NSString: PropertyListValue {}

extension Date: PropertyListValue {}
extension NSDate: PropertyListValue {}

extension NSNumber: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Int8: PropertyListValue {}
extension Int16: PropertyListValue {}
extension Int32: PropertyListValue {}
extension Int64: PropertyListValue {}
extension UInt: PropertyListValue {}
extension UInt8: PropertyListValue {}
extension UInt16: PropertyListValue {}
extension UInt32: PropertyListValue {}
extension UInt64: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}
#if os(macOS)
extension Float80: PropertyListValue {}
#endif

extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

extension Key {
    public static let isFirstLaunch: Key = "isFirstLaunch"
}
