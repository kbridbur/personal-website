%InputList = [];
%WindowSize = 3;
%ReductionLayers = 1;
%SamplingHz = 110;

%adds timestamps to the inputs given based on sampling frequency
function TimeStampedCoords = GetTimeStamps(SamplingFrequency, InputList)
  LengthInputs = length(InputList);
  TimeStampedCoords = []; %List of timestamped inputs to be returned
  for input = 0:LengthInputs %Cycle through all the inputs and add them, with their timestamps, to the new list
    TimeStamp = input/SamplingFrequency;
    TimestampedInputs = [TimestampedInputs [TimeStamp InputList(1, input)]]; % May need to change based on how to data is being input
  end
end
  
function NoiseReducedCoords = NoiseReduction(ReductionLayers, WindowSize, InputList)
  ToBeAveraged = [];
  LengthInputs = length(InputList);
  NoiseReducedCoords = InputList
  for ReductionWave = 1:ReductionLayers
    LayerReducedCoords = []; %unsure if needed, mutating NoiseReducedCoords while iterating over it would be bad though
    for input = 0:LengthInputs
      ToBeAveraged = [ToBeAveraged NoiseReducedCoords(1,input)]; %taking from noisereducedcoords allows for multiple layers of reduction
      if length(ToBeAveraged) >= WindowSize
        %remove the first value in the list
      end
      %do some averaging thing and set LayerReducedCoords to have that value
    end
    NoiseReducedCoords = LayerReducedCoords;
  end
end  
  
function Peaks = FindPeaks(PeakCutoff, InputList)
  LengthInputs = length(InputList);
  StandardDev = std(InputList);
  Average = mean(InputList);
  Peaks = [];
  for input = 0:LengthInputs
    if InputList(1, input) >= (PeakCutoff*StandardDev + Average)
      Peaks = [Peaks input];
    end
  end
end

