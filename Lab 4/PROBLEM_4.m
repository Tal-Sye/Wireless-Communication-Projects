clc
clearvars
clear
close all

N0 = 2; 
SNR = 10;
TRIAL = 140000; 
P = N0*10^(SNR/10);

RiceanFactor = -10:2:10;
K = 10.^(RiceanFactor/10); 
A = sqrt(K/(1+K)); 
sigma_ch = sqrt(1./(2*(1+K)));

BER_s = zeros(1,length(K));
BER_ins = zeros(1,length(K));
BER_a = zeros(1,length(K));

S = (ones(64,1) + 1i*ones(64,1))/sqrt(128);

for k = 1:length(K)
    error_sys = 0;
    error_q = 0; 

    for m = 1:TRIAL
        b = 2*(rand(1,1)>0.5)-1;
        Tx = sqrt(P)*b*S;
        N = sqrt(N0/2)*(randn(64,1) + 1i*randn(64,1));

        X = sigma_ch(k)*randn(1,1) + A*cos(2*pi/3); 
        Y = sigma_ch(k)*randn(1,1) + A*sin(2*pi/3);
        h = X + 1i*Y;

        Rx = h*Tx+N;
        r_mf = S'*Rx;
        r_tilda = (h'/abs(h))*r_mf;
        r = real(r_tilda);
        b_dec = sign(r);

        error_sys = error_sys+0.5*abs(b-b_dec); 
        error_q = error_q + qfunc(sqrt((abs(h)^2*2*P/N0)));
    end

    BER_s(k) = error_sys/TRIAL; 
    BER_ins(k) = error_q/TRIAL;

end

semilogy(RiceanFactor, BER_s, RiceanFactor, BER_ins)
legend('Simulated','Instantaneous')
xlabel('Ricean Factor');
ylabel('BER');