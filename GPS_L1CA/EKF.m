function [x_est, P_est] = EKF(satPos, pseudorange, carrFreq, settings)
% Implements an Extended Kalman Filter (EKF) for GPS Position & Velocity Estimation
%
% Inputs:
%   pseudorange - Vector of pseudorange measurements (Nx1)
%   carrFreq    - Vector of carrier frequency shifts (Nx1) [from acquisition.m]
%   satPos      - Matrix of satellite positions [X; Y; Z] (3xN)
%   settings    - Receiver settings (includes time step, noise params, etc.)
%
% Outputs:
%   x_est - Estimated state vector [X, Y, Z, Vx, Vy, Vz, b, dot(b)]
%   P_est - Estimated covariance matrix

    % Constants
    c = 299792458; % Speed of light (m/s)
    f_L1 = 1.57542e9; % L1 GPS frequency (Hz)
    dt = settings.navSolPeriod / 1000; % Convert ms to seconds
    IF = settings.IF; % Intermediate Frequency

    % Compute Doppler shift from carrier frequency
    doppler = -(carrFreq - IF) * c / f_L1;

    % Number of satellites
    numSat = size(satPos, 2);
    if numSat < 4
        error('Not enough satellites for position estimation (need at least 4).');
    end

    % Initial State Vector [X, Y, Z, Vx, Vy, Vz, b, dot(b)]
    x_est = zeros(8, 1);  
    P_est = eye(8) * 1e6; % Large initial covariance

    % Process Noise Covariance
    Q = diag([1, 1, 1, 10, 10, 10, 1e-2, 1e-4]);

    % Measurement Noise Covariance
    R_pseudo = 10;    % Pseudorange noise (meters)
    R_doppler = 1;    % Doppler noise (Hz)
    
    % EKF Prediction Step
    F = eye(8); % State Transition Model
    F(1, 4) = dt;  F(2, 5) = dt;  F(3, 6) = dt;  
    F(7, 8) = dt;  

    x_pred = F * x_est;
    P_pred = F * P_est * F' + Q; % Predicted covariance

    % ================= Measurement Update Step ==================
    % Initialize measurement model
    H = zeros(2 * numSat, 8); 
    Z = zeros(2 * numSat, 1);  
    h_x = zeros(2 * numSat, 1);  

    for i = 1:numSat
        Xs = satPos(1, i);  Ys = satPos(2, i);  Zs = satPos(3, i);
        dX = Xs - x_pred(1);
        dY = Ys - x_pred(2);
        dZ = Zs - x_pred(3);
        rho = sqrt(dX^2 + dY^2 + dZ^2); % Range

        % Pseudorange Measurement
        H(i, :) = [-dX/rho, -dY/rho, -dZ/rho, 0, 0, 0, 1, 0]; 
        Z(i) = pseudorange(i);
        h_x(i) = rho + c * x_pred(7);

        % Doppler Measurement
        relVel = (dX*x_pred(4) + dY*x_pred(5) + dZ*x_pred(6)) / rho;
        H(numSat + i, :) = [0, 0, 0, -dX/rho, -dY/rho, -dZ/rho, 0, c];
        if i > length(doppler)  % Ensure index does not exceed doppler length
            Z(numSat + i) = 0;  % Assign zero if Doppler data is missing
        else
        Z(numSat + i) = doppler(i);
        end
        h_x(numSat + i) = relVel + c * x_pred(8);
    end

    % Measurement Noise Covariance Matrix
    R = diag([ones(1, numSat) * R_pseudo, ones(1, numSat) * R_doppler]);

    % Innovation Calculation
    y = Z - h_x; 
    S = H * P_pred * H' + R;
    K = P_pred * H' / S; % Kalman Gain

    % Update State Estimate
    x_est = x_pred + K * y;
    P_est = (eye(8) - K * H) * P_pred;

    % Display status
    fprintf('Estimated Position: X=%.2f, Y=%.2f, Z=%.2f | Velocity: Vx=%.2f, Vy=%.2f, Vz=%.2f\n', ...
            x_est(1), x_est(2), x_est(3), x_est(4), x_est(5), x_est(6));
end
