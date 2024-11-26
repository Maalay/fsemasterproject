

% Motor settings
leftMotorPort = 'A';   % Replace with your left motor port
rightMotorPort = 'D';  % Replace with your right motor port
specialMotorPort = 'B'; % Motor connected to B port for up/down control
speed = 50;            % Speed for the motors

% Create a figure for key press detection
hFig = figure('Name', 'EV3 Remote Control', ...
              'KeyPressFcn', @(src, event) keyPressHandler(event, brick, leftMotorPort, rightMotorPort, specialMotorPort, speed), ...
              'KeyReleaseFcn', @(src, event) keyReleaseHandler(brick, leftMotorPort, rightMotorPort, specialMotorPort), ...
              'CloseRequestFcn', @(src, event) closeProgram(brick, leftMotorPort, rightMotorPort, specialMotorPort, hFig));

% Key press state
global keyPressed;
keyPressed = '';

disp('Remote control active. Use the following keys:');
disp('w: Forward | s: Backward | a: Turn left | d: Turn right');
disp('Up Arrow: Motor B rotate right | Down Arrow: Motor B rotate left');
disp('Release keys to stop. Close the window to exit.');

% Event handler for key press
function keyPressHandler(event, brick, leftMotorPort, rightMotorPort, specialMotorPort, speed)
    global keyPressed;
    keyPressed = event.Key; % Record the pressed key

    switch keyPressed
        case 'w' % Move forward
            brick.MoveMotor(leftMotorPort, speed);
            brick.MoveMotor(rightMotorPort, speed);
            disp('Moving forward...');
        case 's' % Move backward
            brick.MoveMotor(leftMotorPort, -speed);
            brick.MoveMotor(rightMotorPort, -speed);
            disp('Moving backward...');
        case 'a' % Turn left
            brick.MoveMotor(leftMotorPort, -speed / 2); % Left motor backward
            brick.MoveMotor(rightMotorPort, speed / 2);  % Right motor forward
            disp('Turning left...');
        case 'd' % Turn right
            brick.MoveMotor(leftMotorPort, speed / 2);  % Left motor forward
            brick.MoveMotor(rightMotorPort, -speed / 2); % Right motor backward
            disp('Turning right...');
        case 'uparrow' % Rotate the motor on port B to the right
            brick.MoveMotor(specialMotorPort, speed);
            disp('Motor B rotating right...');
        case 'downarrow' % Rotate the motor on port B to the left
            brick.MoveMotor(specialMotorPort, -speed);
            disp('Motor B rotating left...');
    end
end

% Event handler for key release
function keyReleaseHandler(brick, leftMotorPort, rightMotorPort, specialMotorPort)
    global keyPressed;
    keyPressed = ''; % Reset key press state
    % Stop all motors
    brick.StopMotor(leftMotorPort); % Stop left motor
    brick.StopMotor(rightMotorPort); % Stop right motor
    brick.StopMotor(specialMotorPort); % Stop special motor (port B)
    disp('Stopped.');
end

% Close program safely
function closeProgram(brick, leftMotorPort, rightMotorPort, specialMotorPort, hFig)
    % Stop all motors
    brick.StopMotor(leftMotorPort); % Stop left motor
    brick.StopMotor(rightMotorPort); % Stop right motor
    brick.StopMotor(specialMotorPort); % Stop special motor (port B)
    disp('Exiting remote control.');
    delete(hFig); % Close the figure window
end
