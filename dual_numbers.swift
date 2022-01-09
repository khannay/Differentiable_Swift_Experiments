

import Foundation
//import _Differentiation 


// Should make these SIMD values, ideally want to 
// be able to use these anywhere that we have a numeric value 
// the resulting value givces the derv of the system with respect to that input

struct Dual {
    var val: Double 
    var der: Double 

    init(_ x: Double) {
        val=x
        der=1.0
    } 

    init(_ x: Double, _ y: Double) {
        val=x
        der=y
    }
}




extension Dual {


    //Basic Derivative Rules
    static func +(_ f: Dual, _ g: Dual) -> Dual {
        return Dual(f.val+g.val, f.der+g.der)
    }

    static func -(_ f: Dual, _ g: Dual) -> Dual {
        return Dual(f.val-g.val, f.der-g.der)
    }

    static func *(_ f: Dual, _ g: Dual) -> Dual {
        //product rule
        return Dual(f.val*g.val, f.der*g.val + f.val*g.der)
    }

    static func /(_ f: Dual, _ g: Dual) -> Dual {
        return Dual(f.val/g.val, (f.der*g.val - f.val*g.der)/(g.val*g.val))
    }

    static func ^(_ f: Dual, _ n: Double) -> Dual {
        return Dual(pow(f.val,n), n*pow(f.val, n-1)*f.der) 
    }

    //Constants 
    static func +(_ f: Dual, _ a: Double) -> Dual {
        return Dual(f.val+a, f.der)
    }

    static func +(_ a: Double, _ f: Dual) -> Dual {
        return Dual(f.val+a, f.der)
    }

    
    static func -(_ f: Dual, _ a: Double) -> Dual {
        return Dual(f.val-a, f.der)
    }

    static func -(_ a: Double, _ f: Dual) -> Dual {
        return Dual(f.val-a, f.der)
    }

    static func *(_ f: Dual, _ a: Double) -> Dual {
        return Dual(f.val*a, a*f.der)
    }

    static func *(_ a: Double, _ f: Dual) -> Dual {
        return Dual(f.val*a, a*f.der)
    }

    static func /(_ f: Dual, _ a: Double) -> Dual {
        return Dual(f.val/a, f.der/a)
    }

    static func /(_ a: Double, _ f: Dual) -> Dual {
        return Dual(a/f.val, -a*f.der/(pow(f.val, 2.0)))
    }

    
}


func pow(_ f: Dual, _ n: Double) -> Dual {
    return Dual(pow(f.val,n), n*pow(f.val,n-1.0)*f.der)
} 

func pow(_ f: Dual, _ n: Int) -> Dual {
    return pow(f, Double(n))
}


func exp(_ f: Dual) -> Dual {
    return Dual(exp(f.val), exp(f.val) * f.der) 
}

func sin(_ f: Dual) -> Dual {
    return Dual(sin(f.val), cos(f.val) * f.der) 
}

func tanh(_ f: Dual) -> Dual {
  return Dual(tanh(f.val), pow(1.0/cosh(f.val),2.0)*f.der)
}


func h(_ x: Dual)-> Dual {
    return pow(x,2.0)+2.0*exp(2*x)+tanh(x)
}

func hderv_analytical(_ x: Dual) -> Dual {
  return 2.0*x+4.0*exp(2*x)+1.0/cosh(x.val)
}


var b: Dual=h(Dual(0.0))

print("Value: \(b.val) with deriv: \(b.der), actual value is \(hderv_analytical(Dual(0.0)).val)")

