import numpy as np
import copy


class DE:
    def __init__(self, generations, F, Cr, pop_size, dimension, lower, upper):
        self.generations = generations
        self.F = F
        self.Cr = Cr
        self.pop_size = pop_size
        self.dimension = dimension
        self.pop = lower + np.random.random_sample((pop_size, dimension)) * (upper - lower)
        self.best = self.pop[np.argmin(np.sum(self.pop ** 2, axis=1))]

    def new_pop(self):
        r1, r2, r3 = self.getindex()
        Vi = self.pop[r1] + F * (self.pop[r2] - self.pop[r3])
        Vi = self.repair(Vi)
        j = np.random.random_sample((1, self.dimension)) < Cr
        ui = j * Vi + (1 - j) * self.pop[r1]
        if self.f(ui) < self.f(self.pop[r1]):
            self.pop[r1] = ui

    def getindex(self):
        index = np.argsort(np.random.random_sample((1, self.pop_size)))
        r1 = index[0][1]
        r2 = index[0][2]
        r3 = index[0][3]
        return r1, r2, r3

    def f(self, x):
        return np.sum(x ** 2)

    def repair(self, item):
        ele = copy.deepcopy(item)
        for i in ele:
            if i > upper:
                i = max(lower, 2 * upper - i)
            if i < lower:
                i = min(upper, 2 * lower - i)
        return ele

    def solution(self):
        for i in range(self.generations):
            self.new_pop()
            print(self.pop)


if __name__ == '__main__':
    generations = 100000
    F = 0.6
    Cr = 0.6
    pop_size = 20
    dimension = 10
    upper = 10
    lower = -10
    de = DE(generations, F, Cr, pop_size, dimension, lower, upper)
    de.solution()
