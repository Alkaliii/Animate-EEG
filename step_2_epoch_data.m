

%load and create trial definition
cfg                    = [];
cfg.trialfun = 'trialfun_p300'; %I am assuming this is where name is set...
cfg.dataset            = dataset_path;             % set the name of the dataset
cfg_tr_def             = ft_definetrial(cfg);   % read the list of the specific stimulus

%epoch data into trials
trial_data = ft_redefinetrial(cfg_tr_def, filt_data);

%view data
cfg = [];  % use only default options
ft_databrowser(cfg, trial_data); %<- lets you browse data...

%This one outputs something more interesting to look at. Maybe s1 has a lot
%of dead air?