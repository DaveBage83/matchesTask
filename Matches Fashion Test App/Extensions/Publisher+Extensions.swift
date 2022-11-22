//
//  Publisher+Extensions.swift
//  Matches Fashion Test App
//
//  Created by David Bage on 21/11/2022.
//

import Combine

extension Publisher where Failure == Never {
    
    /// Use this, most of the time, instead of .assign, as it keeps a weak reference
    public func assignWeak<Root>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (value) in
            guard let object = object else { return }
            object[keyPath: keyPath] = value
        }
    }
}
