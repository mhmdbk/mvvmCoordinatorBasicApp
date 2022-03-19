//
//  HomeCoordinatorOutput.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import Foundation

protocol HomeCoordinatorOutput: AnyObject {
    var finishFlow: (() -> Void)? { get set }
}
