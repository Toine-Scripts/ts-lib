# Contributing to TS-Lib

First off, thank you for considering contributing to `ts-lib`! It's people like you that make the FiveM community such a great place to build resources.

### How Can I Contribute?

#### 1. Reporting Bugs
- **Ensure the bug was not already reported** by searching on GitHub under Issues.
- If you're unable to find an open issue addressing the problem, open a new one. Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

#### 2. Suggesting Enhancements
- Open a new issue with the `enhancement` label.
- Provide a clear and detailed explanation of the feature.
- Explain why this enhancement would be useful to most users.

#### 3. Pull Requests
- Fork the repo and create your branch from `main`.
- If you've added code that should be tested, add tests.
- Ensure the test suite passes.
- Make sure your code adheres to standard Lua styling practices.
- Issue that pull request!

### Adding a new Framework/Garage/Keys System
If you are adding a new bridge:
1. Create the relevant folder and file structure in `bridge/`.
2. Ensure you adhere to the standard interface functions used by the existing bridges (e.g. `TS.Bridge.Garage.IsVehicleOutside`).
3. Add the new implementation into `imports.lua` so it can be dynamically loaded if selected in `config.lua`.

---

By contributing, you agree that your contributions will be licensed under its MIT License.
