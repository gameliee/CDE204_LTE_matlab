% test function many_qam and many_qam_virtebi

MaxNumErrs=200;MaxNumBits=1e7;
EbNo_vector=0:10;
set(0, 'DefaultLineLineWidth', 2);
set(0, 'DefaultLineMarkerSize', 12); %set marker size as desired

figure;
M_vec = [4 16 64];
color_vec_turbo = ["--r*", "--g*", "--b*"];
color_vec_turbo_ofdm = ["--rs", "--gs", "--bs"];

for index = [1 2 3]
M = M_vec(index);

BER_vector_turbo=zeros(size(EbNo_vector));
BER_vector_turbo_ofdm=zeros(size(EbNo_vector));

for EbNo = EbNo_vector
[ber_turbo, bits_turbo] = qam_M_turbo(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_turbo(EbNo+1)=ber_turbo;

[ber_turbo_ofdm, bits_turbo_ofdm] = qam_M_turbo_OFDM(EbNo, MaxNumErrs, MaxNumBits, M);
BER_vector_turbo_ofdm(EbNo+1)=ber_turbo_ofdm;
end

%% Visualize results
semilogy(EbNo_vector, BER_vector_turbo, color_vec_turbo(index), ...
    'DisplayName',M + " QAM ");
hold on;
grid;
title('BER vs. EbNo - Compare w/wo OFDM, using Turbo code');
xlabel('Eb/No (dB)');ylabel('BER');
semilogy(EbNo_vector, BER_vector_turbo_ofdm, color_vec_turbo_ofdm(index), ...
    'DisplayName',M + " QAM OFDM");
end

legend show;

