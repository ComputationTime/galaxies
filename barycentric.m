function fto = barycentric(xfr, ffr, xto)
fto=zeros(1,length(xto));
for i =1:length(xto)
    fto(i)=p(xto(i),xfr,ffr);
end
end


function r = p(x, xfr, ffr)
top=0;
bottom=0;
for j=1:length(xfr)
    w=1;
    for k=1:length(xfr)
        if (k==j) 
            continue
        end
        w=w*(xfr(j)-xfr(k));
    end
    w=1/w;
    temp=w/(x-xfr(j));
    top=top+temp*ffr(j);
    bottom=bottom+temp;
end
r=top/bottom;
end