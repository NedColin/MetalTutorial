import MetalKit

enum RenderPipelineDescriptorTypes {
    case Basic
}

class RenderPipelineDescriptorLibrary{
    
    private static var renderPipelineDescriptors: [RenderPipelineDescriptorTypes: RenderPipelineDescriptor] = [:]
    
    public static func initialize(){
        createDefaultRenderPiplineDescriptors()
    }
    
    private static func createDefaultRenderPiplineDescriptors(){
        renderPipelineDescriptors.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
    }
    
    public static func descriptor(_ renderPipelineDescriptorType: RenderPipelineDescriptorTypes) -> MTLRenderPipelineDescriptor{
        return renderPipelineDescriptors[renderPipelineDescriptorType]!.renderPipelineDescriptor
    }
    
    
}


protocol RenderPipelineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor{ get }
}

public struct Basic_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Render Pipline Descriptor"
    var renderPipelineDescriptor : MTLRenderPipelineDescriptor{
        
        let des = MTLRenderPipelineDescriptor()
        
        des.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        des.vertexFunction = ShaderLibrary.Vertex(.Basic)
        des.fragmentFunction = ShaderLibrary.Fragment(.Basic)
        des.vertexDescriptor = VertexDescriptorLibrary.descriptor(.Basic)
        return des
    }
}
