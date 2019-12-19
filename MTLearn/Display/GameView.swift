//
//  GameView.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import Foundation
import MetalKit

class GameView: MTKView{
    
    //must be lazy var, or will crash
    lazy var renderer : Renderer = {
       return Renderer()
    }()
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.initMetal()
    }
    
    func initMetal(){
        self.device = MTLCreateSystemDefaultDevice()
        Engine.ignite(device: device!)
        self.clearColor = MTLClearColor(red: 0.4, green: 0.7, blue: 0.3, alpha: 1.0)
        self.colorPixelFormat = .bgra8Unorm
        
        self.delegate = renderer
    }
        
}



