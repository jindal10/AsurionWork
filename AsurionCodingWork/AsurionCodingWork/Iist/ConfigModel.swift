//
//  ConfigModel.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import UIKit

struct Setting: Decodable {
    let settings: ConfigModel
}

struct ConfigModel: Decodable {
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
}
