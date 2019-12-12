//
//  ViewController.swift
//  MTLearn
//
//  Created by Ting on 12/11/19.
//  Copyright © 2019 Ned. All rights reserved.
//

import UIKit
import MetalKit



class ViewController: UIViewController {

    var metalView : MTKView? {
        return self.view as? MTKView
    }
    
    var device : MTLDevice!
    var commandqueue : MTLCommandQueue!
    var pipline: MTLRenderPipelineState!
    var renderPiplineState: MTLRenderPipelineState!
    
    var verticesBuf : MTLBuffer?
    var textTureBuf: MTLBuffer?
    
    var lastDisplayTime = CFAbsoluteTimeGetCurrent()
    
    var vertices : [Vertex]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.initMetal()
        
    }
    func initMetal(){
        device = MTLCreateSystemDefaultDevice()
        commandqueue = device.makeCommandQueue()
        metalView?.device = device
        metalView!.delegate = self
        metalView!.clearColor = MTLClearColor(red: 0.4, green: 0.7, blue: 0.3, alpha: 1.0)
        metalView!.colorPixelFormat = .bgra8Unorm
        
        self.createRenderPiplineState()
//        self.buildModel()
    }
    
//    func buildModel(){
//        self.verticesBuf = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
//    }
    
    
    var leftx : Float = 0.1          //-0.5 ~  0.5
    var bottomleft : Float = 0.1     //-1.0 ~  0.0
    var bottomright : Float = 0.1    //0.0  ~  1
    var increasing : Float = 0.005
    func getVerticeBuf() -> MTLBuffer{
        
        func innerInc( value: inout Float, inc: Float, begin: Float){
            if value < 1.0{
                value += inc
            }else{
                value = begin
            }
        }
    
        innerInc(value: &leftx, inc: increasing, begin: -0.5)
        innerInc(value: &bottomleft, inc: increasing, begin: -1.0)
        innerInc(value: &bottomright, inc: increasing, begin: 0.0)
        
        let ranVertice: [Float] =
        [
            leftx,1,0,
            bottomleft,-1,0,
            bottomright,0.5,0,
        ]
        
        let usingStruct = true
        if usingStruct{
            vertices = [
                Vertex(position: float3(leftx,1,0), color: float4(1,0,0,1)),
                Vertex(position: float3(bottomleft,-1,0), color: float4(0,1,0,1)),
                Vertex(position: float3(bottomright,0.5,0), color: float4(0,0,1,1)),
            ]
            return device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])!
        }
        
        return device.makeBuffer(bytes: ranVertice, length: vertices.count * MemoryLayout<Float>.size, options: [])!
    }
    
    
    func createRenderPiplineState(){
        
        guard let library = device.makeDefaultLibrary(),
            let vertextFunction = library.makeFunction(name: "vertex_shader"),
        let fragmentFunction = library.makeFunction(name: "fragment_shader") else{
            print("error:device.makeDefaultLibrary fail")
            return
        }
    
        
        //using MTLVertexDescriptor
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
        
        let renderPiplineDescriptor = MTLRenderPipelineDescriptor()
        renderPiplineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPiplineDescriptor.vertexFunction = vertextFunction
        renderPiplineDescriptor.fragmentFunction = fragmentFunction
        renderPiplineDescriptor.vertexDescriptor = vertexDescriptor

        
        self.renderPiplineState = try? device.makeRenderPipelineState(descriptor: renderPiplineDescriptor)
    }


}

extension ViewController : MTKViewDelegate{
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize){
        
        
        
    }
    
    func draw(in view: MTKView){
        guard let descripter = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable else {
            print("error:descripter is nil")
            return
        }
        
        if CFAbsoluteTimeGetCurrent() - lastDisplayTime < 0.001{
            return
        }
        
        let commanderBuffer = commandqueue.makeCommandBuffer()
        let renderCommanderBufferEncoder = commanderBuffer?.makeRenderCommandEncoder(descriptor: descripter)
        renderCommanderBufferEncoder?.setRenderPipelineState(self.renderPiplineState)
        renderCommanderBufferEncoder?.setVertexBuffer(self.getVerticeBuf(), offset: 0, index: 0)
        renderCommanderBufferEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
        
        renderCommanderBufferEncoder?.endEncoding()
        commanderBuffer?.present(drawable)
        commanderBuffer?.commit()
    }
    
}

