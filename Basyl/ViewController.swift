//
//  ViewController.swift
//  Basyl
//
//  Created by Andrew Kasilov on 15.05.2024.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {
//    private var settingsView = SettingsView()
    private var settingsView = Alert()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan

//        settingsView.delegate = self

        let vc = UIHostingController(rootView: settingsView)
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        view.addSubview(swiftuiView)
        NSLayoutConstraint.activate([
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        vc.didMove(toParent: self)
    }
}

extension ViewController: SettingsViewDelegate {
    func itemDidTap(_ item: SelectedItem) {
        switch item {
        case .notifications:
            print("print from view controller: Notification did tap")
        case .clear:
            print("print from view controller: Clear did tap")
        case .rate:
            print("print from view controller: Rate did tap")
        case .submit:
            print("print from view controller: Submit did tap")
        case .invite:
            print("print from view controller: Invite did tap")
        case .privacy:
            print("print from view controller: Privacy did tap")
        case .terms:
            print("print from view controller: Terms did tap")
        case .gallery:
            print("print from view controller: Gallery did tap")
        case .settings:
            print("print from view controller: Settings did tap")
        case .btncreate:
            print("print from view controller: BTCcreate did tap")
        }
        
    }
}
