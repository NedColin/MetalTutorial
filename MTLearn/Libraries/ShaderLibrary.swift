//
//  ShaderLibrary.swift
//  MTLearn
//
//  Created by Ting on 12/19/19.
//  Copyright © 2019 Ned. All rights reserved.
//

//import Foundation
import MetalKit


enum VertexShaderTypes{
    case Basic
}

enum FragmentShaderTypes{
    case Basic
}

class ShaderLibrary{
    
    public static var defaultLibrary: MTLLibrary!
    
    //here protocol can be use to define as a value
    private static var vertexShaders: [VertexShaderTypes: Shader] = [:]
    private static var fragmentShaders: [FragmentShaderTypes: Shader] = [:]
    
    public static func initialize() {
        defaultLibrary = Engine.device.makeDefaultLibrary()!
        createDefaultShaders()
    }
    
    private static func createDefaultShaders(){
        //Vertex Shaders
        vertexShaders.updateValue(Basic_VertextShader(), forKey: .Basic)
        fragmentShaders.updateValue(Basic_FragmentShader(), forKey: .Basic)
    }
    
    public static func Vertex(_ vertextType: VertexShaderTypes) -> MTLFunction?{
        let item: Shader? = vertexShaders[vertextType]
        return item!.function
    }
    
    public static func Fragment(_ fragmentType: FragmentShaderTypes) -> MTLFunction?{
        let item: Shader? =  fragmentShaders[fragmentType]
        return item!.function
    }
    
}

protocol Shader {
    var name: String {get}
    var functionName: String {get}
    var function: MTLFunction {get}
}

//struct Shader {
//    var name: String!
//    var functionName: String!
//    var function: MTLFunction!
//
//}

public struct Basic_VertextShader: Shader {
    var name: String = "Basic Vertex Shader"
    
    var functionName: String = "vertex_shader"
    
    lazy var funName_ecc: String = {
        return self.name
    }()
    
    var function: MTLFunction {
        let function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name
        return function!
    }
}

public struct Basic_FragmentShader: Shader{
    
    var name: String = "Basic Fragment Shader"
    
    var functionName: String = "fragment_shader"
    
    lazy var funName_ecc: String = {
        return self.name
    }()
    
    var function: MTLFunction {
        let function = ShaderLibrary.defaultLibrary.makeFunction(name: functionName)
        function?.label = name
        return function!
    }
}
