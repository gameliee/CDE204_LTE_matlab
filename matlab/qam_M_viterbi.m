function [ber, bits]=qam_M_viterbi(EbNo, maxNumErrs, maxNumBits, M)
%% Initializations
persistent Modulator AWGN DeModulator BitError ConvEncoder Viterbi

Modulator = comm.RectangularQAMModulator(M, 'BitInput',true);
Modulator.NormalizationMethod = 'Average power';
AWGN = comm.AWGNChannel;
DeModulator = comm.RectangularQAMDemodulator(M, 'BitOutput',true);
DeModulator.NormalizationMethod = 'Average power';
BitError = comm.ErrorRate;
ConvEncoder=comm.ConvolutionalEncoder('TerminationMethod','Terminated');
Viterbi=comm.ViterbiDecoder('InputFormat','Hard','TerminationMethod','Terminated');

%% Constants
FRM=2052;
k=log2(M); codeRate=1/2;
snr = EbNo + 10*log10(k) + 10*log10(codeRate);
AWGN.EbNo=snr;
%% Processsing loop modeling transmitter, channel model and receiver
numErrs = 0; numBits = 0;results=zeros(3,1);
while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
% Transmitter
u = randi([0 1], FRM,1); % Random bits generator
encoded = ConvEncoder.step(u); % Convolutional encoder
mod_sig = Modulator.step(encoded); % QPSK Modulator
% Channel
rx_sig = AWGN.step(mod_sig); % AWGN channel
% Receiver
demod = DeModulator.step(rx_sig); % QPSK Demodulator
decoded = Viterbi.step(demod); % Viterbi decoder
y = decoded(1:FRM); % Compute output bits
results = BitError.step(u, y); % Update BER
numErrs = results(2);
numBits = results(3);
end
%% Clean up & collect results
ber = results(1); bits= results(3);
reset(BitError);