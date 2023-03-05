% test function many_qam

MaxNumErrs=200;MaxNumBits=1e6;
EbNo_vector=0:10;

figure;
M_vec = [4 16 64];
color_vec = ["-ro", "--r*", "-go", "--g*", "-bo", "--b*"];

for index = [1 2 3]
M = M_vec(index);
BER_vector=zeros(size(EbNo_vector));

for EbNo = EbNo_vector
[ber, bits] = qam_M(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector(EbNo+1)=ber;
end

%% Visualize results
EbNoLin = 10.^(EbNo_vector/10);

semilogy(EbNo_vector, BER_vector, color_vec(2*index - 1));
hold on;
grid;
title('BER vs. EbNo - Compare different QAM modulation');
xlabel('Eb/No (dB)');ylabel('BER');

theorical = 2 / log2(M) * (1 - 1/sqrt(M)) * erfc(sqrt(3*log2(M)/2/(M-1)* EbNoLin)) ;
semilogy(EbNo_vector,theorical, color_vec(2*index));
end

legend('4 Simulation', '4 Theory', '16 Simulation', '16 Theory', '64 Simulation','4 Theoretical');

