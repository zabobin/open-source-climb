unit player_input_handler;

interface
    uses constants;

    function OnPlayerCommand(Player: TActivePlayer; Command: string): boolean;
    procedure OnPlayerSpeak(Player: TActivePlayer; Text: string);

implementation
procedure DisplayAvailableCommands(Player: TActivePlayer);
begin
    Player.WriteConsole('Available commands:', COLOR_GREEN);
    Player.WriteConsole('!top <mapname> => displays top3 on the specified map.', COLOR_GREEN);
    Player.WriteConsole('!stats <nickname> => displays specified user''s stats.', COLOR_GREEN);
    Player.WriteConsole('!police => calls your local police department.', COLOR_GREEN);
end;

function OnPlayerCommand(Player: TActivePlayer; Command: string): boolean;
begin
    case LowerCase(Command) of
        '/commands', '/cmds', '/command', '/cmd', '/help':
            DisplayAvailableCommands(Player);
    end;
    Result := false;
end;

procedure OnPlayerSpeak(Player: TActivePlayer; Text: string);
begin
    case LowerCase(Text) of
        '!commands', '!cmds', '!command', '!cmd', '!help':
            DisplayAvailableCommands(Player);
    end;
end;

end.
