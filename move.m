while true
    % Move forward
    brick.MoveMotor('A', 34);
    brick.MoveMotor('D', 40);
   
    % Read the color sensor value
    color = brick.ColorCode(2);  % Assuming the color sensor is connected to port 2

    if color == 5  % Red color code
        % Stop for one second when red is detected
        brick.StopAllMotors();
        pause(1);
        brick.MoveMotor('A', 34);
        brick.MoveMotor('D', 40);
        pause(5)
       
    elseif color == 2  % Blue color code
        % Stop and beep two times when blue is detected
        brick.StopAllMotors();
        for i = 1:2
            brick.beep();
            pause(0.5);  % Short pause between beeps
        end
        pause(1);  % Pause to complete response time
        brick.MoveMotor('A', 34);
        brick.MoveMotor('D', 40);
        pause(5)
       
    elseif color == 3  % Green color code
        % Stop and beep three times when green is detected
        brick.StopAllMotors();
        for i = 1:3
            brick.beep();
            pause(0.5);  % Short pause between beeps
        end
        pause(1);  % Pause to complete response time
        brick.MoveMotor('A', 34);
        brick.MoveMotor('D', 40);
        pause(5)

    elseif color == 4  % Yellow color code
        % Stop and beep four times when yellow is detected
        brick.StopAllMotors();
        for i = 1:4
            brick.beep();
            pause(0.5);  % Short pause between beeps
        end
        pause(1);  % Pause to complete response time
        brick.MoveMotor('A', 34);
        brick.MoveMotor('D', 40);
        pause(5)
    end
end