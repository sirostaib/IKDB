//
//  MainVC.swift
//  IKDB
//
//  Created by Siros Taib on 6/23/24.
//

import UIKit

class MainVC: UIViewController {
    
    var myTextLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Starter2"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
      
       // label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(myTextLabel)
        myTextLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -35).isActive = true
        

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
