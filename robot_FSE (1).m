% Initialize EV3 connection
disp('Robot initialized.');

% Start moving forward before entering the loop
brick.MoveMotor('A', 34.6);  % Left motor forward
brick.MoveMotor('D', 33);    % Right motor forward
disp('Starting forward motion...');

lastColor = 0; % Variable to store the last detected color

while true
    % Read sensor values
    touch = brick.TouchPressed(4);  % Touch sensor on port 4 (returns 0 or 1)
    distance = brick.UltrasonicDist(1);  % Ultrasonic sensor on port 1 (distance in cm)
    color = brick.ColorCode(2);  % Color sensor on port 2

    % Check the color sensor for specific actionsww
    if color ~= lastColor % React to the color only once
        if color == 5  % Red color
            lastColor = 5; % Update last detected color
            brick.StopAllMotors();
            disp('Red color detected! Stopping for 1 second...');
            pause(1); % Stop for 1 second
            brick.MoveMotor('A', 34.6);  % Resume left motor forward
            brick.MoveMotor('D', 33);    % Resume right motor forward

        elseif color == 2  % Blue color
            lastColor = 2; % Update last detected color
            brick.StopAllMotors();
            disp('Blue color detected! Stopping in the middle...');
            
            % Move forward briefly to stop in the middle of the blue color
            brick.MoveMotor('A', 34.6);  % Left motor forward
            brick.MoveMotor('D', 33);    % Right motor forward
            pause(0.5); % Adjust timing to reach the middle
            
            % Stop and beep 2 times
            brick.StopAllMotors();
            for i = 1:2
                brick.beep();
                pause(0.5); % Short pause between beeps
            end
            
            % Activate remote control for 7 seconds
            activateTemporaryRemoteControl(brick);
            
            % Resume forward motion
            brick.MoveMotor('A', 34.6);  % Resume left motor forward
            brick.MoveMotor('D', 33);    % Resume right motor forward

        elseif color == 3  % Green color
            lastColor = 3; % Update last detected color
            brick.StopAllMotors();
            disp('Green color detected! Stopping in the middle...');
            
            % Stop and beep 3 times
            for i = 1:3
                brick.beep();
                pause(0.5); % Short pause between beeps
            end
            
            % Activate remote control for 7 seconds
            activateTemporaryRemoteControl(brick);
            
            % Resume forward motion
            brick.MoveMotor('A', 34.6);  % Resume left motor forward
            brick.MoveMotor('D', 33);    % Resume right motor forward

        elseif color == 4  % Yellow color
            lastColor = 4; % Update last detected color
            brick.StopAllMotors();
            disp('Yellow color detected! Beeping 4 times...');
            for i = 1:4
                brick.beep();
                pause(0.5); % Short pause between beeps
            end
            activateTemporaryRemoteControl(brick);
            brick.MoveMotor('A', 34.6);  % Resume left motor forward
            brick.MoveMotor('D', 33);    % Resume right motor forward
        end
    end

    % Check touch sensor and ultrasonic sensor for actions
    if touch == 1
        % If the touch sensor is pressed, back up and turn right
        brick.StopAllMotors();
        disp('Obstacle detected! Backing up and turning right...');
        
        % Move backward
        brick.MoveMotor('A', -34.4);  % Left motor backward
        brick.MoveMotor('D', -33);    % Right motor backward
        pause(1);  % Back up for 1 second
        
        % Stop motors before turning
        brick.StopAllMotors();
        pause(0.5); % Pause before turning
        
        % Move only the left motor forward to turn right
        brick.MoveMotor('A', 52.5); % Left motor forward
        pause(0.68);               % Adjust timing to achieve a 90-degree turn
        
        % Stop motors after turning and pause briefly
        brick.StopAllMotors();
        pause(0.5); % Pause for 0.5 seconds after turn
        
        % Resume forward motion after turning
        brick.MoveMotor('A', 34.5);  % Left motor forward
        brick.MoveMotor('D', 33);    % Right motor forward
        disp('Resuming forward motion...');
    
    elseif distance > 45
        % If the ultrasonic sensor detects a distance greater than 40 cm, turn left
        brick.StopAllMotors();
        disp('Open space detected! Turning left...');
        pause(0.5); % Pause before turning
        
        % Move only the right motor forward to turn left
        brick.MoveMotor('D', 60.5);  % Right motor forward
        pause(0.5);               % Adjust timing to achieve a 90-degree turn
        
        % Stop motors after turning and pause briefly
        brick.StopAllMotors();
        pause(0.5); % Pause for 0.5 seconds after turn
        
        % Move forward without detecting anything for 3 seconds
        disp('Moving forward without ultrasonic sensor detection...');
        brick.MoveMotor('A', 34.5);  % Left motor forward
        brick.MoveMotor('D', 33);    % Right motor forward
        pause(3);  % Prevent ultrasonic sensor from detecting for 3 seconds
    else
        % Default behavior: move forward
        brick.MoveMotor('A', 34.5);  % Left motor forward
        brick.MoveMotor('D', 33);    % Right motor forward
        disp('Moving forward...');
    end
