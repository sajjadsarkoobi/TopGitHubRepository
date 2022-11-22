//
//  RepositoryDetailsCell.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import UIKit
import Kingfisher

class RepositoryDetailsCell: UITableViewCell {
    
    ///return Cell Identifire
    static var cellIdentifier: String {
        get{
            return "RepositoryDetailsCell"
        }
    }
    
    ///return registered UINIB
    static func register() -> UINib {
        return UINib(nibName: "RepositoryDetailsCell", bundle: nil)
    }
    
    //IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailsStakView: UIStackView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var numberOfStarsLabel: UILabel!
    
    //Shimmer Layer objects
    let avatarLayer = CAGradientLayer()
    let nameLayer = CAGradientLayer()
    let fullNameLayer = CAGradientLayer()
    
    //View model
    var viewModel: RepositoryDetailsCellViewModel?
    
    //FlagVariable
    var isShimmerActive: Bool = false {
        didSet {
            setupShimmerLayers()
            layoutSubviews()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.round()
        setInitialState()
        setupStarImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isShimmerActive {
            removeShimmerLayers()
            return
        }
        
        avatarLayer.frame = avatarImageView.bounds
        avatarLayer.cornerRadius = avatarLayer.bounds.height / 2
        
        nameLayer.frame = nameLabel.bounds
        nameLayer.cornerRadius = nameLabel.bounds.height / 2
        
        fullNameLayer.frame = fullNameLabel.bounds
        fullNameLayer.cornerRadius = fullNameLabel.bounds.height / 2
    }
    
    override func prepareForReuse() {
        setInitialState()
    }
    
    func setupShimmerLayers() {
        avatarLayer.startPoint = CGPoint(x: 0, y: 0.5)
        avatarLayer.endPoint = CGPoint(x: 1, y: 0.5)
        avatarImageView.layer.addSublayer(avatarLayer)
        
        nameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabel.layer.addSublayer(nameLayer)
        
        fullNameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        fullNameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        fullNameLabel.layer.addSublayer(fullNameLayer)
        
        let avatarGroup = makeAnimationGroup()
        avatarGroup.beginTime = 0.0
        avatarLayer.add(avatarGroup, forKey: "backgroundColor")
        
        let nameGroup = makeAnimationGroup()
        nameGroup.beginTime = 0.1
        nameLayer.add(nameGroup, forKey: "backgroundColor")
        
        let fullNameGroup = makeAnimationGroup(previousGroup: nameGroup)
        fullNameLayer.add(fullNameGroup, forKey: "backgroundColor")
    }
    
    func removeShimmerLayers() {
        nameLabel.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        fullNameLabel.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        avatarImageView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
    
    func setInitialState() {
        self.isShimmerActive = false
        detailsStakView.isHidden = true
        descriptionLabel.isHidden = true
        self.detailsStakView.alpha = 0
        self.descriptionLabel.alpha = 0
        self.layoutSubviews()
    }
    
    func setupCell(viewModel: RepositoryDetailsCellViewModel) {
        self.viewModel = viewModel
        self.nameLabel.text = viewModel.name
        self.fullNameLabel.text = viewModel.fullName
        self.descriptionLabel.text = viewModel.description
        self.languageLabel.text = viewModel.language
        self.numberOfStarsLabel.text = viewModel.stars
        //Loading image using KingFisher
        self.setAvatarImage(imageUrl: viewModel.avatar)
    }
    
    func cellTapped() {
        if isShimmerActive {
            return
        }
        
        if detailsStakView.isHidden {
            showDetails()
        } else {
            hideDetails()
        }
    }
    
    private func setAvatarImage(imageUrl: String) {
        let url = URL(string: imageUrl)
        avatarImageView.kf.setImage(with: url)
    }
    
    private func hideDetails() {
        self.detailsStakView.isHidden = true
        self.descriptionLabel.isHidden = true
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut]) { [unowned self] in
            self.detailsStakView.alpha = 0
            self.descriptionLabel.alpha = 0
            self.contentView.layoutIfNeeded()
        }
    }
    
    private func showDetails() {
        self.detailsStakView.isHidden = false
        self.descriptionLabel.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn]) { [unowned self] in
            self.detailsStakView.alpha = 1
            self.descriptionLabel.alpha = 1
            self.contentView.layoutIfNeeded()
        }
    }
    
    private func setupStarImage() {
        starsImageView.image = AppIcons.starFilled.imageWithColor(color: AppColors.yellowColor)
    }
}

//MARK: -AnimationLayer Group
extension RepositoryDetailsCell {
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 2
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientLightGrey.cgColor
        anim1.toValue = UIColor.gradientDarkGrey.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientDarkGrey.cgColor
        anim2.toValue = UIColor.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude // infinite
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }

        return group
    }
}
