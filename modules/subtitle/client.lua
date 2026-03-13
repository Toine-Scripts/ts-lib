if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

TS.Lib.Subtitle = {}

TS.Lib.Subtitle.Show = function(text)
    SendNUIMessage({
        module = 'subtitle',
        show = true,
        text = text
    })
end

TS.Lib.Subtitle.Hide = function()
    SendNUIMessage({
        module = 'subtitle',
        show = false
    })
end

exports('SendSubtitle', TS.Lib.Subtitle.Show)
exports('HideSubtitle', TS.Lib.Subtitle.Hide)

