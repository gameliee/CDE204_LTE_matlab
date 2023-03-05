% test function many_qam and many_qam_virtebi

MaxNumErrs=200;MaxNumBits=1e8;
EbNo_vector=0:15;
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultLineMarkerSize', 12); %set marker size as desired

figure;
M_vec = [4 16 64];
color_vec_viterbi = [":ro", ":go", ":bo"];
color_vec_viterbi_soft = ["-rd", "-gd", "-bd"];
color_vec_turbo = ["--r*", "--g*", "--b*"];

for index = [1 2 3]
M = M_vec(index);

BER_vector_viterbi=zeros(size(EbNo_vector));
BER_vector_viterbi_soft=zeros(size(EbNo_vector));
BER_vector_turbo=zeros(size(EbNo_vector));

for EbNo = EbNo_vector
[ber_viterbi, bits_viterbi] = qam_M_viterbi(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_viterbi(EbNo+1)=ber_viterbi;

[ber_viterbi_soft, bits_viterbi_soft] = qam_M_viterbi_soft(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_viterbi_soft(EbNo+1)=ber_viterbi_soft;

[ber_turbo, bits_turbo] = qam_M_turbo(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_turbo(EbNo+1)=ber_turbo;
end

%% Visualize results
semilogy(EbNo_vector, BER_vector_viterbi, color_vec_viterbi(index),...
    'DisplayName',M + " QAM Viterbi hard");
hold on;
grid;
title('BER vs. EbNo - Compare w/wo viterbi, Turbo');
xlabel('Eb/No (dB)');ylabel('BER');

semilogy(EbNo_vector, BER_vector_viterbi_soft, color_vec_viterbi_soft(index), ...
    'DisplayName',M + " QAM Viterbi soft");
semilogy(EbNo_vector, BER_vector_turbo, color_vec_turbo(index), ...
    'DisplayName',M + " QAM Turbo");
end

legend show;

