//
//  Common.swift
//  NewArchitecture
//
//  Created by Matija Kruljac on 07/11/2019.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

typealias SuccessHandler<T> = (_ data: T) -> Void
typealias FailureHanlder<E> = (_ error: E?) -> Void
