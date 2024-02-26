//
//  ProfilViewController.swift
//  iosFrontApp
//
//  Created by Etudiant on 20/01/2024.
//

import UIKit

class ProfilViewController: UIViewController {

    @IBOutlet weak var firstNameValue: UITextField!
    @IBOutlet weak var nameValue: UITextField!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var newPasswordValue: UITextField!
    @IBOutlet weak var confirmNewPasswordValue: UITextField!
    
    @IBOutlet weak var firstNameAPI: UILabel!
    @IBOutlet weak var nameAPI: UILabel!
    @IBOutlet weak var emailAPI: UILabel!
    @IBOutlet weak var passwordAPI: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameAPI.text=""
        nameAPI.text=""
        emailAPI.text=""
        passwordAPI.text=""
        // Do any additional setup after loading the view.
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
