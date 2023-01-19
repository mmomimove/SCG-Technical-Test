//
//  ViewController.swift
//  scg do test
//
//  Created by MmoMiMove on 19/1/2566 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,
                                      execute: {
            let vc = FirstPageViewController.newInstance()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        })
        
    }


}

