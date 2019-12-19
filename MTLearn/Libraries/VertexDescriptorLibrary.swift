//
//  VertexDescriptorLibrary.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import MetalKit

enum VertexDescriptorTypes{
    case Basic
}

class VertexDescriptorLibrary {
    
    private static var vertexDescriptors: [VertexDescriptorTypes: VertexDescriptor] = [:]
    
    public static func initialize(){
        createDefaultVertextDescriptors()
    }
    
    private static func createDefaultVertextDescriptors(){
        vertexDescriptors.updateValue(Basic_VertextDescriptor(), forKey: .Basic)
    }
    
    public static func descriptor(_ vertexDescriptorType: VertexDescriptorTypes) -> MTLVertexDescriptor{
        return vertexDescriptors[vertexDescriptorType]!.vetexDescriptor
    }
    
}


protocol VertexDescriptor {
    
    var name: String{get}
    var vetexDescriptor: MTLVertexDescriptor{ get }
    
}

public struct Basic_VertextDescriptor: VertexDescriptor{
    var name: String = "Basic Vertex Descriptor"
    
    var vetexDescriptor: MTLVertexDescriptor{
        let vertexDescriptor = MTLVertexDescriptor()
        
        //position
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        //color
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = float3.size()
        
        vertexDescriptor.layouts[0].stride = Vertex.stride()
        
        return vertexDescriptor
    }
}

