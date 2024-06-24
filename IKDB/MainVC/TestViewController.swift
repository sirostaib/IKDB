//
//  TestViewController.swift
//  IKDB
//
//  Created by Siros Taib on 6/23/24.
//

import UIKit

class TestViewController: UIViewController {
    var myTextLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Starter2"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
      
       // label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        return label
        
    }()
    
    private let generalLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 18, weight: .regular)
            label.numberOfLines = 0
            label.text = "this is a sample text"
            return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setupLayout()
        self.title = "Home - IKDB"
    }
    
    func setupLayout() {
        
        view.backgroundColor = .white
        view.addSubview(myTextLabel)

 
       myTextLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        myTextLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myTextLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        myTextLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true


 

    }

}
