# dotfiles

dev-machine-as-code

This repo serves more as a checklist and a guideline on what to do to set up a new laptop. It no longer provides a single script to install all dev dependencies. Over time, the cost of maintaining the scripts to be compatible with OS and tool changes become too high and a lot of time is spent trying to debug the broken script. Since setting up a machine only happens once every year at most, I have decided to change the approach to be more of a checklist and guideline.

The main parts of this repo are:
1. Using brew to install the minimum tools needed to get up and running
1. Using stow to sync various CLI app config files
1. Using mackup to sync various GUI app config files. [TODO: Review if mackup still makes sense]
1. Changing Mac default prefs

## Usage

1. Set up Dropbox for sync backend.
1. Install brew
1. Install fish shell and initialize fish plugins
1. Run `brew bundle install` in `brew/` to install minimum brews. The `Brewfile` should contain the common tools I need on a day-to-day basis.
1. Initialize asdf plugins 
