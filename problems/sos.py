#! /usr/bin/python

import math
import numbers

class Sos:
    """Second order statistics class"""

    def __init__(self):
        self.zero()

    def zero(self):
        self.count = 0.0
        self.aver = 0.0
        self.nvar = 0.0

    def av(self):
        return self.aver

    def number(self):
        return int(self.count)

    def addScalar(self, x):
        delta = (x-self.aver)/(self.count+1.0)
        self.nvar = self.nvar + self.count*delta*(x-self.aver)
        self.aver = self.aver + delta
        self.count = self.count + 1

    def addIter(self, it):
        [self.addScalar(x) for x in it]

    def addTensor(self, t):
        [self.addScalar(x) for x in t.flatten().tolist()]

    def __iadd__(self, rhs):
        if isinstance(rhs, numbers.Real):
            self.addScalar(rhs)
#        elif isinstance(rhs, torch.Tensor):
#           self.addTensor(rhs)
        else:
            self.addIter(rhs)
        return self
        
    def var(self):
        if self.count>1.0:
            return self.nvar/(self.count-1.0)
        else:
            return 0.0
    def sd(self):
        if self.var>0.0:
            return math.sqrt(self.nvar)
        else:
            return 0.0
    def err(self):
        if self.var()>0.0:
            return math.sqrt(self.var()/self.count)
        else:
            return 0.0
    def __repr__(self):
        fs = "n={:.0f} av={:.4g} nvar={:.4g} err={:.4g}"
        return fs.format(self.count, self.aver, self.nvar, self.err())
    
    def __str__(self):
        err = self.err()
        if err == 0:
            prec = 4
        else:
            prec = max(2, math.ceil(0.5+math.log10(abs(self.av()/err))))
        fs = "{:#." + str(prec) + "g} +/- {:.1g}"
        return fs.format(self.av(), self.err())

    def to_prec(self):
        err = self.err()
        if err == 0:
            prec = 4
        else:
            prec = max(2, math.ceil(0.5+math.log10(abs(self.av()/err))))
        fs = "{:#." + str(prec) + "g}"
        return fs.format(self.av())
