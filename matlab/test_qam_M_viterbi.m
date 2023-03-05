% test function many_qam and many_qam_virtebi

MaxNumErrs=200;MaxNumBits=1e6;
EbNo_vector=0:10;
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultLineMarkerSize', 12); %set marker size as desired

figure;
M_vec = [4 16 64];
color_vec = ["ro", "-r", "--r*", "go", "-g", "--g*", "bo", "-b", "--b*"];

for index = [1 2 3]
M = M_vec(index);
BER_vector=zeros(size(EbNo_vector));
BER_vector_viterbi=zeros(size(EbNo_vector));

for EbNo = EbNo_vector
% [ber, bits] = chap3_ex02_qpsk(EbNo, MaxNumErrs, MaxNumBits);
[ber, bits] = qam_M(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector(EbNo+1)=ber;
[ber_viterbi, bits_viterbi] = qam_M_viterbi(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_viterbi(EbNo+1)=ber_viterbi;
end

%% Visualize results
EbNoLin = 10.^(EbNo_vector/10);

semilogy(EbNo_vector, BER_vector, color_vec(3*index - 2));
hold on;
grid;
title('BER vs. EbNo - Compare w/wo viterbi');
xlabel('Eb/No (dB)');ylabel('BER');
theorical = 2 / log2(M) * (1 - 1/sqrt(M)) * erfc(sqrt(3*log2(M)/2/(M-1)* EbNoLin)) ;
semilogy(EbNo_vector,theorical, color_vec(3*index - 1));

semilogy(EbNo_vector, BER_vector_viterbi, color_vec(3*index));
end

legend('4 Simulation', ...
    '4 Theory', ...
    '4 Simulation w/ Viterbi',...
    '16 Simulation', ...
    '16 Theory', ...
    '16 Simulation w/ Viterbi',...
    '64 Simulation', ...
    '64 Theoretical', ...
    '64 Simulation w/ Viterbi');

