% Beginner Debugging Solution

% Step 1: Load EEG Data
load('dummy_eeg_data.mat');

% Step 2: Display Metadata
disp(data.patient_ID);  % Corrected field name

% Step 3: Compute Mean Amplitude for Each Channel
mean_amplitude = mean(data.EEG, 2);  % Output wont be displayed

% Step 4: Exclude Bad Channels
cleaned_data = data.EEG(setdiff(1:size(data.EEG, 1), data.bad_channels), :);

% Step 5: Create Bandpass Filter
[b, a] = butter(2, [1 40] / (data.sampling_rate / 2));  % Nyquist normalization

%Step 6: Apply filter
filtered_data = filter(b, a, cleaned_data, [], 2);  % Correct axis for filtering

% Step 7: Plot Filtered EEG channel = 1
figure;
plot(filtered_data(1, :));  % Corrected plot for the first cleaned channel
title('Filtered EEG Signal (Cleaned)');
xlabel('Time (ms)');
ylabel('Amplitude');

%% Step 8: Solution's Filtered Data CH1 fft

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