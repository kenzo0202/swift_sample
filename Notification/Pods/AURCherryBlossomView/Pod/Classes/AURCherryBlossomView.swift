//
//  AOCherryBlossomView.swift
//  CherryBlossom
//
//  Created by AuraOtsuka on 2016/03/15.
//  Copyright © 2016年 AuraOtsuka. All rights reserved.
//

import UIKit
import QuartzCore

open class AURCherryBlossomView: UIView {
    
    public enum BlossomType {
        case cherryBlossom
        case plum
        case dandelion
    }
    
    var emitter: CAEmitterLayer!
    open var colors: [UIColor]!
    open var _type: BlossomType!
    open var type: BlossomType{
        get{
            return _type
        }
        set(t){
            _type = t
            if(isActive()){
                stopBlossom()
                startBlossom()
            }
        }
    }
    open var birthRate: Float!
    fileprivate var active :Bool = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        type = .cherryBlossom
        birthRate = 4.0
        active = false
    }
    
    open func startBlossom() {
        emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        
        var cells = [CAEmitterCell]()
        cells.append(generateBlossom())
        
        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        active = true
    }
    
    open func stopBlossom() {
        emitter?.birthRate = 0
        active = false
    }
    
    func imageForType(_ type: BlossomType) -> UIImage? {
        
        var fileName: String!
        
        switch type {
        case .plum:
            fileName = "plum"
        case .cherryBlossom:
            fileName = "cherryblossoms"
        case .dandelion:
            fileName = "dandelion"
        }
        
        let path = Bundle(for: AURCherryBlossomView.self).path(forResource: "AURCherryBlossomView", ofType: "bundle")
        let bundle = Bundle(path: path!)
        let imagePath = bundle?.path(forResource: fileName, ofType: "png")
        let url = URL(fileURLWithPath: imagePath!)
        let data = try? Data(contentsOf: url)
        if let data = data {
            return UIImage(data: data)
        }
        return nil
    }
    
    func generateBlossom() -> CAEmitterCell {
        let blossom = CAEmitterCell()
        blossom.birthRate = birthRate
        blossom.lifetime = 7.0
        blossom.scale = 0.4
        blossom.lifetimeRange = 0
        blossom.velocity = CGFloat(140.0)
        blossom.velocityRange = CGFloat(40.0)
        blossom.emissionLongitude = CGFloat(M_PI)
        blossom.emissionRange = CGFloat(M_PI_4)
        blossom.spin = CGFloat(3)
        blossom.spinRange = CGFloat(3)
        blossom.scaleRange = CGFloat(0.2)
        blossom.scaleSpeed = CGFloat(-0.05)
        blossom.contents = imageForType(type)!.cgImage
        return blossom
    }
    
    open func isActive() -> Bool {
        return self.active
    }
}
