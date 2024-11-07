while true
    % Initial forward movement
    brick.MoveMotor('A', 43.4);
    brick.MoveMotor('D', 50);

    % Read sensor values
    distance = brick.UltrasonicDist(1);  % Ultrasonic sensor on the left
    touch = brick.TouchPressed(3);       % Touch sensor in front

    if touch == 1
        % If touch sensor is pressed, beep, back up, and turn right
        brick.beep();
       
        % Move backward for a short distance
        brick.MoveMotor('A', -43.4);  % Left motor backward
        brick.MoveMotor('D', -50);  % Right motor backward
        pause(0.5);                 % Pause for 0.5 seconds
        brick.StopAllMotors();      % Stop motors briefly
       
        % Turn 90 degrees to the right
        brick.MoveMotorAngleRel('A', 70, 195, 'Brake'); % Left motor forward
        brick.MoveMotorAngleRel('D', 70, -175, 'Brake'); % Right motor backward
        brick.WaitForMotor('A');    % Wait for turn to complete
        brick.WaitForMotor('D');
       
    elseif distance > 30
        % If no wall is detected (distance > 30), move forward a bit, then turn left
       
        % Move forward for a bit
        brick.MoveMotor('A', 43.4);
        brick.MoveMotor('D', 50);
        pause(1);                   % Move forward for 1 second
        brick.StopAllMotors();
       
        % Turn 90 degrees to the left
        brick.MoveMotorAngleRel('A', 70, -195, 'Brake'); % Left motor backward
        brick.MoveMotorAngleRel('D', 70, 175, 'Brake');  % Right motor forward
        brick.WaitForMotor('A');    % Wait for turn to complete
        brick.WaitForMotor('D');
       
        % Move forward again after turning
        brick.MoveMotor('A', 43.5);
        brick.MoveMotor('D', 50);
        pause(2);                   % Move forward for another second
        brick.StopAllMotors();
    end
end