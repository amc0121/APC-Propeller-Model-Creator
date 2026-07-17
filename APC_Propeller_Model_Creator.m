% File Information:
%   APC_Propeller_Model_Creator - top-level script to create MATLAB 
%   interpolant data from APC propeller .dat files
%
% REFERENCES: 
%   [1] Comer, A., Atkinson, Z., Bhandari, P., Miller, Z., Harp, E.
%   Development of a Simulation to Flight Workflow for Subscale Flight 
%   Testing of Experimental Control Laws
%   AIAA SCITECH 2026 Forum | AIAA 2026-2063
%   https://doi.org/10.2514/6.2026-2063
%   [2] Ciliberti, D.
%   read-APC-prop-perfo-data | github repository
%   https://github.com/dciliberti/read-APC-prop-perfo-data/blob/master/README.md
%
% DESCRIPTION: 
%   This script wraps together 2 seperate scripts:
%   1) ParseAPCPropData.p - responsible for creating interpolated tables
%   2) Create_IPPM.p - responsible for creating surface equations
%   to create surface equations [Output] = f(N,V) as described in Eq. (11)
%   of Ref. [1]. These surface equations describe Thrust, Torque, and Power
%   as functions of RPM (N) and axial velocity (V) [m/s]. Additionally, a 
%   surface equation is developed to estimate the required RPM based on a 
%   required thrust as follows: [N] = f(T,V), where T is requested thrust 
%   [N] and V is the axial velocity [m/s].
%
% INPUTS: 
%   FitRPMRange - prop rotational speed of interest for fitting [rpm]
%
% OUTPUTS:
%   RefTbl_PER3_DxP(I) - interpolates APC propeller data into MATLAB table
%   PropData_DxP(I) - identified surface equation coefficients (Ref. [1])
%   RefTbl - workspace variable containing identified APC prop data
%   FitComp - response surface equation (RSE) data estimates, including 
%   comparison data and value ratios (measures of fit)
%
% WRITTEN BY:
%   Anthony M. Comer
%   Oklahoma State University
%   Simulation to Flight Applied Research (S2FAR) Laboratory
%   Email: anthony.comer@okstate.edu
%
% HISTORY:
%   15 JUL 2026 - created, commented, and debugged, AMC
%
%   Questions? Reach out!
%
% ***WE KINDLY REQUEST YOU REFERENCE THIS IF USED TO SUPPORT YOUR WORK!***
%
% clear workspace
clc, clear all, close all
%------------------------

% Fit RPM Range - UPDATE ACCORDINGLY!
% this is the RPM range over which the fit will be the most accurate
% set this range based on the anticipated RPM range
FitRPMRange = [4000,10000];

% Call the APC propeller parsing script--in this script, you will be asked
% to locate the specific .dat file in your files which you would like to 
% create data tables for.
ParseAPCPropData

% verify that this is the correct prop identifier!
PropID = filename(6:end-4);
fprintf('You have selected the following propeller: %s\n',PropID);
fprintf('The propeller data is being fit in the following RPM range: [%d,%d]\n\n',FitRPMRange)

% Create the surface equations and inverse propulsor model (IPPM, Ref. [1]),
% for your selected propeller at your identified range (see Line 57).
CreateRSE

% Note: you may find that your results are not always perfect--please
% review your fit levels and remember to correct for density when using the
% idenfitied surface equations!

% Note: extreme cases (e.g., low RPM, end conditions) may show large ratios
% due to badly fit data--please observe your fit ratios "..._ratio" in the
% FitComp table to determine whether the fit is sufficient for your needs!