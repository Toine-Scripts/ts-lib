TS = {}

TS.Version = GetResourceMetadata(GetCurrentResourceName(), 'version') or '1.0.0'

TS.Debug = function(...) TS.DebugPrint(...) end
