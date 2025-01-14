function artifact_free_data = remove_bad_samples(eeg_data, threshold)
    % Buggy function for identifying and removing artifacts from EEG data
    % Inputs:
    %   eeg_data - Matrix of EEG data (channels x time)
    %   threshold - Amplitude threshold for identifying artifacts
    % Output:
    %   artifact_free_data - EEG data with artifacts removed (zeroed out)

    % Step 1: Identify artifacts
    % Find the channels and time points where artifacts occur
    % Bug 1 and 2. Syntax and Logic Error.
    % Are we using the thresshold the right way?
    [artifact_channels, artifact_timepoints] = find(abs(eeg_data) < threshold;

    % Step 2: Remove artifacts
    artifact_free_data = eeg_data;

    % Zero out only the identified artifact time points
    for i = 1:length(artifact_channels)
        artifact_free_data(artifact_channels(i), artifact_timepoints(i)) = 0;
    end
end
