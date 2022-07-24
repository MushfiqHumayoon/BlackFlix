//
//  ViewController.swift
//  BlackFlix
//
//  Created by Mushfiq Humayoon on 22/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        let backArrow = UIImage(named: "Back")
        self.navigationController?.navigationBar.backIndicatorImage = backArrow
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrow
        if let pageTitle = button.title(for: .normal) {
            self.navigationController?.navigationBar.topItem?.title = pageTitle
            self.navigationController?.navigationBar.tintColor = .white
        }
    }
    @IBAction func buttonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let screen = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
            self.navigationController?.pushViewController(screen, animated: true)
        }
    }
}

