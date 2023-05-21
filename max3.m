function val = max3(a, b, c)
    if(a>b)
        if(a>c)
            val = a;
            return;
        end
        val = c;
        return;
    end
    if(b>c)
        val = b;
        return;
    end
    val = c;
    return;
    