//
//  GLBaseEffect.swift
//  Triangle
//
//  Created by burt on 2016. 2. 25..
//  Copyright © 2016년 BurtK. All rights reserved.
//

import Foundation
import GLKit

class BaseEffect {
  
  var programHandle : GLuint = 0
  
  init(vertexShader: String, fragmentShader: String) {
    NSLog("%@", "BaseEffect init !!!!")
    self.compile(vertexShader: vertexShader, fragmentShader: fragmentShader)
  }
  
  func prepareToDraw() {
    glUseProgram(self.programHandle)
  }
}

extension BaseEffect {
  func compileShader(shaderName: String, shaderType: GLenum) -> GLuint {
    let path = NSBundle.mainBundle().pathForResource(shaderName, ofType: nil)
    
    do {
      
      let shaderString = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
      let shaderHandle = glCreateShader(shaderType)
      var shaderStringLength : GLint = GLint(Int32(shaderString.length))
      var shaderCString = shaderString.UTF8String as UnsafePointer<GLchar>
      glShaderSource(
        shaderHandle,
        GLsizei(1),
        &shaderCString,
        &shaderStringLength)
      
      glCompileShader(shaderHandle)
      var compileStatus : GLint = 0
      glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileStatus)
      
      if compileStatus == GL_FALSE {
        var infoLength : GLsizei = 0
        let bufferLength : GLsizei = 1024
        glGetShaderiv(shaderHandle, GLenum(GL_INFO_LOG_LENGTH), &infoLength)
        
        let info : [GLchar] = Array(count: Int(bufferLength), repeatedValue: GLchar(0))
        var actualLength : GLsizei = 0
        
        glGetShaderInfoLog(shaderHandle, bufferLength, &actualLength, UnsafeMutablePointer(info))
        NSLog(String(UTF8String: info)!)
        exit(1)
      }
      
      return shaderHandle
      
    } catch {
      exit(1)
    }
  }
  
  func compile(vertexShader vertexShader: String, fragmentShader: String) {
    NSLog("%@", "shaders compile  compile !!!!")
    let vertexShaderName = self.compileShader(vertexShader, shaderType: GLenum(GL_VERTEX_SHADER))
    let fragmentShaderName = self.compileShader(fragmentShader, shaderType: GLenum(GL_FRAGMENT_SHADER))
    
    self.programHandle = glCreateProgram()
    glAttachShader(self.programHandle, vertexShaderName)
    glAttachShader(self.programHandle, fragmentShaderName)
    
    glBindAttribLocation(self.programHandle, VertexAttributes.VertexAttribPosition.rawValue, "a_Position")
    glLinkProgram(self.programHandle)
    
    var linkStatus : GLint = 0
    glGetProgramiv(self.programHandle, GLenum(GL_LINK_STATUS), &linkStatus)
    if linkStatus == GL_FALSE {
      var infoLength : GLsizei = 0
      let bufferLength : GLsizei = 1024
      glGetProgramiv(self.programHandle, GLenum(GL_INFO_LOG_LENGTH), &infoLength)
      
      let info : [GLchar] = Array(count: Int(bufferLength), repeatedValue: GLchar(0))
      var actualLength : GLsizei = 0
      
      glGetProgramInfoLog(self.programHandle, bufferLength, &actualLength, UnsafeMutablePointer(info))
      NSLog(String(UTF8String: info)!)
      exit(1)
    }
  }
}