//
//  AlertService.swift
//  Remind
//
//  Created by Станислав Коцарь on 21.04.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import Foundation
import UIKit
class AlertService {
    private init () {}
    
    static func actionSheet (in vc: UIViewController, title: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
