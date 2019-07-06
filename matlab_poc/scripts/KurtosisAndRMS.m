
% Replace datasets to path... a total of 6 files will be generated
IMS_dataset_path = "dataset\bearing\NASA_bearing_dataset\";

%change this if you do not wish to regenerate data
%it generally takes 40 minutes to compute kurtosis and rms
regenerateData = 0;

if(regenerateData == 0)
    datasetOne = IMS_dataset_path + "1st_test\";
    datasetTwo = IMS_dataset_path +"2nd_test\";
    datasetThree = IMS_dataset_path +"3rd_test\";

    calculateKurtosisAndRms(datasetOne, '1st_dataset_kurtosis.csv', '1st_dataset_rms.csv', 8);
    calculateKurtosisAndRms(datasetTwo, '2nd_dataset_kurtosis.csv', '2nd_dataset_rms.csv', 4);
    calculateKurtosisAndRms(datasetThree, '3rd_dataset_kurtosis.csv', '3rd_dataset_rms.csv', 4);
end

generatePlots();

function files=iterateFiles(srcPath)
fileRegex = "(?<year>\d+).(?<month>\d+).(?<day>\d+).(?<hour>\d+).(?<minutes>\d+).(?<second>\d+)";
files = dir(srcPath);
files = regexpi({files.name},fileRegex,'match');
files = [files{:}];
end

%compute kurtosis and rms for each file and dump them into a csv file
function calculateKurtosisAndRms(srcPath, kurtosisOutput, rmsOutput, dataPoints)
disp("Processing files in "+ srcPath);
files = iterateFiles(srcPath);
kurtosisResult = zeros(length(files), dataPoints);
rootMeanSquareResult = zeros(length(files), dataPoints);
for i = 1:1:length(files)
    disp("Processing " + files(i) + "  " + i + " out of " + length(files) + " files");
    snapshot = importdata(srcPath + files(i));
    kurtosisResult(i,:) = kurtosis(snapshot);
    rootMeanSquareResult(i, :) = rms(snapshot);
end
dlmwrite(kurtosisOutput, kurtosisResult, '\t')
dlmwrite(rmsOutput, rootMeanSquareResult, '\t')
end

%generate plots from computed data
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

