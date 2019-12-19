//
//  Engine.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import MetalKit

class Engine {
    
    public static var device: MTLDevice!
    
    public static var commandQueue: MTLCommandQueue!
    
    public static func ignite(device: MTLDevice){
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        
        ShaderLibrary.initialize()
        VertexDescriptorLibrary.initialize()
        RenderPipelineDescriptorLibrary.initialize()
        RenderPipelineStateLibrary.initialize()
    }
    
}
