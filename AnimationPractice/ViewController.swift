//
//  ViewController.swift
//  AnimationPractice
//
//  Created by Chorrs on 12.01.24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var dropViewButton: UIButton!
    
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collider: UICollisionBehavior?
    var itemBehaviour: UIDynamicItemBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior()
        collider = UICollisionBehavior()
        itemBehaviour = UIDynamicItemBehavior()
        
        collider?.translatesReferenceBoundsIntoBoundary = true
        collider?.collisionMode = .everything
        
        collider?.addItem(dropViewButton)
        
        itemBehaviour?.elasticity = 1
        itemBehaviour?.friction = 0
        itemBehaviour?.allowsRotation = true
        
        
        animator?.addBehavior(gravity!)
        animator?.addBehavior(collider!)
        animator?.addBehavior(itemBehaviour!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationView.layer.cornerRadius = min(animationView.bounds.size.width, animationView.bounds.size.height) / 2.0
    }
    
    @IBAction func didTapDropView() {
        let view = UIView(
            frame: CGRect(
                x: dropViewButton.frame.origin.x,
                y: 40,
                width: 30,
                height: 30
            ))
        
        view.backgroundColor = #colorLiteral(red: 0.6807323892, green: 1, blue: 0.1890976604, alpha: 1)
        view.layer.cornerRadius = min(view.frame.size.width, view.frame.size.height) / 2.0
        self.view.addSubview(view)
        
        gravity?.addItem(view)
        collider?.addItem(view)
        itemBehaviour?.addItem(view)
    }
    
    @IBAction func startTransform() {
        
        let label = UILabel(frame: CGRect(
            x: 30,
            y: 30,
            width: 100,
            height: 30
        ))
        
        label.text = "hello"
        
        UIView.transition(
            with: self.animationView,
            duration: 2,
            options: .transitionFlipFromTop,
            animations: { self.animationView.addSubview(label) }) { (isFinished) in
                UIView.transition(
                    with: self.animationView,
                    duration: 2,
                    options: .transitionFlipFromLeft,
                    animations: { label.removeFromSuperview() },
                    completion: nil)
            }
    }
    
    
    @IBAction func startMove() {
        
        let backgroundColor = animationView.backgroundColor
        let alpha = animationView.alpha
        let center = animationView.center
        let transform = animationView.transform
        
        UIView.animate(withDuration: 4) {
            self.animationView.backgroundColor = .red
            self.animationView.alpha = 0
            self.animationView.center = CGPoint(x: 400, y: 700)
            self.animationView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
        } completion: { (isFinished) in
            if isFinished {
                
                UIView.animate(
                    withDuration: 4,
                    delay: 2,
                    usingSpringWithDamping: 1,
                    initialSpringVelocity: 1,
                    options: [.curveEaseIn],
                    animations: {
                        self.animationView.backgroundColor = backgroundColor
                        self.animationView.alpha = alpha
                        self.animationView.center = center
                        self.animationView.transform = transform
                    },
                    completion: nil)
            }
        }
    }
}

