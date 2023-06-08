clc
clearvars
close all

N0 = 2; 
SNR = 10:10:100; 
TRIAL = 140000; 

P = N0*10.^(SNR/10);

BER_s = zeros(1,length(SNR));
BER_a = zeros(1,length(SNR));

S1 = (rand(64,1) + 1i*rand(64,1))/sqrt(128);
S2 = [rand(32,1) + 1i*rand(32,1); -ones(32,1)-1i*ones(32,1),]/sqrt(128);

for k = 1:length(SNR)
    
    error = 0; 
    
    for m = 1:TRIAL

        b = 2*(rand(1,1)>0.5)-1;

        if (b == 1)
            S = S1; 
        else
            S = S2; 
        end

        Tx = sqrt(P(k))*b*S;
        N = sqrt(N0/2)*(randn(64,1) + 1i*randn(64,1));
        h=(randn(1,1)+1i*randn(1,1))/sqrt(2);
        Rx = h*Tx+N;
        r_mf1 = S1'*Rx;
        r_mf2 = S2'*Rx;

        if (abs(r_mf1) > abs(r_mf2))
            b_dec = +1;
        else
            b_dec = -1;  
        end

        error = error + 0.5*abs(b-b_dec);      
    end

    BER_s(k) = error/TRIAL;
    BER_a(k) = 1/(2 + P(k)/N0);
    
end

%Plots
semilogy(SNR, BER_s, SNR, BER_a)
legend('Simulated','Analytical')
xlabel('SNR');
ylabel('BER');



