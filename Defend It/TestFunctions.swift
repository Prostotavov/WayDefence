//
//  TestFunctions.swift
//  Defend It
//
//  Created by MacBook Pro on 31.03.22.
//

import Foundation

func timeMeasureRunningCode(title: String, operationBlock: ()->())  {
    let start = CFAbsoluteTimeGetCurrent()
    operationBlock()
    let finish = CFAbsoluteTimeGetCurrent()
    let timeElapsed = finish - start
    print("Time for \(title) is \(timeElapsed) seconds.")
}
