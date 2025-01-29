import numpy as np
import matplotlib.pyplot as plt
from scipy.linalg import svd
from sos import Sos


def condition_number(p,m):
    X = np.random.randn(p,m)
    _, S, _ = svd(X)
    return S[0]/S[p-1]



for p in [10, 50, 100]:
    cn_mean = []
    cn_err = []
    mop = []
    for i in range(2,21):
        m = int(0.5*i*p)
        mop.append(0.5*i)
        cn = Sos()
        no_iter = 20 if i==2 else 80
        for _ in range(no_iter):
            cn += condition_number(p, m)
        cn_mean.append(cn.av())
        cn_err.append(cn.err())
    plt.errorbar(mop, cn_mean, cn_err, label=f"{p=}",capsize=5)

plt.yscale("log")
plt.xlabel(r'$\frac{m}{p}$')
plt.ylabel(r'$E[s_{max}/s_{min}]$')
plt.xlim(0,10);
plt.ylim(1,1.0e4)
plt.legend()
plt.savefig("condition_number.pdf")
plt.show()

