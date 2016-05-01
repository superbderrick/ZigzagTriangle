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
  var shader: BaseEffect!
  
  var vertexBuffer : GLuint = 0
  var indexBuffer  : GLuint = 0
  
  let vertices : [Vertex] = [
    //center  Top Triangle.
    
//    Vertex(0.0  , 0.25,0.0 , 0.0,0.0,1.0,1.0),    // TOP
//    Vertex(-0.25, 0.0 ,0.0 , 0.0,0.0,1.0,1.0),    // LEFT
//    Vertex( 0.25, 0.0 ,1.0 , 0.0,0.0,1.0,1.0),    // RIGHT

    //center  Bottom Triangle.
    Vertex( 0.0 , -0.25, 0.0, 0.5,0.0,0.0,1.0),  // Bottom
    Vertex(-0.25, 0.0  , 0.0, 0.5,0.0,0.0,1.0),    // LEFT
    Vertex( 0.25, 0.0  , 0.0, 0.5,0.0,0.0,1.0),    // RIGHT
    
//    //Right.
//    Vertex( 0.25,  0.0, 0.0,1.0, 0.0, 0.0, 1.0),    // LEFT
//    Vertex(0.50, 0.25, 0.0,1.0, 0.0, 0.0, 1.0),    // Top.
//    Vertex( 0.75, 0.0, 0.0,1.0, 0.0, 0.0, 1.0),    // Right.
//    
//    Vertex( 0.25,  0.0, 0.0,1.0, 0.0, 0.0, 1.0),    // LEFT
//    Vertex(0.50, -0.25, 0.0,1.0, 0.0, 0.0, 1.0),    // Bottom.
//    Vertex( 0.75, 0.0, 0.0,1.0, 0.0, 0.0, 1.0),    // Right.
//    
//    //Left
//    Vertex(-0.25,  0.00, 0.0,1.0, 0.0, 0.0, 1.0),    // Left
//    Vertex(-0.50, 0.25, 0.0,1.0, 0.0, 0.0, 1.0),    // Top.
//    Vertex( -0.75, 0.0, 0.0,1.0, 0.0, 0.0, 1.0),    // Right.
//    
//    Vertex( -0.25,  0.0, 0.0,0.8, 0.0, 0.0, 1.0),    // LEFT
//    Vertex(-0.50, -0.25, 0.0,0.8, 0.0, 0.0, 1.0),    // Bottom.
//    Vertex( -0.75, 0.0, 0.0,0.8, 0.0, 0.0, 1.0),    // Right.

  ]
  
  let indices : [GLubyte] = [
    0, 1, 2,
    2, 3, 0
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //setupGL
    setupGLContext()
    setupGLUpdater()
    setupShaders()
    setupVertexBuffers()
  }
  
  override func glkView(view: GLKView, drawInRect rect: CGRect) {
    glClearColor(1.0, 1.0, 0.0, 1.0);
    glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    
    shader.drawFigure()
    
    glEnableVertexAttribArray(VertexAttributes.VertexAttribPosition.rawValue)
    glVertexAttribPointer(
      VertexAttributes.VertexAttribPosition.rawValue,
      3,
      GLenum(GL_FLOAT),
      GLboolean(GL_FALSE),
      GLsizei(sizeof(Vertex)), nil)
    
    glEnableVertexAttribArray(VertexAttributes.Color.rawValue)
    glVertexAttribPointer(
      VertexAttributes.Color.rawValue,
      4,
      GLenum(GL_FLOAT),
      GLboolean(GL_FALSE),
      GLsizei(sizeof(Vertex)), BUFFER_OFFSET(3 * sizeof(GLfloat))) // x, y, z | r, g, b, a :: offset is 3*sizeof(GLfloat)
    
    
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
    glDrawArrays(GLenum(GL_TRIANGLES), 0, GLsizei(vertices.count))
    glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
    
    
    
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
  
  func setupVertexBuffers () {
    let postionCount = vertices.count
    let postionSize  =  sizeof(Vertex)
    let colorCount = indices.count
    let colorSize  =  sizeof(GLubyte)
    
    //setup buffer of postion.
    glGenBuffers(GLsizei(1), &vertexBuffer)
    glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
    glBufferData(GLenum(GL_ARRAY_BUFFER), postionCount * postionSize, vertices, GLenum(GL_STATIC_DRAW))
    
    //setup buffer of color.
    glGenBuffers(GLsizei(1), &indexBuffer)
    glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
    glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), colorCount * colorSize, indices, GLenum(GL_STATIC_DRAW))
    
  }
  
  func BUFFER_OFFSET(n: Int) -> UnsafePointer<Void> {
    let ptr: UnsafePointer<Void> = nil
    return ptr + n
  }


}

