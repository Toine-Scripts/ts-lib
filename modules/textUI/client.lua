if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

TS.Lib.TextUI = {}

TS.Lib.TextUI.Show = function(text, position)
    SendNuiMessage(json.encode({
        module = 'textUI',
        show = true,
        position = position or 'top-left',
        text = text
    }))
end

TS.Lib.TextUI.Hide = function()
    SendNuiMessage(json.encode({
        module = 'textUI',
        show = false
    }))
end

exports('SendTextUI', TS.Lib.TextUI.Show)
exports('HideTextUI', TS.Lib.TextUI.Hide)