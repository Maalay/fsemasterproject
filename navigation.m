brick.beep()
brick.MoveMotor('AD', 60)
while true
    distance = brick.UltrasonicDist(1);
    disp(distance);
    if (distance < 20)
        brick.StopMotor('AD', 'Brake');
        brick.MoveMotorAngleRel('AD', 40, 90, 'Brake');
        if (distance < 20)
            brick.MoveMotor('AD', 40, -180, 'Brake');
        end
    end
    if (distance > 20)
        brick.MoveMotor('AD', 100)
    end
end