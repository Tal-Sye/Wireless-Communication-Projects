clc
clear
clear var

v = 64.37*1000/3600;
pt = 30;
fc = 1.4e9;
lambda = 3e8/fc;
d = 1000:5000;
d_0 = 2
pathloss = 4
t = (d-3000)./v;
pr_f = 10*log10(pt*1*8*lambda^2./((4*pi)^2*(d.^2)));
figure
loglog(d,pr_f)
xlabel('distance')
grid on
hold on


%2(b)
figure
loglog(t,pr_f)
xlabel('time')
grid on

