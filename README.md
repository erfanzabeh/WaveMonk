[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
![Build Status](https://github.com/DeepMReye/DeepMReye/actions/workflows/main.yml/badge.svg)
[![NatCom Paper](https://img.shields.io/badge/DOI-10.1038%2Fs41593--021--00947--w-blue)](https://doi.org/10.1101/2022.02.03.478583)
![Docker Pulls](https://img.shields.io/docker/pulls/deepmreye/deepmreye)

# WaveMonk
High-resolution measurements and detection of cortical traveling waves.
This repository designed for identification and quantification of cortical traveling waves and is has been used for the following dataset: ["Traveling waves in the monkey frontoparietal network predict recent reward memory "](https://www.nature.com/articles)

![Demo video](media/ErfunTwitt.gif)
## Install

Run or write the **wavemonk** directory directly into the MATLAB path with the functions *addpath* and *genpath*.


The user would then be ready to detect waves at specified timepoints in the data by using the phase maps as input to the relevant function (e.g. *phase_correlation_distance*, *phase_correlation_rotation*).

## Dynamic-Frequency Wave Detection Paradiam

Traveling Wave Strength calculation paradigm.  Illustrating the analysis paradigm obtaining wave strength maps. For each recording electrode in position x and y the raw LFP signal (Vx,y(t)) decomposed to oscillatory components (vfx,y(t)) with a frequency range (f) from 2 to 50 Hz. For each decomposed oscillation the phase of oscillation (fx,y(t)) is extracted using Hilbert transform and then all the electrode phases are pulled together to develop phase-location space for calculation of traveling wave properties. The traveling wave properties for each oscillation decomposition were calculated independently and then the strength of the wave merged for all frequencies illustrated in the PGD map.

![Analysis Paradigm](./Analysis%20Overview.png)

## Testing

Tested on MATLAB under OSX and Windows.

## Citing **WaveMonk**

If you publish work using or mentioning **WavMonke**, I would greatly appreciate if you would cite our paper ([bibtex](https://www.biorxiv.org/content/10.1101/2022.02.03.478583v1.abstract):

[E. Zabeh, N.C. Foley, J. Jacobs, J.P. Gottlieb, Traveling waves in the monkey frontoparietal network predict recent reward memory
, In press at Nature Communication](https://www.biorxiv.org/content/10.1101/2022.02.03.478583v1.abstract)
