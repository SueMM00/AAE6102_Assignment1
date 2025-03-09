Author: SU Meiling (23037224R)

This repository contains the implementation and results of GNSS signal processing from acquisition to positioning using various techniques, including Weighted Least Squares (WLS) and Kalman Filtering.

Table of Contents

Task 1: Acquisition

Task 2: Tracking

Task 3: Navigation Data Decoding

Task 4: Position and Velocity Estimation

Task 5: Kalman Filter-Based Positioning

Results and Analysis

Conclusion

Task 1: Acquisition

The first step in GNSS signal processing is acquisition, where Intermediate Frequency (IF) data is processed using a GNSS Software-Defined Radio (SDR). The acquisition process aims to detect satellite signals and estimate their coarse Doppler shift and code phase.

Task 2: Tracking

Tracking is performed using Delay-Locked Loop (DLL) and correlator-based signal processing. The impact of urban interference, such as multipath and signal blockage, is analyzed through C/N₀ and DLL discriminator outputs.

Tracking Results

Carrier-to-Noise Ratio (C/N₀) and DLL Tracking Plots

 

 

... (Include figures for all satellites)

Analysis of Tracking Performance

Satellite

C/N₀ Performance

Observations

3

30-40 dB-Hz

Fluctuating, weak signals

16

32-48 dB-Hz

Strong and stable

26

20-35 dB-Hz

Weak, frequent drops

Task 3: Navigation Data Decoding

Once tracking is established, navigation messages are decoded to extract ephemeris data, which provides precise satellite position and clock corrections.

Example extracted parameters for PRN 20:

Satellite Position (X, Y, Z) in meters:

X: [...]

Y: [...]

Z: [...]

Satellite Clock Correction: 0.00036635 seconds

Transmit Time (GPS Time): 388458.0076751 seconds

Task 4: Position and Velocity Estimation

User positioning is computed using Weighted Least Squares (WLS).

Position Results

Least Squares vs. Weighted Least Squares

 

Velocity Estimation

Velocity Plot



Comparison with Ground Truth

Environment

WLS Estimate

Ground Truth

Error

Open Sky

(22.3285, 114.1714)

(22.3284, 114.1713)

~5.5m

Urban

(22.32, 114.209)

(22.3199, 114.2091)

~14m

Impact of Multipath

Open Sky: Minimal error (~5m), direct line-of-sight signals dominate.

Urban: Severe multipath, positioning errors exceed 10m.

Task 5: Kalman Filter-Based Positioning

An Extended Kalman Filter (EKF) is implemented to enhance positioning accuracy using pseudorange and Doppler measurements.

EKF Results

Open Sky Positioning (EKF)



Urban Positioning (EKF)



Comparison with WLS

Kalman filtering significantly reduces errors and improves positioning stability in urban environments.

Conclusion

This project showcases GNSS signal processing techniques from acquisition to positioning. The key findings include:

WLS provides good accuracy in open-sky environments but struggles in urban settings due to multipath effects.

EKF enhances positioning stability and mitigates measurement noise.

Urban interference significantly impacts GNSS tracking, highlighting the need for robust signal processing techniques.

Repository Link

The source code is available in this GitHub repository.

How to Use

Clone the repository:

git clone https://github.com/SueMM00/AAE6102_Assignment1.git

Run MATLAB scripts to process GNSS data:

WLSPos.m (Weighted Least Squares computation)

EKF.m (Extended Kalman Filter implementation)

PosNavigation.m (Position estimation)

Visualize results using provided MATLAB scripts.

Acknowledgments

Special thanks to AAE6102 instructors and OpenSky dataset contributors for providing valuable GNSS data for analysis.



The code can be downloaded through the link below:
https://www.dropbox.com/scl/fo/4r8n7glpek7wtfht8jb8y/AJ-Nxwa4SQv961lH_lbxs4s?rlkey=59ulvlv9vh0jwloubs7lvbpcq&st=8czzg37k&dl=0

Run init.m to process the dataset, and the results will be generated.
The processed results are stored in the folder of Opensky and Urban
