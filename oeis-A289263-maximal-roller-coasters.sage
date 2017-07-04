def is_roller_coaster(P, S):
    if len(S) <= 1:
        return False
    h = 0
    for s,t in zip(S[:-1], S[1:]):
        p = P[s]
        q = P[t]
        o = 1 if p < q else -1
        if (h == 1 and o == -1) or (h == -1 and o == 1):
            return False
        if (h >= 1 and o == -1) or (h <= -1 and o == 1):
            h = o
        else:
            h += o
    if h == -1 or h == 1:
        return False
    return True

def max_roller_coasters(P):
    result = set()
    todo_soon = set([tuple(srange(len(P)))])
    not_todo_soon = set()
    
    def do(S):
        #print tuple(P[s] for s in S)
        if is_roller_coaster(P, S):
            result.add(tuple(P[s] for s in S))
            not_todo_soon.update(tuple(T) for T in subsets(S))
            return
        
        for i, _ in enumerate(S):
            todo_soon.add(S[:i] + S[i+1:])

    while todo_soon:
        todo = todo_soon.difference(not_todo_soon)
        #print todo, todo_soon, not_todo_soon
        todo_soon = set()
        #not_todo_soon = set()
        for S in todo:
            do(S)

    return list(sorted(result))


print(', '.join(str(sum(len(max_roller_coasters(P)) for P in Permutations(n))) for n in srange(3, 9)))
