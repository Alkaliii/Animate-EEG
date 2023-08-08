%load eeg electrode positions and calculate neighbours
elec       = ft_read_sens('GSN-HydroCel-129.sfp');
 
cfg               = [];
cfg.method        = 'distance';
cfg.neighbourdist = 4;
cfg.feedback      = 'yes';
neighbours        = ft_prepare_neighbours(cfg,elec);

% compute missing channels
missing_channels = setdiff(trial_data.label, preprocessed_data.label);

%repair missing channels using spline interpolation
cfg = [];
cfg.senstype = 'eeg';
cfg.elec = elec;
cfg.method = 'spline';
cfg.missingchannel = missing_channels;
cfg.neighbours = neighbours;
repaired_data = ft_channelrepair(cfg, preprocessed_data);

%view data
cfg = [];  % use only default options
ft_databrowser(cfg, repaired_data);
