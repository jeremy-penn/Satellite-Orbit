function iss_current_track()
    %% pulls current ISS two-line element from NORAD website
    %
    % Jeremy Penn
    % 20/11/2017
    %
    % function iss_current_track()
    %
    % Required: ecc_anomaly_from_M.m, ta_from_E.m, ground_track_from_tle.m
    %
    
    %% url to pull data
    url = 'http://www.celestrak.com/NORAD/elements/stations.txt';
    
    %% pull request for orbital data
    data = webread(url);
    
    %% isolate the ISS TLE
    sl = strsplit(data,'\n');
    
    for i = 1:3
        ss{i} = strsplit(sl{i},' ');
    end
    
    ss{3}{5} = strcat('0.',ss{3}{5});
    
    for j = 1:9
        coe(j) = str2double(ss{3}{j});
    end
    
    %% separate coe
    inc = coe(3);           %[deg]
    W   = coe(4);           %[deg]
    e   = coe(5);
    w   = coe(6);           %[deg]
    M   = coe(7) * pi/180;  %[rad]
    n   = coe(8);           %[rev/d]
    
    %% calculate the ground track
    ground_track_from_tle(inc, W, e, w, M, n)
end