//
//  RenderPipelineStateLibrary.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import Foundation
import MetalKit

enum RenderPipelineStateTypes{
    case Basic
}

class RenderPipelineStateLibrary{
    
    private static var renderPipelineStates: [RenderPipelineStateTypes: RenderPipelineState] = [:]
    
    public static func initialize(){
        self.createDefaultRenderPipelineState()
    }
    
    private static func createDefaultRenderPipelineState(){
        renderPipelineStates.updateValue(Basic_RenderPipelineState(), forKey: .Basic)
    }
    
    public static func piplineState(_ renderPipelineStateType: RenderPipelineStateTypes) -> MTLRenderPipelineState{
        return renderPipelineStates[renderPipelineStateType]!.renderPipelineSate
    }
    
    
}

protocol RenderPipelineState {
    var name: String{ get }
    var renderPipelineSate: MTLRenderPipelineState{ get }
}

public struct Basic_RenderPipelineState: RenderPipelineState{
    var name: String = "Basic Render Pipeline State"
    var renderPipelineSate: MTLRenderPipelineState{
        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLibrary.descriptor(.Basic))
        } catch let error as NSError {
            print("error:\(error)")
        }
        
        return renderPipelineState
    }
}
