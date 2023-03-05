function [ber, bits]=qam_M(EbNo, maxNumErrs, maxNumBits, M)
%% Initializations
persistent Modulator AWGN DeModulator BitError

Modulator = comm.RectangularQAMModulator(M, 'BitInput',true);
Modulator.NormalizationMethod = 'Average power';
AWGN = comm.AWGNChannel;
DeModulator = comm.RectangularQAMDemodulator(M, 'BitOutput',true);
DeModulator.NormalizationMethod = 'Average power';
BitError = comm.ErrorRate;

%% Constants
FRM=2052;
k=log2(M);
snr = EbNo + 10*log10(k);
AWGN.EbNo=snr;
%% Processsing loop modeling transmitter, channel model and receiver
numErrs = 0; numBits = 0;results=zeros(3,1);
while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
% Transmitter
u = randi([0 1], FRM,1); % Random bits generator
mod_sig = Modulator.step(u); % QPSK Modulator
% Channel
rx_sig = AWGN.step(mod_sig); % AWGN channel
% Receiver
demod = DeModulator.step(rx_sig); % QPSK Demodulator
y = demod(1:FRM); % Compute output bits
results = BitError.step(u, y); % Update BER
numErrs = results(2);
numBits = results(3);
end
%% Clean up & collect results
ber = results(1); bits= results(3);
reset(BitError);
