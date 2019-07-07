clear all;
srcPath = "C:\Users\benso\benxin\projects\capstone\dataset\bearing\NASA_bearing_dataset\2nd_test\";
dataPoints = 4;
files = IMSDatasetUtils.iterateFiles(srcPath);

samples = length(importdata(srcPath + files(1)));
first = 1;
last = samples;
fftResult = zeros(length(files)*samples, dataPoints);
for i = 1:1:length(files)
    disp("Processing " + files(i) + "  " + i + " out of " + length(files) + " files");
    snapshot = importdata(srcPath + files(i));
    fftResult(first:last, :) = fft(snapshot);
    first = first + samples;
    last = last + samples;
end
plot(real(fftResult(:, 1)))