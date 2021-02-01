
//swift -Xfrontend -enable-experimental-forward-mode-differentiation this_file.swift 



import _Differentiation
import Foundation 


@differentiable
func f(_ x: Float) -> Float {
    x * x
}


let dfdx = derivative(of: f)
print(dfdx(3))


struct Perceptron: Differentiable {
    var weights: [Float]
    var bias: Float

    @differentiable
    func callAsFunction(_ input: [Float]) -> Float {
        y=[Float]
        for i in 0...input.count {
            y.append(weights[i]*input[i]+bias)
        }

    }
}

let iterationCount = 160
let learningRate: Float = 0.00003

var model = Perceptron(weights: .zero, bias: 0)

for i in 0..<iterationCount {
    var (loss, 𝛁loss) = valueWithGradient(at: model) { model -> Float in
        var totalLoss: Float = 0
        for (x, y) in data {
            let pred = model(x)
            let diff = y - pred
            totalLoss = totalLoss + diff * diff / Float(data.count)
        }
        return totalLoss
    }
    𝛁loss.weight *= -learningRate
    𝛁loss.bias *= -learningRate
    model.move(along: 𝛁loss)
    if i.isMultiple(of: 10) {
        print("Iteration: \(iteration) Avg Loss: \(loss / Float(data.count))")
    }
}