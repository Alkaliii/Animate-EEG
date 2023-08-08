dst_path = "PATH_TO_SAVE_PREPROCESSED_DATA";

%downsample data to 256 hz
cfg = [];
cfg.resamplefs=256;
resampled_data = ft_resampledata(cfg, repaired_data);

%avg rereference data
cfg = [];
cfg.channel = 'all'; % this is the default
cfg.reref = 'yes';
cfg.refmethod = 'avg';
cfg.refchannel = 'all';
export_data = ft_preprocessing(cfg, resampled_data);

%save preprocessed data
save(dst_path, 'export_data');

%view data
cfg = [];  % use only default options
ft_databrowser(cfg, export_data);
