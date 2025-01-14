% Beginner Debugging Tutorial

% Task: Fix this script's bugs. The final figure in Step 8 should match 
% the solution's output.
% Objective: Solving syntax, runtime errors, 3 logic errors.

% Hint: Start by fixing all syntax errors. Then debug step by step 
% using "Step" in the MATLAB Editor. Add breakpoints to investigate variables
% and skip parts you have already fixed.

% Step 1: Load EEG Data
% Bug 1: Syntax Error 
% Hint: read the error in the command window, or hover the code analyzer 
% indicators in the right margin.
load('dummy_eeg_data.mat'

% Use `whos` or the Workspace to inspect the loaded variables. (E.g >> whos data)
% Alternatevely inspect the Workspace variables (E.g. double click on data)

% Step 2: Display Metadata
% Bug 2: Runtime Error - Incorrect function name
% Function "dips" does not exist. Search "display function for matlab" on Google
dips(data.patient_ID);  

% Step 3: Compute Mean Amplitude for Each Channel
% Bug 3? Not really, but poor practice. Warning on right margin
% Do you want to display mean_amplitude in the command window?
mean_amplitude = mean(data.EEG, 1)

% Step 4: Exclude Bad Channels
% Bug 4: Runtime Error - Misspelled field name
% You don't know what is setdiff? search "setdiff MATLAB" on google
% Alternative: copy the line below on chatgpt for a quick explanation
cleaned_data = data.EEG(setdiff(1:size(data.EEG, 1), data.bad_chanels), :);

% Step 5: Create Bandpass Filter
% Bug 5: Logic Error - Incorrect normalization for Nyquist frequency
% Use MATLAB documentation to correct the filter design (search "butter matlab")
% The following line is a bandpass from 1 - 40 Hz, what is the right normalization?
[b, a] = butter(2, [1 40] / data.sampling_rate);

% Tip: Visualize the filter's magnitude response.
% Copy the following line into the Command Window:
% freqz(b, a, [], data.sampling_rate);
% Is the drop-off in the expected frequency range?

% Step 6: Apply filter
% Bug 6: Incorrect axis for filtering
% Hint: Should the filter be applied across channels or time?
% Hint2: cleaned data matrix is defined as: channels(row) x time(columns)
filtered_data = filter(b, a, cleaned_data, [], 1);

% Step 7: Plot Filtered EEG for Channel 1
% Bug 7: Logic Error - Incorrectly plotting all data instead of a single channel
% Hint: Extract channel 1 from the matrix to fix this bug.
figure;
plot(filtered_data);  % Bug here
title('Filtered EEG Signal');
xlabel('Time (ms)');
ylabel('Amplitude');

%% Step 8: Tutorial's Filtered Data CH1 fft

channel_to_analyze = 1;  % Analyze the first channel

% FFT of filtered data
fft_filtered = abs(fft(filtered_data(channel_to_analyze, :)));
frequencies = linspace(0, data.sampling_rate, length(fft_filtered));

% Plot the results in subplots
figure;
plot(frequencies(1:end/2), fft_filtered(1:end/2));  % Plot up to Nyquist frequency
title('Fourier Transform of Filtered EEG Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
