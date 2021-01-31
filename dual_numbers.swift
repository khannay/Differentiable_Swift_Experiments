

import Foundation

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


func h(_ x: Dual)-> Dual {
    return pow(x,2.0)+2.0*exp(x)*sin(10.0*x+pow(x,10.0))
}


func rhs_ode(_ R: Dual) {
    
}

var b: Dual=h(Dual(1.0))

print("Value: \(b.val) with deriv: \(b.der)")