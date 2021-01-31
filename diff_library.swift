
//swift -Xfrontend -enable-experimental-forward-mode-differentiation this_file.swift 



import _Differentiation
import Foundation 


@differentiable
func f(_ x: Float) -> Float {
    x * x
}


let dfdx = derivative(of: f)
print(dfdx(3))


struct Perceptron: @memberwise Differentiable {
    var weight: SIMD2<Float> = .random(in: -1..<1)
    var bias: Float = 0

    @differentiable
    func callAsFunction(_ input: SIMD2<Float>) -> Float {
        (weight * input).sum() + bias
    }
}

var model = Perceptron()
let andGateData: [(x: SIMD2<Float>, y: Float)] = [
    (x: [0, 0], y: 0),
    (x: [0, 1], y: 0),
    (x: [1, 0], y: 0),
    (x: [1, 1], y: 1),
]
for _ in 0..<100 {
    let (loss, 𝛁loss) = valueWithGradient(at: model) { model -> Float in
        var loss: Float = 0
        for (x, y) in andGateData {
            let ŷ = model(x)
            let error = y - ŷ
            loss = loss + error * error / 2
        }
        return loss
    }
    print(loss)
    model.weight -= 𝛁loss.weight * 0.02
    model.bias -= 𝛁loss.bias * 0.02
}