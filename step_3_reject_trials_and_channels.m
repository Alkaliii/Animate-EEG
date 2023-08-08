%start out with eliminating bad trials and channels using summary mode
cfg        = [];

cfg.metric = 'zvalue';  % use by default zvalue method
cfg.method = 'summary'; % use by default summary method
preprocessed_data       = ft_rejectvisual(cfg,trial_data); %opens up a view to let you reject stuff


% do a second round of eliminating bad channels/trials using trial mode
cfg        = [];
cfg.method = 'trial'; % use by default summary method
preprocessed_data       = ft_rejectvisual(cfg,preprocessed_data);


%view data
cfg = [];  % use only default options
ft_databrowser(cfg, preprocessed_data);