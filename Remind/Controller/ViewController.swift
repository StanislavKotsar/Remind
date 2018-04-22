//
//  ViewController.swift
//  Remind
//
//  Created by Станислав Коцарь on 18.04.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNService.shared.authorize()
        CLService.shared.authorize()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                               name: NSNotification.Name("internalNotification.enteredRegion"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAction(_:)),
                                               name: NSNotification.Name("internalNotification.handleAction"),
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTimmerTapped(_ sender: UIButton) {
        print("timmer")
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.shared.timerRequest(with: 5)
        }
    }
    
    @IBAction func onDataTapped(_ sender: UIButton) {
        print("date")
        
        AlertService.actionSheet(in: self, title: "Some future time") {
            var components = DateComponents()
            components.second = 0
            UNService.shared.dateRequest(with: components)
        }
    }
    
    
    @IBAction func onLocationTaped(_ sender: UIButton) {
        AlertService.actionSheet(in: self, title: "When I return") {
            print("location")
            CLService.shared.updateLocation()
        }
    }
    
    @objc func didEnterRegion () {
        UNService.shared.locationRequest()
    }
    
    @objc func handleAction (_ sender: Notification) {
        print("in func")
        guard let action = sender.object as? NotificationActionID else { return }
        switch action {
            case .timer: print("timer logic")
            case .date: print("date logic")
            case .location: changeBackground()
        }
    }
    
    func changeBackground() {
        view.backgroundColor = .red
    }


}

