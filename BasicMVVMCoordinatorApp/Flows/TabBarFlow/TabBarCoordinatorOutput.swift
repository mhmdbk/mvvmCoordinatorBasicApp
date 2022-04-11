//
//  TabBarCoordinatorOutput.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

protocol TabBarCoordinatorOutput: AnyObject {
    var finishFlow: (() -> Void)? { get set }
}
