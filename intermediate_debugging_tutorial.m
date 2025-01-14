% Intermediate Debugging Tutorial

% Task: Debug this script and fix all errors to produce correct artifact-free, 
% epoched EEG data and visualize the PSD of the first epoch and channel.
% Goal: Solving more complex errors and stepping into buggy functions.

% The final plot in Step 7 should match the solution.

clear; clc;

% Step 1: Load EEG Data
% Bug 1: Syntax and Runtime Error
% Hint: Look for syntax indicators on the right margin. Google the erros.
load 'dummy_eeg_dataset.mat";

% Step 2: Simulate Artifacts
% Simulate high-amplitude artifacts in the EEG data for debugging.
data.EEG(1, 100:110) = 500;  % Simulate spike artifact in channel 1
data.EEG(3, 2000:2010) = -600;  % Simulate negative spike in channel 3

% Step 3: Remove Artifacts and make the zero
% Define artifact threshold
artifact_threshold = 100;  % Amplitude threshold (in microvolts)
% Bug 2: remove_bad_samples has bugs. You need to reach the following line
% of code, and "Step In" to "remove_bad_samples"
% This will open the .m file with a new temporal Workspace
artifact_free_data = remove_bad_samples(data.EEG, artifact_threshold);

% Step 3.2: Are you sure the artifacs have been removed?
% Why not plot all channels? Use the following block in the command window
% figure;
% subplot(121); plot(data.EEG); title('raw data'); hold on;
% subplot(122); plot(artifact_free_data); title('artifact free data');

% Step 4: Epoch the Data
% Create a 3D Matrix as follows: 
% channels (64), epoch_samples (2 seconds), # of ephocs
% Google "reshape Matlab"

% Define epoch parameters
epoch_length = 2;  % Epoch length in seconds
sampling_rate = data.sampling_rate;
epoch_samples = epoch_length * sampling_rate;
num_epochs = floor(size(artifact_free_data, 2) / epoch_samples);

% Bug 3: Logic Error - Incorrect input and reshape dimensions
% Hint: which variable do we want to ephoch?
% Hint2: are the reshape dimensions in the right order? 
epoched_data = reshape(data.EEG, size(artifact_free_data, 1), num_epochs, epoch_samples);  % Incorrect reshape dimensions

% Step 5: Frequency Analysis
% Compute PSD for the first epoch and first channel
% Bug 4: We are extracting first channel, but not first epoch
% Hint: shape(ephoch_data) = channels x ephoch_samples x epoch
[psd, freqs] = pwelch(epoched_data(1, :, :), [], [], [], sampling_rate);

% Step 6: Save Results
% Bug 6: Runtime Error - Invalid directory
% Hint: Use "fullfile MATLAB" to construct valid file paths.
save('results_folder/epoched_data.mat', 'epoched_data', 'psd');  % Invalid path

% Final Step: Visualize Results
% Generate a PSD plot for the first epoch and first channel
figure;
plot(freqs, 10 * log10(psd(1, :)));  % Plot PSD in dB
tittle('Power Spectral Density (First Epoch, First Channel)');
xlabel('Frequency (Hz)');
ylabel('Power (dB)');
grid on;

