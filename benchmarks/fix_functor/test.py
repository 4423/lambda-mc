gentime = {}
exetime = {}
memsize = {}

filename = "result.genlet.csv"
with open(filename) as f:
    csv = f.readlines()
    for line in csv[1:]:
        # print(line)
        d = list(map(float, line.split(",")))
        n = d[0]
        if n not in gentime:
            gentime[n] = d[1]
            exetime[n] = d[2]
            memsize[n] = d[3]
        else:
            gentime[n] += d[1]
            exetime[n] += d[2]
            memsize[n] += d[3]
    
N = len(gentime)
for i in range(N):
    gentime[i] /= 10
    exetime[i] /= 10
    memsize[i] /= 10

with open(filename+".csv", mode='w') as f:
    for i in range(N):
        f.write("{0}\t{1:.6}\t{2:.6}\t{3:.6f}\n".format(i, gentime[i], exetime[i], memsize[i]))
        # f.write("{0}\t{1:.6}\t{2:.6f}\n".format(i, gentime[i], exetime[i]))