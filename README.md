# Animate-EEG
Some code concerning another way to produce topoplot animations in Matlab using FieldTrip. Written for NEUR 4990.

## Setup and Usage
- Use `step_0_AddFieldTripPath.m` to start up FieldTrip
- In Matlab add the `ft_depend` folder to your path, it contains helper scripts from FieldTrip that cannot be called normally
- Preprocess your data if you have not already, this repo contains a pipeline if need be...
- Open `makeTopoplots.m` and configure options under `%paths`,`%parameters`, and optionally `%aesthethics`
- Run `makeTopoplots.m` and wait for an hour or two, the script will error out if your computer falls asleep
- After one completed run you can use `writeVideo.m` to resave the frame data with different options, this only works if `frames` is still intact
