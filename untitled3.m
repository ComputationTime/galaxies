clf;

x = linspace(-0.9,0.9,101);
fxct = tpoly(x);
plot(x,fxct);
hold on;

xfr = linspace(-1,1,8);
ffr = tpoly(xfr);

xto = linspace(-0.9,0.9,101);
fto = barycentric(xfr,ffr,xto);

df = fxct - fto

plot(x,1.0e15 .* df);

title('Barycentric polynomial interpolation');
xlabel('x');
legend('Exact values', '10^{15} * Error in interpolated values');