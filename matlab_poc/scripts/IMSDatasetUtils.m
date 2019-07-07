classdef IMSDatasetUtils
  
    methods(Static)
        
        function computeFft(srcPath, outputPrefix, dataPoints)
            IMSDatasetUtils.compute(srcPath, outputPrefix, dataPoints, 0, 0, 1)
        end
        
        function computeKurtosis(srcPath, outputPrefix, dataPoints)
            IMSDatasetUtils.compute(srcPath, outputPrefix, dataPoints, 1, 0, 0)
        end
        
        function computeRms(srcPath, outputPrefix, dataPoints)
            IMSDatasetUtils.compute(srcPath, outputPrefix, dataPoints, 0, 1, 0)
        end
        
        function computeKurtosisAndRms(srcPath, outputPrefix, dataPoints)
            IMSDatasetUtils.compute(srcPath, outputPrefix, dataPoints, 1, 1, 0)
        end
        
        % iterate a directory and filter out bad files using Regex
        function files=iterateFiles(srcPath)
            fileRegex = "(?<year>\d+).(?<month>\d+).(?<day>\d+).(?<hour>\d+).(?<minutes>\d+).(?<second>\d+)";
            files = dir(srcPath);
            files = regexpi({files.name},fileRegex,'match');
            files = [files{:}];
        end
        
        %compute kurtosis and rms for each file and dump them into a csv file
        function compute(srcPath, outputPrefix, dataPoints, runKurtosis, runRms, runFft)
            disp("Processing files in "+ srcPath);
            files = IMSDatasetUtils.iterateFiles(srcPath);
            kurtosisResult = zeros(length(files), dataPoints);
            rootMeanSquareResult = zeros(length(files), dataPoints);
            for i = 1:1:length(files)
                disp("Processing " + files(i) + "  " + i + " out of " + length(files) + " files");
                snapshot = importdata(srcPath + files(i));
                if (runKurtosis == 1) kurtosisResult(i,:) = kurtosis(snapshot); end
                if (runRms == 1) rootMeanSquareResult(i, :) = rms(snapshot); end
            end
            if (runKurtosis == 1) dlmwrite(outputPrefix+"_kurtosis.csv", kurtosisResult, '\t'); end
            if (runRms == 1) dlmwrite(outputPrefix+"_rms.csv", rootMeanSquareResult, '\t'); end
        end
        
        function plotData(srcPath, subTitles, superTitle, dimension, xLabel, yLabel, index)
            data = importdata(srcPath);
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

    end
end