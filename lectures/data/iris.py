from sklearn.datasets import load_iris
import matplotlib.pyplot as plt

iris = load_iris()

def plot_iris(f1, f2):
    n_samples = len(iris.target)
    for t in set(iris.target):
        x = [iris.data[i,f1] for i in range(n_samples) if iris.target[i]==t]
        y = [iris.data[i,f2] for i in range(n_samples) if iris.target[i]==t]
        plt.scatter(x,
                    y,
                    color=['lightblue', 'orange', 'green'][t],
                    label=iris.target_names[t])
    plt.xlabel(iris.feature_names[f1])
    plt.ylabel(iris.feature_names[f2])
    plt.title('Iris Dataset')
    plt.legend(iris.target_names, loc='lower right')
    plt.show()

n_features = len(iris.feature_names)
pairs = [(i, j) for i in range(n_features) for j in range(i+1, n_features)]

for (f1, f2) in pairs:
    plot_iris(f1, f2)


