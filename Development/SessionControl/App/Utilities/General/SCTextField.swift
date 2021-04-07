//
//  SCTextField.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation
import UIKit

class SCBaseTextField: UITextField {

    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    public var fontSize : CGFloat = 0.0
    
    public var padding: Double = 8
    
    private var leftEmptyView: UIView {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
    }
    
    private var leftButton : UIButton {
        return UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
    }
    
    private var rightEmptyViewForButton : UIView {
        return leftButton
    }
    
    private var rightEmptyView: UIView {
        return leftEmptyView
    }
    
    override func becomeFirstResponder() -> Bool {
        HighlightLayer()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        resetLayer()
        return super.resignFirstResponder()
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    fileprivate func setupDefault() {
        
        self.cornerRadius = SCSettings.cornerRadius
        self.borderWidth = SCSettings.borderWidth
        self.borderColor = SCColor.appWhite
        self.shadowColor = SCColor.appWhite
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = SCSettings.shadowOpacity
        self.tintColor = SCColor.appWhite
        self.textColor = SCColor.appWhite
    }
    
    fileprivate func HighlightLayer() {
        self.borderColor = SCColor.appOrange
        self.tintColor = SCColor.appOrange
    }
    
    fileprivate func resetLayer() {
        self.borderColor = SCColor.appWhite
        self.tintColor = SCColor.appWhite
    }
    
    private func setup() {
        
        fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
        
        leftView = leftEmptyView
        leftViewMode = .always
        
        rightView = rightEmptyView
        rightViewMode = .always
        
        setupDefault()
    }
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SCRegularWithoutBorderTextField: UITextField {

    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        let fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
        self.font = SCFont.poppinsRegular(size: fontSize)
    }
}

class SCRegularTextField: SCBaseTextField {

    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SCFont.poppinsRegular(size: fontSize)
    }
}

class SCBoldTextField: SCBaseTextField {

    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SCFont.poppinsBold(size: fontSize)
    }
}

class SCEmailTextField: SCRegularTextField {

    var leftEmailView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconEmail))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftEmailView
        
        self.keyboardType = .emailAddress
        self.autocorrectionType = .no
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 2)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 4)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SCPasswordTextField: SCRegularTextField {

    var leftPasswordView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconPassword))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftPasswordView
        
        self.isSecureTextEntry = true
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SCUsernameTextField: SCRegularTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconUser))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SCStudioNameTextField: SCRegularTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconStudioName))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}


class SCStudioAddressTextField: SCRegularTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconAddress))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}


class SCStudioCreditsTextField: SCRegularTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconStudioCredits))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SCGenresTextField: SCRegularTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconStudioGenres))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SCBirthDateTextField: SCRegularTextField, UITextFieldDelegate {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconBirthdate))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let dpDate = UIDatePicker()
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
        
        dpDate.datePickerMode = .dateAndTime
        dpDate.setDate(Date(), animated: false)
        inputView = dpDate
        
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: SCImageName.iconMessages), for: UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.text = DateTimeManager.shared.stringFrom(date: dpDate.date, inFormate: DateFormate.MMM_DD_COM_yyyy)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.text = DateTimeManager.shared.stringFrom(date: dpDate.date, inFormate: DateFormate.MMM_DD_COM_yyyy)
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
    }
}

class SCGenderTextField: SCRegularTextField, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconGender))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    private static let height: CGFloat = 20
    private static let crossButtonSize = CGSize(width: height, height: height)
    private let crossButtonView = UIButton(frame: CGRect(origin: CGPoint.zero, size: crossButtonSize))
    
    let pvGender = UIPickerView()
    let pvOptions: [String] = ["Not to Answer", "Male", "Female"]
    var selectedOption: String? {
        didSet {
            self.text = selectedOption
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
        
        
        pvGender.dataSource = self
        pvGender.delegate = self
        inputView = pvGender
        
        crossButtonView.contentMode = .center
        crossButtonView.setImage(UIImage(named: SCImageName.iconMessages), for: UIControl.State.normal)
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if selectedOption == nil {
            selectedOption = pvOptions.first
        }
    }
        
    //------------------------------------------------------
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pvOptions[row]
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.delegate = self
    }
}

class SCMobileNumberTextField: SCRegularTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: SCImageName.iconUser))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}
class SCAccountHolderNameTextField: SCRegularTextField {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    func setup() {
        
        leftView = leftUserView
        
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 0.2)), size: CGSize(width: CGFloat(padding) * 0, height: bounds.height -  CGFloat(padding * 0.1)))
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}


class SCAddImagesTextField: SCRegularTextField {

    var leftButton : UIButton {
        let image = UIImage(named: "upload")
        let button   = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.cornerRadius = 3
        return button
    }
    
    //------------------------------------------------------
    
    func setup() {
        
        leftView = leftButton
        leftView?.center.y = leftButton.center.y
        self.keyboardType = .default
        self.autocorrectionType = .no
        self.autocapitalizationType = .words
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
    }
    
    //MARK: Override
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding)), size: CGSize(width: CGFloat(padding) * 8, height: bounds.height -  CGFloat(padding * 2)))
//        return CGRect(x: 4, y: 7, width: 80, height: 35)
        
    }
        
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

