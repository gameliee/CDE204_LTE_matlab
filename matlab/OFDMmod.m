function y = OFDMmod(in,N,cpLen)
% Reshape data into subcarriers
in = reshape(in, N, []);

% Perform IFFT on each subcarrier
timeData = ifft(in, N, 1);

% Add cyclic prefix
timeData = [timeData((N-cpLen+1):N,:); timeData];

% Convert to serial stream
y = timeData(:);
end