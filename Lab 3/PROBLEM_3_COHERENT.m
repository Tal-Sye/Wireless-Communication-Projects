clc
clearvars
close all

N0 = 2; 
SNR = 10:10:100; 
TRIAL = 140000; 

P = N0*10.^(SNR/10);

BER_s = zeros(1,length(SNR));
BER_a = zeros(1,length(SNR));

S = (rand(64,1) + 1i*rand(64,1))/sqrt(128);

for k = 1:length(SNR)
    
    error_sys = 0; 
    error_q = 0; 
    
    for m = 1:TRIAL

        b = 2*(rand(1,1)>0.5)-1;
        Tx = sqrt(P(k))*b*S;
        N = sqrt(N0/2)*(randn(64,1) + 1i*randn(64,1));
        h=(randn(1,1)+1i*randn(1,1))/sqrt(2);
        Rx = h*Tx+N;
        r_mf = S'*Rx;
        r_tilda = (h'/abs(h))*r_mf;
        r = real(r_tilda);
        b_dec = sign(r);
        error_sys = error_sys+0.5*abs(b-b_dec);
        error_q = error_q + qfunc(sqrt((abs(h)^2*2*P(k)/N0)));       
    end

    BER_s(k) = error_sys/TRIAL; 

    Gamma = P(k)/N0;
    BER_a(k) = 0.5*(1-sqrt(Gamma/(1+Gamma)));
    
end

%Plots
semilogy(SNR, BER_s, SNR, BER_a)
legend('Simulated','Analytical')
xlabel('SNR');
ylabel('BER');



