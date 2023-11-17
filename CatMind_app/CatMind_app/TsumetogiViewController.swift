//
//  TsumetogiViewController.swift
//  CatMind_app
//
//  Created by 佐藤今日香 on 2023/11/17.
//

import UIKit

class TsumetogiViewController: UIViewController {
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //extensionと繋げる
        //addTextField.delegate = self
        
        //起動時にボタン使えなくする
        button.isEnabled = false
        
        //キーボード入力処理を受け取る
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードを隠す処理を受け取る
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    //キーボードを消す
    override func touchesBegan(_ touches:Set<UITouch>,with event:UIEvent?){
        self.view.endEditing(true)
    }
    //キーボードを表示するときに画面をずらす動作
    @objc func showKeyboard(notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else{ return }
        let buttonMaxY = label.frame.maxY
        let distance = buttonMaxY - keyboardMinY + 200  //この"200"が画面タテ方向への移動量
        let transform = CGAffineTransform(translationX: 0, y: -distance)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: []
                       , animations: {
            self.view.transform = transform})
    }
    
    //キーボード消える時に画面の位置を元に戻す動作
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: []
                       , animations: {
            self.view.transform = .identity}) //これでキーボードが下に戻る時に画面が下に戻る
    }
    
    
    //buttonを押した時の動作
    @IBAction func button(_ sender: Any) {
        
        guard let Text = self.addTextField.text else { return }
        self.label.text = Text
        //TextFieldに空文字を入れる
        self.addTextField.text = ""
        //keyboardを隠す
        self.dismissKeyboard()
    }
    
    //buttonが押されたらキーボードを消す
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    
  @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // Homeに戻る
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
//textFieldに、テキストがあるか無いかを判別してる
/*extension ViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let addTextFieldEmpty = addTextField.text?.isEmpty ?? true
        if addTextFieldEmpty  {
            button.isEnabled = false
            button.setTitleColor(UIColor.systemGray , for: .normal)
        } else {
            button.isEnabled = true
            button.setTitleColor(UIColor.white , for: .normal)
            
        }
    }
}*/

