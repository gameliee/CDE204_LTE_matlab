% test function many_qam and many_qam_virtebi

MaxNumErrs=200;MaxNumBits=1e6;
EbNo_vector=0:10;
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultLineMarkerSize', 12); %set marker size as desired


figure;
M_vec = [4 16 64];
color_vec = [":ro", "-rd", "--r*", ":go", "-gd", "--g*", ":bo", "-bd", "--b*"];

for index = [1 2 3]
M = M_vec(index);
BER_vector=zeros(size(EbNo_vector));
BER_vector_viterbi=zeros(size(EbNo_vector));
BER_vector_viterbi_soft=zeros(size(EbNo_vector));

for EbNo = EbNo_vector
% [ber, bits] = chap3_ex02_qpsk(EbNo, MaxNumErrs, MaxNumBits);
[ber, bits] = qam_M(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector(EbNo+1)=ber;
[ber_viterbi, bits_viterbi] = qam_M_viterbi(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_viterbi(EbNo+1)=ber_viterbi;

[ber_viterbi_soft, bits_viterbi_soft] = qam_M_viterbi_soft(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_viterbi_soft(EbNo+1)=ber_viterbi_soft;
end

%% Visualize results
semilogy(EbNo_vector, BER_vector, color_vec(3*index - 2), ...
    'DisplayName',M + " QAM without coding");
hold on;
grid;
title('BER vs. EbNo - Compare viterbi soft/hard');
xlabel('Eb/No (dB)');ylabel('BER');

semilogy(EbNo_vector, BER_vector_viterbi, color_vec(3*index - 1), ...
    'DisplayName',M + " QAM w/ Viterbi hard");
semilogy(EbNo_vector, BER_vector_viterbi_soft, color_vec(3*index), ...
    'DisplayName',M + " QAM w/ Viterbi soft");
end

legend show;

