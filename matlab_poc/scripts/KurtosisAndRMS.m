
% Replace datasets to path... a total of 6 files will be generated
IMS_dataset_path = "C:\Users\benso\benxin\projects\capstone\dataset\bearing\NASA_bearing_dataset";

% Change this if wish to regenerate data
if(2 == 1)
    IMSDatasetUtils.computeKurtosisAndRms(IMS_dataset_path + "\1st_test\", "1st_dataset", 8);
    IMSDatasetUtils.computeKurtosisAndRms(IMS_dataset_path + "\2nd_test\", "2nd_dataset", 4);
    IMSDatasetUtils.computeKurtosisAndRms(IMS_dataset_path + "\3rd_test\", "3rd_dataset", 4);
end

plotKurtosisAndRMS();

%generate plots from computed data
function plotKurtosisAndRMS()
% Sub-titles for dataset one plots
titles1 = [ "bearing 1 channel 1" "bearing 1 channel 2" "bearing 2 channel 1" "bearing 2 channel 2" "bearing 3 channel 1" "bearing 3 channel 2" "bearing 4 channel 1" "bearing 4 channel 2" ];
% Sub-titles for dataset two and three plots
titles2 = ["bearing 1" "bearing 2" "bearing 3" "bearing 4"];

% Plot for dataset 1 
IMSDatasetUtils.plotData("1st_dataset_kurtosis.csv", titles1, '1st test dataset Run to Failure (Kurtosis)', [8 4 2], "n", "Kurtosis", 1)
IMSDatasetUtils.plotData("1st_dataset_rms.csv", titles1, '1st test dataset Run to Failure (RMS)', [8 4 2], "n", "RMS", 2)

% Plot for dataset 2
IMSDatasetUtils.plotData("2nd_dataset_kurtosis.csv", titles2, '2nd test dataset Run to Failure (Kurtosis)', [4 4 1], "", "Kurtosis", 3)
IMSDatasetUtils.plotData("2nd_dataset_rms.csv", titles2, '2nd test dataset Run to Failure (RMS)', [4 4 1], "n", "RMS", 4)

% Plot for dataset 3
IMSDatasetUtils.plotData("3rd_dataset_kurtosis.csv", titles2, '3rd test dataset Run to Failure (Kurtosis)', [4 4 1], "n", "Kurtosis", 5)
IMSDatasetUtils.plotData("3rd_dataset_rms.csv", titles2, '3rd test dataset Run to Failure (RMS)', [4 4 1], "n", "RMS", 6)
end
