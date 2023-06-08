clc
clearvars
close all

N0 = 2; 
SNR = -5:15; 
TRIAL = 110000; 

P = N0*10.^(SNR/10);

BER_s = zeros(1,length(SNR));
BER_a = zeros(1,length(SNR));

K = 6;
K = 10^(K/10); 
A = sqrt(K/(1+K)); 
A = 0; 
sigma_ch = sqrt(1/(2*(1+K))); 

S = (ones(64,1) + 1i*ones(64,1))/sqrt(128); 

for k = 1:length(SNR)
    
    error_sys = 0; 
    error_q = 0;
    
    for m = 1:TRIAL
        b = 2*(rand(1,1)>0.5)-1;
        Tx = sqrt(P(k))*b*S;

        N1= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N2= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N3= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        N4= sqrt(N0/2)*(randn(64,1)+j*randn(64,1));
        

        X1 = sigma_ch*randn(1,1) + A*cos(2*pi/3); 
        Y1 = sigma_ch*randn(1,1) + A*sin(2*pi/3);    
        h1 = X1 + 1i*Y1;

        X2 = sigma_ch*randn(1,1) + A*cos(2*pi/3); 
        Y2 = sigma_ch*randn(1,1) + A*sin(2*pi/3);    
        h2 = X2 + 1i*Y2;

        X3 = sigma_ch*randn(1,1) + A*cos(2*pi/3); 
        Y3 = sigma_ch*randn(1,1) + A*sin(2*pi/3);    
        h3 = X3 + 1i*Y3;

        X4 = sigma_ch*randn(1,1) + A*cos(2*pi/3); 
        Y4 = sigma_ch*randn(1,1) + A*sin(2*pi/3);    
        h4 = X4 + 1i*Y4;

        Rx1= h1*Tx+N1;
        Rx2= h2*Tx+N2;
        Rx3= h1*Tx+N3;
        Rx4= h1*Tx+N4;

        r_mf1=S'*Rx1;
        r_mf2=S'*Rx2;
        r_mf3=S'*Rx3;
        r_mf4=S'*Rx4;

        r_tilda1=(h1'/abs(h1))*r_mf1; 
        r_tilda2=(h2'/abs(h2))*r_mf2; 
        r_tilda3=(h3'/abs(h3))*r_mf3; 
        r_tilda4=(h4'/abs(h3))*r_mf4; 

        r1=real(r_tilda1); 
        r2=real(r_tilda2); 
        r3=real(r_tilda3); 
        r4=real(r_tilda4); 

        r = abs(h1)*r1 + abs(h2)*r2 + abs(h3)*r3 + abs(h4)*r4 ;  
        b_dec=sign(r);

        beta=(abs(h1)^2+abs(h2)^2+abs(h3)^2+abs(h4)^2); 
        error_q=error_q+qfunc(sqrt(beta*2*P(k)/N0));  

        error_sys = error_sys+0.5*abs(b-b_dec);
    end

    BER_s(k) = error_sys/TRIAL;
    BER_a(k) = error_q/TRIAL; 

end

semilogy(SNR, BER_s, SNR, BER_a)
xlabel('SNR (dB)')
ylabel('Bit Error Rate (BER)')
legend('System Simulation','Instantaneous Simulation')





