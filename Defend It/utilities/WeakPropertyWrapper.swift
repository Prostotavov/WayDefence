//
//  WeakPropertyWrapper.swift
//  Defend It
//
//  Created by Роман Сенкевич on 7.05.22.
//

import Foundation

final class WeakObject<T: AnyObject> {
    private(set) weak var value: T?
    init(_ v: T) { value = v }
}

@propertyWrapper
struct Weak<Element> where Element: AnyObject {
    private var storage = [WeakObject<Element>]()

    var wrappedValue: [Element] {
        get { storage.compactMap { $0.value } }
        set { storage = newValue.map { WeakObject($0) } }
    }
}
