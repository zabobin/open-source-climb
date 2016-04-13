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

procedure DisplayStats(Player: TActivePlayer; Nickname: string);
begin
    Player.WriteConsole('Displaying ' + Nickname + '''s stats:', COLOR_GREEN);
    //TODO: Add query to database to retrieve stats.
end;

//TODO: Find a better naming for this function.
function GetInputParameter(Input: string): string;
var
    FirstSpacePosition: integer;
begin
    FirstSpacePosition := Pos(' ', Input);
    Result := Copy(Input, FirstSpacePosition+1, Length(Input)-FirstSpacePosition);
end;

function OnPlayerCommand(Player: TActivePlayer; Command: string): boolean;
var
    SplitCommandArray: TStringList;
begin
    SplitCommandArray := File.CreateStringList;
    SplitRegExpr(REGULAR_EXPRESSION_WHITESPACE, Command, SplitCommandArray);

    case LowerCase(SplitCommandArray.Strings[0]) of
        '/commands', '/cmds', '/command', '/cmd', '/help':
            if SplitCommandArray.Count = 1 then
                DisplayAvailableCommands(Player);

        '/stats':
            if SplitCommandArray.Count = 1 then
                DisplayStats(Player, Player.Name)
            else
                DisplayStats(Player, GetInputParameter(Command));
    end;

    SplitCommandArray.Free;
    Result := false;
end;

procedure OnPlayerSpeak(Player: TActivePlayer; Text: string);
var
    SplitTextArray: TStringList;
begin
    SplitTextArray := File.CreateStringList;
    SplitRegExpr(REGULAR_EXPRESSION_WHITESPACE, Text, SplitTextArray);

    case LowerCase(SplitTextArray.Strings[0]) of
        '!commands', '!cmds', '!command', '!cmd', '!help':
            if SplitTextArray.Count = 1 then
                DisplayAvailableCommands(Player);

        '!stats':
            if SplitTextArray.Count = 1 then
                DisplayStats(Player, Player.Name)
            else
                DisplayStats(Player, GetInputParameter(Text));

        '!police', '!policja':
            if SplitTextArray.Count = 1 then
                Players.WriteConsole('Local police department has been requested.', COLOR_GREEN);
    end;

    SplitTextArray.Free;
end;

end.
