/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class SkyView: UIView {
  private var rageLevel: RageLevel = .happy

  func setRageLevel(_ rageLevel: RageLevel) {
    self.rageLevel = rageLevel
    setNeedsDisplay()
  }
  
  private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return CGFloat.pi * degrees / 180.0
  }

  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }

    let colorSpace = CGColorSpaceCreateDeviceRGB()

    drawSky(in: rect, rageLevel: rageLevel, context: context, colorSpace: colorSpace)
    drawMountains(in: rect, in: context, with: colorSpace)
    drawGrass(in: rect, in: context, with: colorSpace)
    drawFlowers(in: rect, in: context, with: colorSpace)
  }

  private func drawSky(in rect: CGRect, rageLevel: RageLevel, context: CGContext,
                       colorSpace: CGColorSpace) {
    let baseColor: UIColor
    let middleStop: UIColor
    let farStop: UIColor

    switch rageLevel {
    case .happy:
      baseColor = UIColor(red: 0 / 255.0, green: 158.0 / 255.0,
                          blue: 183.0 / 255.0, alpha: 1.0)
      middleStop = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0,
                           blue: 252.0 / 255.0, alpha: 1.0)
      farStop = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0,
                        blue: 255.0 / 255.0, alpha: 1.0)
    case .somewhatHappy:
      baseColor = UIColor(red: 0 / 255.0, green: 158.0 / 255.0,
                          blue: 183.0 / 255.0, alpha: 1.0)
      middleStop = UIColor(red: 144.0 / 255.0, green: 152.0 / 255.0,
                           blue: 253.0 / 255.0, alpha: 1.0)
      farStop = UIColor(red: 96.0 / 255.0, green: 111.0 / 255.0,
                        blue: 144.0 / 255.0, alpha: 1.0)
    case .neutral:
      baseColor = UIColor(red: 148.0 / 255.0, green: 158.0 / 255.0,
                          blue: 183.0 / 255.0, alpha: 1.0)
      middleStop = UIColor(red: 127.0 / 255.0, green: 138.0 / 255.0,
                           blue: 166.0 / 255.0, alpha: 1.0)
      farStop = UIColor(red: 96.0 / 255.0, green: 111.0 / 255.0,
                        blue: 144.0 / 255.0, alpha: 1.0)
    case .somewhatAngry:
      baseColor = UIColor(red: 255.0 / 255.0, green: 147.0 / 255.0,
                          blue: 167.0 / 255.0, alpha: 1.0)
      middleStop = UIColor(red: 127.0 / 255.0, green: 138.0 / 255.0,
                           blue: 166.0 / 255.0, alpha: 1.0)
      farStop = UIColor(red: 107.0 / 255.0, green: 107.0 / 255.0,
                        blue: 107.0 / 255.0, alpha: 1.0)
    case .angry:
      baseColor = UIColor(red: 255.0 / 255.0, green: 0 / 255.0,
                          blue: 0 / 255.0, alpha: 1.0)
      middleStop = UIColor(red: 140.0 / 255.0, green: 33.0 / 255.0,
                           blue: 33.0 / 255.0, alpha: 1.0)
      farStop = UIColor(red: 0 / 255.0, green: 0 / 255.0,
                        blue: 0 / 255.0, alpha: 1.0)
    }

    context.saveGState()
    defer { context.restoreGState() }

    let gradientColors = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
    let locations: [CGFloat] = [0.0, 0.1, 0.25]

    let startPoint = CGPoint(x: rect.size.height/2, y: 0)
    let endPoint = CGPoint(x: rect.size.height/2, y: rect.size.width)

    if let gradient = CGGradient.init(colorsSpace: colorSpace,
                                      colors: gradientColors as CFArray,
                                      locations: locations) {
      context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
  }

  
  private func drawMountains(in rect: CGRect, in context: CGContext,
                     with colorSpace: CGColorSpace?) {
    let darkColor = UIColor(red: 1.0 / 255.0, green: 93.0 / 255.0,
                            blue: 67.0 / 255.0, alpha: 1)
    let lightColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0,
                             blue: 79.0 / 255.0, alpha: 1)
    let rectWidth = rect.size.width

    let mountainColors = [darkColor.cgColor, lightColor.cgColor]
    let mountainLocations: [CGFloat] = [0.1, 0.2]
    guard let mountainGrad = CGGradient.init(colorsSpace: colorSpace,
          colors: mountainColors as CFArray, locations: mountainLocations) else {
      return
    }

    let mountainStart = CGPoint(x: rect.size.height / 2, y: 100)
    let mountainEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)

    context.saveGState()
    defer { context.restoreGState() }

    let backgroundMountains = CGMutablePath()
    backgroundMountains.move(to: CGPoint(x: -5, y: 157), transform: .identity)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 77, y: 157),
                                     control: CGPoint(x: 30, y: 129),
                                     transform: .identity)
    backgroundMountains.addCurve(to: CGPoint(x: 303, y: 125),
                                 control1: CGPoint(x: 190, y: 210),
                                 control2: CGPoint(x: 200, y: 70),
                                 transform: .identity)
    
    backgroundMountains.addQuadCurve(to: CGPoint(x: 350, y: 150),
                                     control: CGPoint(x: 340, y: 150),
                                     transform: .identity)
    backgroundMountains.addQuadCurve(to: CGPoint(x: 410, y: 145),
                                     control: CGPoint(x: 380, y: 155),
                                     transform: .identity)
    backgroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 165),
                                 control1: CGPoint(x: rectWidth - 90, y: 100),
                                 control2: CGPoint(x: rectWidth - 50, y: 190),
                                 transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: rectWidth - 10, y: rect.size.width),
                                transform: .identity)
    backgroundMountains.addLine(to: CGPoint(x: -5, y: rect.size.width),
                                transform: .identity)
    backgroundMountains.closeSubpath()

    // Background Mountain Drawing
    context.addPath(backgroundMountains)
    context.clip()
    context.drawLinearGradient(mountainGrad, start: mountainStart,
                               end: mountainEnd, options: [])
    context.setLineWidth(4)

    // Background Mountain Stroking
    context.addPath(backgroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()

    // Foreground Mountains
    let foregroundMountains = CGMutablePath()
    foregroundMountains.move(to: CGPoint(x: -5, y: 190),
                             transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: 303, y: 190),
                                 control1: CGPoint(x: 160, y: 250),
                                 control2: CGPoint(x: 200, y: 140),
                                 transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 210),
                                 control1: CGPoint(x: rectWidth - 150, y: 250),
                                 control2: CGPoint(x: rectWidth - 50, y: 170),
                                 transform: .identity)
    foregroundMountains.addLine(to: CGPoint(x: rectWidth, y: 230),
                                transform: .identity)
    foregroundMountains.addCurve(to: CGPoint(x: -5, y: 225),
                                 control1: CGPoint(x: 300, y: 260),
                                 control2: CGPoint(x: 140, y: 215),
                                 transform: .identity)
    foregroundMountains.closeSubpath()

    // Foreground Mountain drawing
    context.addPath(foregroundMountains)
    context.clip()
    context.setFillColor(darkColor.cgColor)
    context.fill(CGRect(x: 0, y: 170, width: rectWidth, height: 90))

    // Foreground Mountain stroking
    context.addPath(foregroundMountains)
    context.setStrokeColor(UIColor.black.cgColor)
    context.strokePath()



  }

  private func drawGrass(in rect: CGRect, in context: CGContext,
                         with colorSpace: CGColorSpace?) {
    // 1
    context.saveGState()
    defer { context.restoreGState() }

    // 2
    let grassStart = CGPoint(x: rect.size.height / 2, y: 100)
    let grassEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
    let rectWidth = rect.size.width

    let grass = CGMutablePath()
    grass.move(to: CGPoint(x: rectWidth, y: 230), transform: .identity)
    grass.addCurve(to: CGPoint(x: 0, y: 225), control1: CGPoint(x: 300, y: 260),
                   control2: CGPoint(x: 140, y: 215),
                   transform: .identity)
    grass.addLine(to: CGPoint(x: 0, y: rect.size.width),
                  transform: .identity)
    grass.addLine(to: CGPoint(x: rectWidth, y: rect.size.width),
                  transform: .identity)

    context.addPath(grass)
    context.clip()

    // 3
    let lightGreen = UIColor(red: 39.0 / 255.0, green: 171.0 / 255.0,
                             blue: 95.0 / 255.0, alpha: 1)

    let darkGreen = UIColor(red: 0.0 / 255.0, green: 134.0 / 255.0,
                            blue: 61.0 / 255.0, alpha: 1)

    let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
    let grassLocations: [CGFloat] = [0.3, 0.4]
    if
      let grassGrad = CGGradient.init(colorsSpace: colorSpace,
      colors: grassColors as CFArray, locations: grassLocations) {
        context.drawLinearGradient(grassGrad, start: grassStart,
                                   end: grassEnd, options: [])
    }
  }

  

  private func drawFlowers(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
      context.saveGState()
      defer { context.restoreGState() }

      // Definir el tamaño más adecuado para la capa de flores
      let flowerSize = CGSize(width: 40, height: 40)

      // Crear una capa para las flores
      guard let flowerLayer = CGLayer(context, size: flowerSize, auxiliaryInfo: nil) else {
          return
      }

      guard let flowerContext = flowerLayer.context else {
          return
      }

      // Número aleatorio de flores a generar
      let numberOfFlowers = Int.random(in: 10...20) // Puedes cambiar este rango

      // Generar flores en posiciones aleatorias
      for _ in 0..<numberOfFlowers {
          let randomX = CGFloat.random(in: 50..<rect.size.width - 50)
          let randomY = CGFloat.random(in: rect.size.height - 200..<rect.size.height - 50) // Solo en la parte inferior

          // Dibujar las flores
        //  drawFlower(at: CGPoint(x: 0, y: 0), in: flowerContext)  // Dibujar la flor en (0,0) dentro de la capa

          // Dibujar la flor en el contexto principal, trasladando a la posición aleatoria
          context.draw(flowerLayer, at: CGPoint(x: randomX, y: randomY))
      }
  }

  private func drawFlower(at position: CGPoint, in context: CGContext) {
      // Dibujar los pétalos de la flor
      drawPetal(in: CGRect(x: 10, y: 10, width: 9, height: 14), inDegrees: 0, inContext: context)
      drawPetal(in: CGRect(x: 0, y: 16, width: 10, height: 12), inDegrees: 300, inContext: context)
      drawPetal(in: CGRect(x: 5, y: 26, width: 9, height: 14), inDegrees: 5, inContext: context)
      drawPetal(in: CGRect(x: 13, y: 26, width: 9, height: 14), inDegrees: 350, inContext: context)
      drawPetal(in: CGRect(x: 18, y: 16, width: 11, height: 14), inDegrees: 80, inContext: context)

      // Centro de la flor (círculo)
      let center = CGMutablePath()
      let ellipse = CGRect(x: 6, y: 22, width: 6, height: 6)
      center.addEllipse(in: ellipse, transform: .identity)

      let orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0, blue: 49.0 / 255.0, alpha: 1.0)

      context.addPath(center)
      context.setStrokeColor(UIColor.black.cgColor)
      context.strokePath()
      context.setFillColor(orangeColor.cgColor)
      context.addPath(center)
      context.fillPath()

      // Dibujar el tallo
      context.move(to: CGPoint(x: 15, y: 31))
      context.setStrokeColor(UIColor.black.cgColor)
      context.addQuadCurve(to: CGPoint(x: 13, y: 52), control: CGPoint(x: 20, y: 35))
      context.strokePath()
  }


   private func drawPetal(in rect: CGRect, inDegrees degrees: Int, inContext context: CGContext) {
     context.saveGState()
     defer { context.restoreGState() }

     let midX = rect.midX
     let midY = rect.midY
     let transform = CGAffineTransform(translationX: -midX, y: -midY)
       .concatenating(CGAffineTransform(rotationAngle: degreesToRadians(CGFloat(degrees))))
       .concatenating(CGAffineTransform(translationX: midX, y: midY))

     let flowerPetal = CGMutablePath()
     flowerPetal.addEllipse(in: rect, transform: transform)
     context.addPath(flowerPetal)
     context.setStrokeColor(UIColor.black.cgColor)
     context.strokePath()
     context.setFillColor(UIColor.white.cgColor)
     context.addPath(flowerPetal)
     context.fillPath()
   }


}

