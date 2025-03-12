# AAE6102 Satellite Communication and Navigation Assignment 1 Report

## Author: SU Meiling 23037224R

---

## Table of Contents

1. [Task 1: Acquisition](#task-1--acquisition)
2. [Task 2: Tracking](#task-2--tracking)
    - [2.1 Analysis of Tracking Performance Based on C/N₀ and DLL Discriminator](#21-analysis-of-tracking-performance-based-on-cn₀-and-dll-discriminator)
        - [2.1.1 Analysis of Tracking Performance Based on C/N₀](#211-analysis-of-tracking-performance-based-on-cn₀)
        - [2.1.2 Correlating C/N₀ with DLL Discriminator Performance](#212-correlating-cn₀-with-dll-discriminator-performance)
    - [2.2 Impact of Urban Interference on Correlation Peaks](#22-impact-of-urban-interference-on-correlation-peaks)
    - [2.3 Conclusions & Recommendations](#23-conclusions--recommendations)
3. [Task 3: Navigation Data Decoding](#task-3--navigation-data-decoding)
4. [Task 4: Position and Velocity Estimation](#task-4--position-and-velocity-estimation)
    - [Discussion on the impact of multipath effects on the WLS solution](#discussion-on-the-impact-of-multipath-effects-on-the-wls-solution)
5. [Task 5: Kalman Filter-Based Positioning](#task-5--kalman-filter-based-positioning)
6. [Conclusion](#conclusion)

---

## Task 1: Acquisition
The first step in GNSS signal processing is acquisition, where Intermediate Frequency (IF) data is processed using a GNSS Software-Defined Radio (SDR). The acquisition process aims to detect satellite signals and estimate their coarse Doppler shift and code phase. The results of the acquisition provide an initial assessment of signal availability, ensuring that the satellites can be successfully tracked in subsequent steps.

---

## Task 2: Tracking
The tracking phase involves adapting the tracking loop, specifically the Delay-Locked Loop (DLL), to maintain a steady lock on the satellite signals. Multiple correlators are implemented to generate correlation plots, allowing for an in-depth analysis of tracking performance. The impact of urban interference, such as multipath and signal blockage, is examined by analyzing the correlation peaks. In urban environments, reduced signal strength and distorted correlation functions can negatively affect tracking stability.

### Tracking results for Opensky Dataset
- CNo-3 and Dll-3
- CNo-4 and Dll-4
- CNo-8 and Dll-8
- CNo-16 and Dll-16
- CNo-22 and Dll-22
- CNo-26 and Dll-26
- CNo-27 and Dll-27
- CNo-31 and Dll-31
- CNo-32 and Dll-32

### 2.1 Analysis of Tracking Performance Based on C/N₀ and DLL Discriminator

This report analyzes the tracking performance of different satellites based on Carrier-to-Noise Ratio (C/N₀) and DLL (Delay Lock Loop) discriminator outputs. The Carrier-to-Noise Ratio (C/N₀) provides insights into signal strength and quality, while DLL discriminator outputs indicate tracking accuracy. Both parameters are essential in evaluating how well a GNSS receiver tracks satellite signals, especially in urban environments, where multipath and signal obstructions affect performance.

#### 2.1.1 Analysis of Tracking Performance Based on C/N₀
The uploaded C/N₀ figures show the variation of signal quality over time for different satellites. Below is a summary of observations:

| Satellite (PRN) | C/N₀ Performance | Observations |
|-----------------|------------------|--------------|
| Satellite 3     | Fluctuating (30-40 dB-Hz) | Significant dips indicate weak signal or obstruction. |
| Satellite 4     | Moderate (30-40 dB-Hz)    | Some variations but relatively stable tracking. |
| Satellite 8     | Weak (20-35 dB-Hz)        | Frequent drops suggest interference or multipath. |
| Satellite 16    | Good (32-48 dB-Hz)        | Strong and stable signal reception. |
| Satellite 22    | Moderate (30-40 dB-Hz)    | Some fluctuations but remains in an acceptable range. |
| Satellite 26    | Weak (20-35 dB-Hz)        | Low signal strength with occasional deep dips. |
| Satellite 27    | Strong (35-45 dB-Hz)      | Good signal strength, minor fluctuations. |
| Satellite 31    | Moderate (30-40 dB-Hz)    | Some instability but mostly stable tracking. |
| Satellite 32    | Weak (28-38 dB-Hz)        | High fluctuations, indicating possible urban interference. |

**Key Takeaways from C/N₀ Analysis:**
- Satellites 16 and 27 have the best tracking conditions with strong C/N₀ values (above 35 dB-Hz) and relatively stable signals.
- Satellites 8, 26, and 32 exhibit the weakest signals, with frequent dips below 30 dB-Hz, indicating high interference or signal blockage.
- Satellites 3, 4, 22, and 31 maintain moderate signal strength, showing fluctuations but generally within an acceptable range for tracking.

#### 2.1.2 Correlating C/N₀ with DLL Discriminator Performance

By comparing C/N₀ trends with DLL discriminator outputs, we can evaluate how signal quality affects tracking accuracy.

| Satellite | DLL Stability | C/N₀ Strength | Impact on Tracking |
|-----------|---------------|---------------|--------------------|
| 3         | Poor (high fluctuations) | Moderate to weak (30-40 dB-Hz) | Tracking errors due to signal loss. |
| 4         | Moderate      | Moderate (30-40 dB-Hz) | Occasional tracking instability. |
| 8         | Poor (high variations) | Weak (20-35 dB-Hz) | Severe multipath and urban interference. |
| 16        | Stable        | Strong (32-48 dB-Hz) | Good tracking performance. |
| 22        | Moderate      | Moderate (30-40 dB-Hz) | Some signal loss but reasonable tracking. |
| 26        | Poor (high variations) | Weak (20-35 dB-Hz) | Frequent tracking errors due to low signal strength. |
| 27        | Stable        | Strong (35-45 dB-Hz) | Reliable tracking. |
| 31        | Moderate      | Moderate (30-40 dB-Hz) | Some fluctuations, but mostly stable. |
| 32        | Poor (high variations) | Weak (28-38 dB-Hz) | Strong effects of urban interference. |

**Key Observations:**
- Strong C/N₀ (above 35 dB-Hz) correlates with stable DLL tracking (e.g., Satellites 16 and 27).
- Low C/N₀ (below 30 dB-Hz) results in erratic DLL behavior, indicating difficulty maintaining signal lock (e.g., Satellites 8, 26, and 32).
- Satellites with moderate C/N₀ (30-40 dB-Hz) experience occasional tracking issues, suggesting intermittent urban interference.

### 2.2 Impact of Urban Interference on Correlation Peaks
Urban environments significantly degrade GNSS tracking due to:
1. **Multipath Effects**
   - Signals reflect off buildings, causing delayed versions of the original signal to interfere with direct signals.
   - This leads to distorted correlation peaks, increasing DLL tracking errors.
2. **Signal Blockage & Attenuation**
   - Obstructions from buildings, trees, and tunnels cause abrupt signal drops, seen as C/N₀ dips in satellites like 8, 26, and 32.
   - Affected signals have erratic DLL discriminator outputs, indicating poor tracking stability.
3. **Dynamic Signal Variations**
   - Moving receivers (e.g., vehicles) cause sudden changes in signal strength, leading to C/N₀ fluctuations.
   - Satellites with high variability in C/N₀ (like 3, 8, and 32) show inconsistent tracking accuracy.

### 2.3 Conclusions & Recommendations
**Summary of Findings:**
- **Best Tracking Performance:** Satellites 16 and 27 (High C/N₀, stable DLL).
- **Worst Tracking Performance:** Satellites 8, 26, and 32 (Low C/N₀, erratic DLL).
- **Moderate Tracking:** Satellites 3, 4, 22, and 31 (fluctuating performance, likely urban interference effects).

---

## Task 3: Navigation Data Decoding
Once tracking is established, the navigation message is decoded to extract critical parameters, including ephemeris data. The ephemeris data provides precise satellite position and clock information, which is necessary for accurate positioning. At least one satellite's data is successfully decoded, demonstrating the ability to retrieve key orbital parameters required for user position estimation.

**Extracted Parameters For a sample satellite (PRN 20):**
- **PRN (Pseudo-Random Number):** 20
- **Satellite Position (X, Y, Z) in meters:**
  - X: [150292.77, -18036996.46, -23097527.61, 6106606.07, -22404285.92, -10058685.30, 10623241.46]
  - Y: [25408951.23, 16570806.91, 13345041.64, 25290124.32, 3641352.36, 20708226.50, 19053666.42]
  - Z: [8035554.65, 9553530.43, 412700.87, -5342505.70, 13758992.52, -13131481.28, 14883179.78]
- **Satellite Clock Correction:** 0.00036635 seconds
- **Transmit Time (GPS Time in seconds):** Starts at 388458.0076751 and increments sequentially.

---

## Task 4: Position and Velocity Estimation
Pseudorange measurements obtained from the tracking phase are utilized in a Weighted Least Squares (WLS) algorithm to compute the user's position and velocity. The following steps are undertaken:
- The user position and velocity are plotted to visualize the estimated trajectory.
- The computed position is compared with the ground truth to assess the accuracy of the estimation.
- The impact of multipath effects on the WLS solution is discussed, highlighting how signal reflections can introduce errors and degrade positioning accuracy.

The Weighted least square function is written in `WLSPos.m` file. The receiver’s position and velocity are calculated by the designed code in `PosNavigation.m`, and the results are shown in `navResults.mat` as WLSX, WLSY, WLSZ, Vx, Vy, Vz, and Speed respectively.

**The plot of the receiver’s position calculated by least square method and weighted least square method:**
- **Least Square:** ![Least Square Plot](./path_to_least_square_plot)
- **Weighted Least Square:** ![Weighted Least Square Plot](./path_to_weighted_least_square_plot)

**Velocity:**
The receiver's velocity at each epoch is calculated using the WLSX, WLSY, and WLSZ positions divided by the sampling interval:

**Velocity Plot:** ![Velocity Plot](./path_to_velocity_plot)

The position results calculated using the weighted least square method are converted to geodetic coordinates to compare with the ground truth:

**Result comparison:**
- **Opensky**
  - **WLS results in Open Sky:** ![WLS Open Sky](./path_to_wls_open_sky)
  - **Ground Truth in Open Sky:** (22.328444770087565, 114.1713630049711)
- **Urban**
  - **WLS results in Urban:** ![WLS Urban](./path_to_wls_urban)
  - **Ground truth in Urban:** (22.3198722, 114.209101777778)

### Discussion on the impact of multipath effects on the WLS solution
Multipath effects occur when GPS signals reflect off nearby surfaces (such as buildings, water, or terrain) before reaching the receiver. This causes distortions in pseudorange and Doppler measurements, leading to positioning errors. Below, we analyze how multipath impacts the WLS solution under open-sky and urban environments.

1. **Multipath Effects in Open-Sky Environment**
   - **Observed Data:**
     - Ground Truth: (22.328444770087565, 114.1713630049711)
     - WLS Estimate: (22.3285, 114.1714)
     - Error: 0.00005° (≈5.5 meters)
   - **Analysis:**
     - The error in WLS estimation is small (~5.5 meters).
     - In open-sky conditions, direct line-of-sight (LOS) signals dominate the measurement, minimizing multipath effects.
     - Multipath mainly arises from ground reflections, but modern receivers often mitigate this via antenna design and signal processing (e.g., multipath rejection filters).
     - Minimal impact on WLS since pseudorange errors remain small.

2. **Multipath Effects in Urban Environment**
   - **Observed Data:**
     - Ground Truth: (22.3198722, 114.209101777778)
     - WLS Estimate: (22.32, 114.209)
     - Error: ~14 meters
   - **Analysis:**
     - Urban environments introduce severe multipath due to buildings reflecting signals.
     - Non-line-of-sight (NLOS) reception occurs when the direct signal is obstructed, and only reflections reach the receiver.
     - Pseudorange errors can be significant, often exceeding tens of meters.
     - Doppler shifts may also be affected, causing errors in velocity estimation.
     - WLS assigns weights based on Carrier-to-Noise Ratio (C/N0), but in urban settings, even high C/N0 signals can be distorted due to multipath reflections.
     - Positioning accuracy drops significantly compared to open-sky.

**Conclusion:**
- Multipath has a negligible effect in open-sky conditions, leading to high WLS accuracy.
- Multipath in urban areas introduces large errors (~14m), degrading WLS accuracy. Traditional WLS struggles in dense environments due to high pseudorange variance.

3. **How Multipath Affects WLS**
   - **Pseudorange Bias:**
     - GPS receivers measure the time delay of satellite signals.
     - If multipath increases the path length, pseudorange is overestimated, shifting the position estimate.
     - This bias is more significant in urban environments due to reflected signals.
   - **Reduced Weighting Accuracy in WLS:**
     - WLS relies on C/N0 for weighting measurements.
     - In urban areas, strong reflected signals may appear legitimate, leading to incorrect high weights for bad measurements.
   - **Increased Positioning Error:**
     - In open-sky conditions, pseudorange errors are typically ≤5m.
     - In urban environments, errors exceed 10m due to reflections and signal blockage.

---

## Task 5: Kalman Filter-Based Positioning
To enhance positioning accuracy, an Extended Kalman Filter (EKF) is developed using pseudorange and Doppler measurements. The EKF framework enables dynamic filtering and smoothing of the position and velocity estimates, leading to improved robustness against measurement noise and signal disturbances. The EKF implementation provides refined positioning results and demonstrates its advantages over the WLS approach in challenging environments.

The EKF algorithm is written in the `EKF.m` file. The position processing is written in the `postnavigation.m` file.

**EKF results in Opensky:** ![EKF Opensky](./path_to_ekf_opensky)
**EKF results in Urban:** ![EKF Urban](./path_to_ekf_urban)

---

## Conclusion
The report details the step-by-step implementation of GNSS signal processing, from acquisition to advanced positioning techniques. The impact of urban interference and multipath effects is analyzed, and the benefits of using Kalman filtering for enhanced accuracy are demonstrated. This work underscores the importance of robust signal processing techniques for reliable GNSS-based navigation.

The code is shared in the [GitHub Repository](https://github.com/SueMM00/AAE6102_Assignment1.git).
