

import UIKit

class TeamCell: UITableViewCell {
    
    var crossDelete :(() -> Void)?
    var donePress :(() -> Void)?
    var cancelPress :(() -> Void)?
    
    public lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    } ()
    
    public lazy var teamLabel: UITextField = { // Названия команд
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.textColor = .white
        return label
    } ()
    
    public lazy var crossImage: UIImageView = { // Названия команд
        let cross = UIImageView()
        let configuration = UIImage.SymbolConfiguration(weight: .heavy)
        cross.translatesAutoresizingMaskIntoConstraints = false
        cross.image = UIImage(systemName: "multiply", withConfiguration: configuration)
        cross.tintColor = .white
        cross.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        cross.addGestureRecognizer(tapRecognizer)
        return cross
    } ()
    
    @objc func imageTapped(sender: UIImageView) {
        self.crossDelete?()
    }
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func donePressed(){
        teamLabel.endEditing(true)
        self.donePress?()
    }
    @objc func cancelPressed(){
        teamLabel.endEditing(true)
        self.cancelPress?()
    }
    
    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.myView)
        myView.addSubview(self.teamLabel)
        myView.addSubview(self.crossImage)
        
         let toolBar = UIToolbar()
        toolBar.tintColor = .purple
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePressed))
        let cancelButton = UIBarButtonItem(title: "Отмена", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPressed))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
         toolBar.isUserInteractionEnabled = true
         toolBar.sizeToFit()
         teamLabel.inputAccessoryView = toolBar
        
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.myView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.myView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.myView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            
            self.teamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.teamLabel.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor),
            
            self.crossImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.crossImage.heightAnchor.constraint(equalToConstant: 27),
            self.crossImage.widthAnchor.constraint(equalToConstant: 27),
            self.crossImage.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor)
        ])
    }
}
