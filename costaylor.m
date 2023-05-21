function r = costaylor(x, tol, kmax)
    r=0;
    for k=0:kmax
        term = ((-1)^k)*(x^(2*k))/factorial(2*k);
        r = r+ term;
        if abs(term)<tol
            return
        end
    end