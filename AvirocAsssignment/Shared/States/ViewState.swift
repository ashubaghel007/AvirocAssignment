//
//  ViewState.swift
//  AvirocAssignment
//
//  Created by Ashish Baghel on 22/05/2026.
//

import Foundation

enum ViewState<T> {
    case idle
    case loading
    case empty
    case success(T)
    case failure(CoreError)
}
