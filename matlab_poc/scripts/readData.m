function generatePlots()
kurtoOne = importdata("1st_dataset_kurtosis.csv");
kurtoTwo = importdata("2nd_dataset_kurtosis.csv");
kurtoThree = importdata("3rd_dataset_kurtosis.csv");

rmsOne = importdata("1st_dataset_rms.csv");
rmsTwo = importdata("2nd_dataset_rms.csv");
rmsThree = importdata("3rd_dataset_rms.csv");

titles1 = [
    "bearing 1 channel 1" "bearing 1 channel 2"
    "bearing 2 channel 1" "bearing 2 channel 2"
    "bearing 3 channel 1" "bearing 3 channel 2"
    "bearing 4 channel 1" "bearing 4 channel 2"];
titles2 = ["bearing 1" "bearing 2" "bearing 3" "bearing 4"];

superTitle='1st test dataset Run to Failure (Kurtosis)';
plotData(kurtoOne, titles1, superTitle, [8 4 2], "", "Kurtosis", 1)
superTitle='1st test dataset Run to Failure (RMS)';
plotData(rmsOne, titles1, superTitle, [8 4 2], "", "RMS", 2)

superTitle='2nd test dataset Run to Failure (Kurtosis)';
plotData(kurtoTwo, titles2, superTitle, [4 4 1], "", "Kurtosis", 3)
superTitle='2nd test dataset Run to Failure (RMS)';
plotData(rmsTwo, titles2, superTitle, [4 4 1], "", "RMS", 4)

superTitle='3nd test dataset Run to Failure (Kurtosis)';
plotData(kurtoThree, titles2, superTitle, [4 4 1], "", "Kurtosis", 5)
superTitle='3nd test dataset Run to Failure (RMS)';
plotData(rmsThree, titles2, superTitle, [4 4 1], "", "RMS", 6)
end

function plotData(data, subTitles, superTitle, dimension, xLabel,yLabel,index)
figure(index)
for i=1:1:dimension(1)
    subplot(dimension(2),dimension(3),i)
    stem(1:1:length(data), data(:,i))
    title(subTitles(i))
    xlabel(xLabel)
    ylabel(yLabel)
end
suptitle(superTitle)

end

