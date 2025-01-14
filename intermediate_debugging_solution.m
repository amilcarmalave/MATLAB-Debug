% Correct Solution for Intermediate Debugging Tutorial

clear; clc;

% Step 1: Load EEG Data
load('dummy_eeg_data.mat');

% Step 2: Simulate Artifacts
% Simulate high-amplitude artifacts in the EEG data for debugging
data.EEG(1, 100:110) = 500;  % Simulated spike artifact in channel 1
data.EEG(3, 2000:2010) = -600;  % Simulated negative spike in channel 3

% Step 3: Remove Artifacts
artifact_threshold = 100;  % Threshold in microvolts
artifact_free_data = remove_bad_samples_solution(data.EEG, artifact_threshold);

% Step 4: Epoch the Data
% Define epoch parameters
epoch_length = 2;  % Epoch length in seconds
sampling_rate = data.sampling_rate;

epoch_samples = epoch_length * sampling_rate;
num_epochs = floor(size(artifact_free_data, 2) / epoch_samples);

% Reshape data into epochs
epoched_data = reshape(artifact_free_data, size(artifact_free_data, 1), epoch_samples, num_epochs);

% Step 5: Frequency Analysis
% Compute PSD for the first epoch and first channel
[psd, freqs] = pwelch(epoched_data(1, :, 1), [], [], [], sampling_rate);

% Step 6: Save Results
output_dir = fullfile(pwd, 'results_folder');
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end
save(fullfile(output_dir, 'epoched_data.mat'), 'epoched_data', 'psd', 'freqs');

% Final Step: Visualize Results
figure;
plot(freqs, 10 * log10(psd));  % PSD in dB
title('Power Spectral Density (First Epoch, First Channel)');
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
grid on;

disp('Intermediate debugging tutorial completed successfully.');

