//
//  QueryStatus.swift
//  IlegraTest
//
//  Created by Matheus Ruschel on 8/9/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

enum QueryStatus {
    case Passed
    case Failed(msg: String)
}

enum QueryError: ErrorType {
    
    case ErrorInQuery(msg:String)
}