//
//  ViewController.swift
//  ZigzagTriangle
//
//  Created by Kang Jinyeoung on 2016. 4. 24..
//  Copyright © 2016년 SuperbDerrick. All rights reserved.
//

import UIKit
import GLKit

class ViewController: GLKViewController {
  
  var glkView: GLKView!
  var glkUpdater: GLKUpdater!
  var shader : BaseEffect!
  
  var vertexBuffer : GLuint = 0
  
  let vertices : [Vertex] = [
    Vertex( 0.0,  0.25, 0.0),    // TOP
    Vertex(-0.25, 0.0, 0.0),    // LEFT
    Vertex( 0.25, 0.0, 0.0),    // RIGHT
  ]
  
  let Secondvertices : [Vertex] = [
    Vertex( 0.0,  -0.25, 0.0),    // Bottom
    Vertex(-0.25, -0.25, 0.0),    // LEFT
    Vertex( 0.25, -0.25, 0.0),    // RIGHT
    
  ]
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //setupGL
    setupGLContext()
    setupGLUpdater()
    setupShaders()
    setupVertexBuffer()
  }
  
  override func glkView(view: GLKView, drawInRect rect: CGRect) {
    glClearColor(1.0, 1.0, 0.0, 1.0);
    glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    
    shader.prepareToDraw()
    
    glEnableVertexAttribArray(VertexAttributes.VertexAttribPosition.rawValue)
    glVertexAttribPointer(
      VertexAttributes.VertexAttribPosition.rawValue,
      3,
      GLenum(GL_FLOAT),
      GLboolean(GL_FALSE),
      GLsizei(sizeof(Vertex)), nil)
    
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
    glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
    
    glDisableVertexAttribArray(VertexAttributes.VertexAttribPosition.rawValue)
    
  }

  
  func setupGLContext () {
    NSLog("%@", "setupGLContext!!!!")
    
    glkView = self.view as! GLKView
    glkView.context = EAGLContext(API: .OpenGLES2)
    EAGLContext.setCurrentContext(glkView.context)
  }
  
  func setupGLUpdater () {
   NSLog("%@", "setupGLContext!!!!")
    
   self.glkUpdater = GLKUpdater(glkViewController: self)
   self.delegate = self.glkUpdater
  }
  
  func setupShaders() {
   NSLog("%@", "setupShaders!!!!")
    self.shader = BaseEffect(vertexShader: "VertexShader.glsl", fragmentShader: "FragmentShader.glsl")
  }
  
  func setupVertexBuffer () {
    glGenBuffers(GLsizei(1), &vertexBuffer)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
    let count = vertices.count
    let size =  sizeof(Vertex)
    glBufferData(GLenum(GL_ARRAY_BUFFER), count * size, vertices, GLenum(GL_STATIC_DRAW))
  }


}

