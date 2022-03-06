//
//  AppModuleFactoryType.swift
//  MN Atelier
//
//  Created by Mounir Bittar on 4/16/20.
//  Copyright © 2020 Ideatolife. All rights reserved.
//

import Foundation

protocol AppModuleFactoryType: AnyObject {
    func makeMainModule(dependencies: MainViewModel.Dependencies) -> MainViewController
}
