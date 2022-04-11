//
//  ProfileCoordinatorOutput.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-04-11.
//

import Foundation

protocol ProfileCoordinatorOutput: AnyObject {
    var finishFlow: (() -> Void)? { get set }
}
