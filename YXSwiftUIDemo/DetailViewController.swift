//
//  DetailViewController.swift
//  YXSwiftUIDemo
//
//  Created by 姚肖 on 2023/11/13.
//

import UIKit

class DetailViewController: UIViewController {

    var label = UILabel()
    var scrollView = UIScrollView()
    var backImageView = UIImageView()
    
    let checkerArray = ["车", "马", "象", "士", "将", "士", "象", "马", "车",
                 "", "", "", "", "", "", "", "", "",
                 "", "炮", "", "", "", "", "", "炮", "",
                 "兵", "", "兵", "", "兵", "", "兵", "", "兵",
                 "", "", "", "", "", "", "", "", "",
                 "", "", "", "", "", "", "", "", "",
                 "卒", "", "卒", "", "卒", "", "卒", "", "卒",
                 "", "炮", "", "", "", "", "", "炮", "",
                 "", "", "", "", "", "", "", "", "",
                 "车", "马", "象", "士", "将", "士", "象", "马", "车"]
    
    var tempBtn = UIButton()
    var mTableView = RoundedTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        backImageView = UIImageView.init(image: UIImage.init(named: "detail_back"))
//        backImageView.sizeToFit()
//        backImageView.center = CGPointMake(self.view.center.x, backImageView.bounds.size.height / 2 + 100)
//        view.addSubview(backImageView)
        
//        scrollView = UIScrollView.init(frame: self.view.bounds)
//        
//        label = UILabel.init(frame: CGRectZero)
//        label.text = ""
//        label.numberOfLines = 0
//        scrollView.addSubview(label)
//        
//        view.addSubview(scrollView)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
//            // 在这里执行需要延迟的操作
//
//            self?.loadData()
//        }
        
//        loadCheckerboard()
        
        loadChatView()
        
    }
    
    func loadChatView() {
        
        let chatView = UIView.init(frame: CGRect(x: 50, y: 100, width: 200, height: 280))
        chatView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        chatView.layer.cornerRadius = 10
        view.addSubview(chatView)
        
        let chatPanG = UIPanGestureRecognizer.init(target: self, action: #selector(chatPanGestureAction))
        chatView.addGestureRecognizer(chatPanG)
        
        let textField = RoundedTextField(frame: CGRect(x: 0, y: 240, width: 200, height: 40))
        textField.returnBlock = {[weak self] text in
            self?.mTableView.datas += [text]
        }
        chatView.addSubview(textField)
    
        let tableView = RoundedTableView(frame: CGRect(x: 0, y: 0, width: 200, height: 240), style: .plain)
        tableView.backgroundColor = .clear
        chatView.addSubview(tableView)
        mTableView = tableView
        
        let hideKeyboard = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboardAction))
        view.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func hideKeyboardAction() {
        view.endEditing(true)
    }
    
    @objc func chatPanGestureAction(gesture : UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        // 更新视图的位置
        gesture.view?.center = CGPoint(x: (gesture.view?.center.x)! + translation.x, y: (gesture.view?.center.y)! + translation.y)
        
        // 重置手势的移动偏移量
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    func loadCheckerboard() {
        
        //8*9
        let rows = 9
        let columns = 8
        let squareSize = UIScreen.main.bounds.size.width / 8 - 40 / 8
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(columns) * squareSize, height: CGFloat(rows) * squareSize))
        for row in 0..<rows {
            for col in 0..<columns {
                let squareView = UIView(frame: CGRect(x: CGFloat(col) * squareSize, y: CGFloat(row) * squareSize, width: squareSize, height: squareSize))
                squareView.layer.borderWidth = 0.5
                if (row == 4) {
                    squareView.layer.borderWidth = 0
                }
                containerView.addSubview(squareView)
            }
        }
        containerView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        view.addSubview(containerView)
        
        
        let viewT = containerView.subviews.first
        let checker = Checker.init(frame: CGRectZero)
        checker.center = CGPoint(x: (viewT?.center.x)! - squareSize / 2, y: (viewT?.center.y)! - squareSize / 2)
        containerView.addSubview(checker)
        
        //9*10
        let rowsO = 10
        let columnsO = 9
        let containerViewO = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(columns) * squareSize, height: CGFloat(rows) * squareSize))
        for rowO in 0..<rowsO {
            for colO in 0..<columnsO {
                let squareView = UIButton.init(type: .custom)
                squareView.layer.borderWidth = 0.5
                squareView.layer.cornerRadius = squareSize/2
                squareView.clipsToBounds = true
                squareView.frame = CGRect(x: 0, y: 0, width: squareSize, height: squareSize)
                squareView.frame = CGRect(x: CGFloat(colO) * squareSize - squareSize/2, y: CGFloat(rowO) * squareSize - squareSize/2, width: squareSize, height: squareSize)
                containerViewO.addSubview(squareView)
                squareView.addTarget(self, action: #selector(checkerTap), for: .touchUpInside)
            }
        }
        containerViewO.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        view.addSubview(containerViewO)
        
        for row in 0..<containerViewO.subviews.count {
            if (row >= 9 && row <= 17) ||
                (row == 18) || (row >= 20 && row <= 24) || (row == 26) ||
                (row == 28) || (row == 30) || (row == 32) || (row == 34) ||
                (row >= 36 && row <= 44) ||
                (row >= 45 && row <= 53) ||
                (row == 55) || (row == 57) || (row == 59) || (row == 61) ||
                (row == 63) || (row >= 65 && row <= 69) || (row == 71) ||
                (row >= 72 && row <= 80) {
                containerViewO.subviews[row].layer.borderWidth = 0
            }
            let button : UIButton = containerViewO.subviews[row] as! UIButton
            button.setTitle(checkerArray[row], for: .normal)
            if (row < 54) {
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.backgroundColor = .white
            } else {
                button.setTitleColor(.red, for: .normal)
                button.titleLabel?.backgroundColor = .white
            }
        }
        
    }
    
    @objc func checkerTap(btn : UIButton) {
        btn.isSelected = !btn.isSelected
        if (btn.isSelected) {
            btn.titleLabel?.backgroundColor = .orange
        } else {
            btn.titleLabel?.backgroundColor = .white
        }
        
        if (tempBtn != btn && tempBtn.isSelected == true) {
            
            btn.layer.borderWidth = 0.5
            btn.setTitle(tempBtn.titleLabel?.text, for: .normal)
            btn.setTitleColor(tempBtn.titleLabel?.textColor, for: .normal)
            
            btn.titleLabel?.backgroundColor = .white
            
            tempBtn.layer.borderWidth = 0
            tempBtn.setTitle("", for: .normal)
            tempBtn.titleLabel?.backgroundColor = .clear
            
            tempBtn = UIButton()
        } else {
            tempBtn = btn
        }
        
    }
    
    func loadData() {
        showLoadingAlert()
        let index = Int(arc4random_uniform(10000)) + 1
        YXNetwork.shared.getJokeWithGet(url: "http://v3.wufazhuce.com:8000/api/essay/\(index)") {[weak self] data in
            //                        content = data
            self!.hideLoadingAlert()
            let dic : NSDictionary = YXNetwork.shared.jsonStringToDictionary(jsonString: data)! as NSDictionary
            if dic["data"] != nil {
                
                self?.backImageView.isHidden = true
                
                let dic2 : NSDictionary = dic["data"] as! NSDictionary
                if dic2["hp_content"] != nil {
                    var tagText = dic2["hp_content"] as! String
                    
                    tagText = tagText.replacingOccurrences(of: "<br>", with: "\n")
                    tagText = tagText.replacingOccurrences(of: "<p>", with: " ")
                    tagText = tagText.replacingOccurrences(of: "</p>", with: " ")
                    self?.label.attributedText = NSMutableAttributedString(string: tagText);
                    self?.viewDidLayoutSubviews()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        label.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 100)
        label.sizeToFit()
        scrollView.contentSize = CGSizeMake(UIScreen.main.bounds.width - 20, label.bounds.size.height + 200)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func showLoadingAlert() {
        let alertController = UIAlertController(title: nil, message: "加载中...", preferredStyle: .alert)

        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)

    }

    func hideLoadingAlert() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true) {
            
        }
    }
}

