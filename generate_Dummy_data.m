
% Generate Dummy EEG Data with Structured Fields
% This script creates a simulated EEG dataset and saves it as a .mat file.

% Metadata
data.patient_ID = "P30";                     % Patient ID
data.sampling_rate = 1000;                   % Sampling rate in Hz
data.duration_sec = 10;                      % Duration in seconds
data.bad_channels = [5, 12, 20];             % Example bad channels
data.channel_labels = arrayfun(@(x) sprintf('Ch%d', x), 1:64, 'UniformOutput', false);

% Simulated EEG data: 64 channels, 1000 Hz sampling rate, 10 seconds
num_channels = 64;
num_samples = data.sampling_rate * data.duration_sec;
data.EEG = randn(num_channels, num_samples); % Randomly generated signals

data.EEG()

% Save to .mat file
save('dummy_eeg_data.mat', 'data');
disp('Dummy EEG data saved as dummy_eeg_data.mat');
