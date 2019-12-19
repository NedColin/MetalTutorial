//
//  Renderer.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import Foundation
import MetalKit

class Renderer: NSObject {
    let gameObj = GameObject()
}

extension Renderer: MTKViewDelegate{
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        gameObj.render(view: view)
    }
    
    
}