end

% Updated Remote Control Section
function activateTemporaryRemoteControl(brick)
    disp('Activating remote control mode...');
    
    % Create a figure for keypress control
    figureHandle = figure('Name', 'EV3 Remote Control', ...
        'KeyPressFcn', @(src, event) keyPressHandler(brick, event), ...
        'CloseRequestFcn', @(src, event) closeRemoteControl(brick, src));

    disp('Use keys to control the robot:');
    disp('- W: Move forward.');
    disp('- S: Move backward.');
    disp('- A: Turn left.');
    disp('- D: Turn right.');
    disp('- Arrow Up: Forklift up slightly.');
    disp('- Arrow Down: Forklift down slightly.');
    disp('- Arrow Left/Right: Stop and exit.');

    % Wait until the figure is closed
    waitfor(figureHandle);

    disp('Remote control mode ended.');
end

% Function to handle keypress events
function keyPressHandler(brick, event)
    switch event.Key
        case 'w'
            disp('W pressed: Moving forward...');
            brick.MoveMotor('A', 15); % Left motor forward
            brick.MoveMotor('D', 15); % Right motor forward
            pause(0.5); 
            brick.StopMotor('A'); 
            brick.StopMotor('D'); 
        case 's'
            disp('S pressed: Moving backward...');
            brick.MoveMotor('A', -15); 
            brick.MoveMotor('D', -15); 
            pause(0.5); 
            brick.StopMotor('A'); 
            brick.StopMotor('D'); 
        case 'a'
            disp('A pressed: Turning left...');
            brick.MoveMotor('A', -15); 
            brick.MoveMotor('D', 15);  
            pause(0.5); 
            brick.StopMotor('A'); 
            brick.StopMotor('D'); 
        case 'd'
            disp('D pressed: Turning right...');
            brick.MoveMotor('A', 10);  
            brick.MoveMotor('D', -10); 
            pause(0.5); 
            brick.StopMotor('A'); 
            brick.StopMotor('D'); 
        case 'uparrow'
            disp('Arrow Up pressed: Moving forklift up slightly...');
            brick.MoveMotor('B', -10); 
            pause(0.3); 
            brick.StopMotor('B'); 
        case 'downarrow'
            disp('Arrow Down pressed: Moving forklift down slightly...');
            brick.MoveMotor('B', 10); 
            pause(0.3); 
            brick.StopMotor('B');
        case {'leftarrow', 'rightarrow'}
            disp('Arrow Left/Right pressed: Exiting remote control mode...');
            brick.StopAllMotors();
            close(gcf); 
        otherwise
            disp('Invalid key pressed. Use W, A, S, D, or arrow keys.');
    end
end

% Function to safely close the remote control
function closeRemoteControl(brick, figureHandle)
    disp('Exiting remote control mode...');
    brick.StopAllMotors();
    delete(figureHandle);
end
