//
//  ErrorInLoadingView.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 10.11.2022.
//

import UIKit
import Lottie

protocol ErrorInLoadingViewDelegate: AnyObject {
    func dismissed()
    func reloadAgain()
}

class ErrorInLoadingView: UIViewController {
    
    //IBOutlets:
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func retryButtonAction(_ sender: UIButton) {
        hide { [weak self] in
            self?.delegate?.reloadAgain()
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        hide { [weak self] in
            self?.delegate?.dismissed()
        }
    }
    
    //Delegate Object
    weak var delegate: ErrorInLoadingViewDelegate?
    
    init() {
        super.init(nibName: "ErrorInLoadingView", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configLottiePlayer()
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = AppColors.backGroundPopUp.withAlphaComponent(0.92)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        
        cancelButton.setTranslucentButton(title: "Cancel")
        retryButton.setDefaultButton(title: "RETRY")
    }
    
    private func configLottiePlayer() {
        let jsonName = "retry"
        let animation = LottieAnimation.named(jsonName)

        let animationView = LottieAnimationView(animation: animation)
        animationView.frame = animationContainerView.bounds
        animationView.contentMode = .scaleAspectFit
        animationContainerView.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.6, delay: 0.2) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide(completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false) {
                completion()
            }
            self.removeFromParent()
        }
    }
}
