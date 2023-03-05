function y = OFDMdemod(in,N,cpLen)

rxTimeData = reshape(in, N+cpLen, []);

% Remove cyclic prefix
rxTimeData = rxTimeData(cpLen+1:end,:);

% Perform FFT on each subcarrier
rxModData = fft(rxTimeData, N, 1);

% Reshape into serial stream
y = reshape(rxModData, [], 1);
end