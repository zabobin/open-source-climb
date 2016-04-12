uses player_input_handler;

var
    i: byte;
begin
    for i := 1 to 32 do begin
		Players[i].OnCommand := @OnPlayerCommand;
		Players[i].OnSpeak := @OnPlayerSpeak;
    end;
end.
