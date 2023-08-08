clear;

%source eeg folder
dataset_path = 'data\P300_0001_20230126_110446.mff';

%load data
cfg                    = [];
cfg.dataset            = dataset_path;
data                   = ft_preprocessing(cfg); % read raw data

%filter entire dataset
cfg                = [];
cfg.hpfilter       = 'yes';        % enable high-pass filtering
cfg.lpfilter       = 'yes';        % enable low-pass filtering
cfg.hpfreq         = 1;           % set up the frequency for high-pass filter
cfg.lpfreq         = 30;          % set up the frequency for low-pass filter
cfg.hpfiltord      = 4;

%This is commented out since the lowpass filter is at 30hz
%cfg.dftfilter      = 'yes';        % enable notch filtering to eliminate power line noise
%cfg.dftfreq        = [50, 60, 100, 120, 150, 180]; % set up the frequencies for notch filtering

filt_data               = ft_preprocessing(cfg,data);

%view data
cfg = [];  % use only default options
ft_databrowser(cfg, filt_data);


%Output seems really flat...