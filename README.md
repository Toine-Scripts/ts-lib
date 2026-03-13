<div align="center">
    <h1>TS-Lib</h1>
    <p>A comprehensive, universal utility wrapper and bridge library for FiveM.</p>
</div>

## 📌 Overview

**TS-Lib** is designed to eliminate the headache of supporting multiple frameworks, inventories, garage systems, and key management scripts. Instead of cluttering your resources with endless `if/else` checks, `ts-lib` handles it all under one unified `TS` namespace.  

It is designed to be injected dynamically into any script, keeping your resource code clean, fast, and completely independent.

---

## 📥 Download

**[Download the Latest Version](https://store.toine.me/download/ts-lib)**

Contributions are welcome — see the docs if you want to propose new bridges or improvements.

---

## 🚀 Features

- **Automated Framework Detection**: Natively supports `qb-core`, `qbx_core`, `es_extended`, and `standalone`. It prioritizes the most modern framework available automatically or via forced config.
- **Unified Bridges**:
  - **Garages**: Native support for `qb-garages`, `esx_garage`, `vms_garagesv2`, `jg-advancedgarages`, and `standalone`.
  - **Keys**: Native support for `qb-vehiclekeys`, `qs-vehiclekeys`, and `standalone`.
- **Centralized Utils**: Prints, debugs, and resource checks are completely centralized (`TS.Print`, `TS.DebugPrint`, `TS.ErrorPrint`).
- **Built-in UI helpers**: Simple NUI-based subtitle and text UI helpers (`TS.Lib.Subtitle`, `TS.Lib.TextUI`) that can also be called via exports.

---

## 🛠️ Installation

Integrating `ts-lib` into your own scripts is incredibly simple.

1. Place the `ts-lib` folder in your `resources` directory.
2. In the `fxmanifest.lua` of the script that needs to use `ts-lib`, add this single line to your `shared_scripts`:

```lua
shared_scripts {
    '@ts-lib/import.lua',
    -- Your other shared scripts...
}
```

That's it! `ts-lib` will automatically boot up, detect the server's framework, fetch the configurations, expose the `TS` namespace, and dynamically load the required modules.

---

## ⚙️ Configuration

You can configure exactly which systems `ts-lib` uses via `ts-lib/config.lua`.

```lua
Config = {
    debug = true,

    -- Framework selection: 'auto', 'qbcore', 'esx', 'qbox', 'standalone'
    Framework = 'auto',

    -- Garage system: 'auto', 'qb-garages', 'esx_garage', 'vms_garagesv2', 'jg-advancedgarages', 'standalone'
    Garages = 'auto',

    -- Vehicle keys system: 'auto', 'qb-vehiclekeys', 'qs-vehiclekeys', 'standalone'
    VehicleKeys = 'auto',

    Data = {
        Framework = {
            qbcore = 'qb-core',
            esx = 'es_extended',
            qbox = 'qbx_core',
            standalone = 'standalone',
        },
        Garages = {
            ['qb-garages']        = 'qb-garages',
            ['esx_garage']        = 'esx_garage',
            ['vms_garagesv2']     = 'vms_garagesv2',
            ['jg-advancedgarages']= 'jg-advancedgarages',
            ['standalone']        = 'standalone',
        },
        VehicleKeys = {
            ['qb-vehiclekeys'] = 'qb-vehiclekeys',
            ['qs-vehiclekeys'] = 'qs-vehiclekeys',
            ['standalone']     = 'standalone',
        },
    },
}
```

---

## 📖 Documentation

For full instructions, usage examples (including UI helpers), and a detailed API reference, see the **official TS-Lib documentation**:  
https://docs.toine.me/scripts/ts-lib

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

## 💬 Support

If you need help or want to check out higher-end scripts, join the discord:  
[store.toine.me/discord](https://store.toine.me/discord)