/*可变位置聊天tool*/
class RoundedTableView : UITableView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var h = 240.0
    
    var datas = [String]() {
        willSet {
            
        }
        didSet {
            if (self.frame.size.height < h) {
                let ch = CGFloat(self.datas.count * 40)
                self.frame = CGRect(x: 0, y: h - ch, width: frame.size.width, height: ch)
            }
            self.reloadData()
            self.scrollToRow(at: NSIndexPath(row: datas.count - 1, section: 0) as IndexPath, at: .bottom, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        cell?.textLabel?.text = datas[indexPath.row]
        cell?.backgroundColor = .clear
        return cell!
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        h = CGFloat(frame.size.height)
        let ch = CGFloat(self.datas.count * 40)
        self.frame = CGRect(x: 0, y: h - ch, width: frame.size.width, height: ch)
        self.delegate = self
        self.dataSource = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "mCell")
        self.rowHeight = 40
        self.showsVerticalScrollIndicator = false
        if (datas.count > 0) {
            self.scrollToRow(at: NSIndexPath(row: datas.count - 1, section: 0) as IndexPath, at: .bottom, animated: true)
        }
    }
}

class RoundedTextField: UITextField, UITextFieldDelegate {
    
    var meFrame = CGRect()
    typealias ReturnBlock = (String) -> Void
    var returnBlock: ReturnBlock = { text in
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        // 设置边框样式
        borderStyle = .none
        // 设置边框宽度和颜色
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.blue.cgColor
        // 设置圆角
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        // 设置背景颜色
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
        self.leftView = leftView
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        rightViewMode = .always
        self.rightView = rightView
        
        self.delegate = self
        
        // 注册键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification : Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            // 执行你想要的操作，比如调整界面布局
            print("键盘弹出，高度为：\(keyboardHeight)")
            
            let screenH = UIScreen.main.bounds.size.height
            let superView : UIView = self.superview!
            let maxY = CGRectGetMaxY(superView.frame)
            if ((screenH - maxY) <= keyboardHeight) {
                meFrame = superView.frame
                superView.frame = CGRect(x: CGFloat(superView.frame.origin.x), y: CGFloat(screenH - superView.frame.size.height - keyboardHeight - 100), width: CGFloat(superView.frame.size.width), height: CGFloat(superView.frame.size.height))
            }
        }
    }
    
    @objc func keyboardWillHide(sender : Notification) {
        if (meFrame.size.width > 0) {
            self.superview?.frame = meFrame
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        returnBlock(textField.text!)
        
        textField.text = ""
        
        return true
    }
}

