# WaveMonk
Detect and Quantify Cortical Traveling Wave in Monkey Utah array recordings.
## About
Identification and quantification of cortical traveling waves of the follwoing dataset: ["Traveling waves in the monkey frontoparietal network predict recent reward memory "](https://www.nature.com/articles)


## Analysis paradigm

![Analysis Paradigm](./Analysis%20Overview.png)

Traveling Wave Strength calculation paragiam.  Illustrating the analysis paradigm obtaining wave strength maps. For each recording electrode in position x and y the raw LFP signal (Vx,y(t)) decomposed to oscillatory components (vfx,y(t)) with a frequency range (f) from 2 to 50 Hz. For each decomposed oscillation the phase of oscillation (fx,y(t)) is extracted using Hilbert transform and then all the electrode phases are pulled together to develop phase-location space for calculation of traveling wave properties. The traveling wave properties for each oscillation decomposition were calculated independently and then the strength of the wave merged for all frequencies illustrated in the PGD map.

## Data Structure
0) Electrophysiology recordings
1) LEGEND FOR FIGURE 
2) Add methode detail
3) Reading data properties
4) Add the simple eye position data
