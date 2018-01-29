//
//  AutoCompleteTextField.swift
//  AutocompleteTextfieldSwift
//
//  Created by Mylene Bayan on 6/13/15.
//  Copyright (c) 2015 mnbayan. All rights reserved.
//

import Foundation
import UIKit

class AutoCompleteTextField: BaseTextField {
    /// Manages the instance of tableview
    private var autoCompleteTableView:UITableView?
    
    /// Holds the collection of attributed strings
    fileprivate lazy var attributedAutoCompleteStrings = [NSAttributedString]()
    
    /// Handles user selection action on autocomplete table view
    public var onSelect:(String, NSIndexPath)->() = {_,_ in}
    
    /// Handles textfield's textchanged
    public var onTextChange:(String)->() = {_ in}
    
    /// Font for the text suggestions
    public var autoCompleteTextFont = UIFont.systemFont(ofSize: 12)
    
    /// Color of the text suggestions
    public var autoCompleteTextColor = UIColor.black
    
    /// Used to set the height of cell for each suggestions
    public var autoCompleteCellHeight:CGFloat = 44.0
    
    /// The maximum visible suggestion
    public var maximumAutoCompleteCount = 3
    
    /// Used to set your own preferred separator inset
    public var autoCompleteSeparatorInset = UIEdgeInsets.zero
    
    /// Shows autocomplete text with formatting
    public var enableAttributedText = false
    
    /// User Defined Attributes
    public var autoCompleteAttributes:[String:AnyObject]?
    
    /// Hides autocomplete tableview after selecting a suggestion
    public var hidesWhenSelected = true
    
    /// Hides autocomplete tableview when the textfield is empty
    public var hidesWhenEmpty:Bool?{
        didSet{
            assert(hidesWhenEmpty != nil, "hideWhenEmpty cannot be set to nil")
            autoCompleteTableView?.isHidden = hidesWhenEmpty!
        }
    }
    /// The table view height
    public var autoCompleteTableHeight:CGFloat?{
        didSet{
            redrawTable()
        }
    }
    /// The strings to be shown on as suggestions, setting the value of this automatically reload the tableview
    public var autoCompleteStrings:[String]?{
        didSet{ reload() }
    }
    
    private var baselayout : AppBaseLayout!
    private var KtableHeight : NSLayoutConstraint!
    
    //MARK: - Init
    
    override init(iSuperView : UIView? , TextFieldType baseType : BaseTextFieldType) {
        super.init(iSuperView: iSuperView, TextFieldType: baseType)
        commonInit()
        setupAutocompleteTable(view: iSuperView!)
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        setupAutocompleteTable(view: superview!)
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.endEditing(true)
//        commonInit()
//        if newSuperview != nil {
//            setupAutocompleteTable(view: newSuperview!)
//        }
    }
    
    private func commonInit(){
        hidesWhenEmpty = true
        autoCompleteAttributes = [NSForegroundColorAttributeName:UIColor.black]
        autoCompleteAttributes![NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 12)
        self.clearButtonMode = .always
        self.addTarget(self, action: #selector(AutoCompleteTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(AutoCompleteTextField.textFieldDidEndEdit), for: .editingDidEnd)
        
        baselayout = AppBaseLayout()
        
    }
    
    private func setupAutocompleteTable(view:UIView){
        
        autoCompleteTableView = UITableView(frame: .zero)
        autoCompleteTableView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(autoCompleteTableView!)

        baselayout.margin_Left = NSLayoutConstraint(item: autoCompleteTableView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        view.addConstraint(baselayout.margin_Left)
        
        baselayout.margin_Right = NSLayoutConstraint(item: autoCompleteTableView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        view.addConstraint(baselayout.margin_Right)
        
        baselayout.position_Top = NSLayoutConstraint(item: autoCompleteTableView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        view.addConstraint(baselayout.position_Top)
        
        KtableHeight = NSLayoutConstraint(item: autoCompleteTableView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
        view.addConstraint(KtableHeight)
        
        autoCompleteTableView!.dataSource = self
        autoCompleteTableView!.delegate = self
        autoCompleteTableView!.rowHeight = autoCompleteCellHeight
        autoCompleteTableView!.isHidden = hidesWhenEmpty ?? true
        autoCompleteTableView!.backgroundColor = .cyan
        
        autoCompleteTableHeight = 100.0
        self.layoutIfNeeded()
    }
    
    private func redrawTable(){
        if let _ = autoCompleteTableView, let autoCompleteTableHeight = autoCompleteTableHeight {
            KtableHeight.constant = autoCompleteTableHeight
            self.layoutIfNeeded()
        }
    }
    
    //MARK: - Private Methods
    private func reload(){
        if enableAttributedText{
            let attrs = [NSForegroundColorAttributeName:autoCompleteTextColor, NSFontAttributeName:autoCompleteTextFont] as [String : Any]
    
            if attributedAutoCompleteStrings.count > 0 {
                attributedAutoCompleteStrings.removeAll(keepingCapacity: false)
            }
            
            if let autoCompleteStrings = autoCompleteStrings, let autoCompleteAttributes = autoCompleteAttributes {
                for i in 0..<autoCompleteStrings.count{
                    let str = autoCompleteStrings[i] as NSString
                    
                    let range = str.range(of: text!, options: .caseInsensitive)
                    let attString = NSMutableAttributedString(string: autoCompleteStrings[i], attributes: attrs)
                    attString.addAttributes(autoCompleteAttributes, range: range)
                    attributedAutoCompleteStrings.append(attString)
                }
            }
        }
        autoCompleteTableView?.reloadData()
    }
    
    func textFieldDidChange(){
        guard let _ = text else {
            return
        }
        
        onTextChange(text!)
        if text!.isEmpty{ autoCompleteStrings = nil }
        DispatchQueue.main.async { 
            self.autoCompleteTableView?.isHidden =  self.hidesWhenEmpty! ? self.text!.isEmpty : false
        }
    }
    
    func textFieldDidEndEdit() {
        autoCompleteTableView?.isHidden = true
    }
}

//MARK: - UITableViewDataSource - UITableViewDelegate
extension AutoCompleteTextField: UITableViewDataSource, UITableViewDelegate {
  
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteStrings != nil ? (autoCompleteStrings!.count > maximumAutoCompleteCount ? maximumAutoCompleteCount : autoCompleteStrings!.count) : 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "autocompleteCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        if enableAttributedText{
            cell?.textLabel?.attributedText = attributedAutoCompleteStrings[indexPath.row]
        }
        else{
            cell?.textLabel?.font = autoCompleteTextFont
            cell?.textLabel?.textColor = autoCompleteTextColor
            cell?.textLabel?.text = autoCompleteStrings![indexPath.row]
        }
        
        cell?.contentView.gestureRecognizers = nil
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        
        if let selectedText = cell?.textLabel?.text {
            self.text = selectedText
            onSelect(selectedText, indexPath as NSIndexPath)
        }
        DispatchQueue.main.async {
            tableView.isHidden = self.hidesWhenSelected
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = autoCompleteSeparatorInset
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = autoCompleteSeparatorInset
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return autoCompleteCellHeight
    }
}
