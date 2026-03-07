<div align="center">
    <h1>TS-Lib</h1>
    <p>A comprehensive, universal utility wrapper and bridge library for FiveM.</p>
</div>

## 📌 Overview

**TS-Lib** is designed to eliminate the headache of supporting multiple frameworks, inventories, garage systems, and key management scripts. Instead of cluttering your resources with endless `if/else` checks, `ts-lib` handles it all under one unified `TS` namespace. 

It is designed to be injected dynamically into any script, keeping your resource code clean, fast, and completely independent.

---

## 🚀 Features

- **Automated Framework Detection**: Natively supports `qb-core`, `qbx_core`, `es_extended`, and `standalone`. It prioritizes the most modern framework available automatically or via forced config.
- **`ox_lib` Wrapper**: `ts-lib` acts as a complete proxy wrapper for `ox_lib`. Your scripts rely entirely on `TS.Lib` instead of directly calling `ox_lib`. If `ox_lib` isn't declared in your script's `fxmanifest`, `ts-lib` injects it dynamically.
- **Unified Bridges**:
  - **Garages**: Native support for `qb-garages`, `esx_garage`, `vms_garagesv2`, `jg-advancedgarages`, and `standalone`.
  - **Keys**: Native support for `qb-vehiclekeys`, `qs-vehiclekeys`, and `standalone`.
- **Centralized Utils**: Prints, debugs, and resource checks are completely centralized (`TS.Print`, `TS.DebugPrint`, `TS.ErrorPrint`).

---

## 🛠️ Installation

Integrating `ts-lib` into your own scripts is incredibly simple. 

1. Place the `ts-lib` folder in your `resources` directory.
2. In the `fxmanifest.lua` of the script that needs to use `ts-lib`, add this single line to your `shared_scripts`:

```lua
shared_scripts {
    '@ts-lib/imports.lua',
    -- Your other shared scripts...
}
```

That's it! `ts-lib` will automatically boot up, detect the server's framework, fetch the configurations, expose the `TS` namespace, and dynamically load the required modules.

---

## ⚙️ Configuration

You can configure exactly which systems `ts-lib` uses via `ts-lib/shared/config.lua`.

```lua
TS.Config = {
    debug = false,
    
    -- Supported: 'auto', 'qb-core', 'qbx_core', 'es_extended', 'standalone'
    Framework = 'auto', 
    
    -- Supported: 'qb-garages', 'esx_garage', 'vms_garagesv2', 'jg-advancedgarages', 'standalone'
    Garage = 'qb-garages', 
    
    -- Supported: 'qb-vehiclekeys', 'qs-vehiclekeys', 'standalone'
    KeysSystem = 'qb-vehiclekeys', 
}
```

## 📖 Documentation

For full instructions, usage, and a detailed API reference, please view the [Official TS-Lib Documentation](https://docs.toine.me/scripts/ts-lib).

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

## 💬 Support

If you need help or want to check out higher-end scripts, join the discord:  
[store.toine.me/discord](https://store.toine.me/discord)
