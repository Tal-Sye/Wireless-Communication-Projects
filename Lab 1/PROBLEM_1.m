clc
clear
clear var

%a

d = rand(10,1);
d = d >= 0.45;
d = (d*2)-1;

%b

temp = rand(10,1)
array_one = temp <= 0.4 & temp >= 0;
array_one = array_one*-1;

array_three = temp <=0.8 & temp >=0.4;
array_three = array_three*1;

e = array_one + array_three

%c

t1 = rand(1,128) + 1i*rand(1,128);
t2 = rand(1,128) + 1i*rand(1,128);
t3 = rand(1,128) + 1i*rand(1,128);
t4 = rand(1,128) + 1i*rand(1,128);

b1 = t1/norm(t1);
b1 = norm(b1);
b_tr1 = t1'/norm(t1);
b_tr1 = norm(b_tr1);

b_tr1'*b1

b2 = t2/norm(t2);
b2 = norm(b2);
b_tr2 = t2'/norm(t2);
b_tr2 = norm(b_tr2);

b_tr2'*b2

b3 = t3/norm(t3);
b3 = norm(b3);
b_tr3 = t3'/norm(t3);
b_tr3 = norm(b_tr3);

b_tr3'*b3

b4 = t4/norm(t4);
b4 = norm(b4);
b_tr4 = t4'/norm(t4);
b_tr4 = norm(b_tr4);

b_tr4'*b4

%d

x1 = rand(128,128) + 1i*rand(128,128);
x1 = x1/norm(x1);
det(norm(x1));

x2 = rand(128,128) + 1i*rand(128,128);
x2 = x2/norm(x2);
det(norm(x2));

det(x1*x2)

%e

x1 = rand(128,128) + 1i*rand(128,128);
x1 = x1/norm(x1);
det(norm(x1));

x2 = rand(128,128) + 1i*rand(128,128);
x2 = x2/norm(x2);
det(norm(x2));

x3 = rand(128,128) + 1i*rand(128,128);
x3 = x3/norm(x3);
det(norm(x3));

x4 = rand(128,128) + 1i*rand(128,128);
x4 = x4/norm(x4);
det(norm(x4));

x5 = rand(128,128) + 1i*rand(128,128);
x5 = x5/norm(x5);
det(norm(x5));

det(x1*x2)
det(x1*x3)
det(x1*x4)
det(x1*x5)

