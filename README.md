# Physics-Based Compact Modeling of TiN/La₂NiO₄/Pt Memristive Devices

> **Nouman Ahmad** — M1 Photonics Engineering, Université Jean Monnet  
> Research Internship @ LMGP – Grenoble INP | April – July 2025  
> Supervisors: Dr. Mónica Burriel (LMGP) · Dr. Aleksandra Koroleva (LMGP, TIMA)

---

## Overview

This project develops a **SPICE-level physics-based compact model** for analog memristive devices based on the TiN/La₂NiO₄₊δ/Pt stack. The goal is to accurately simulate the resistive switching behavior of these devices for use in **neuromorphic computing** and **in-memory computation** architectures.

The work is based on the open-source **JART VCM v1b** model (Jülich Aachen Resistive Switching Tool), which is adapted and optimized to match experimental I-V data from the TiN/La₂NiO₄/Pt device.

---

## Motivation

Modern Von Neumann architectures suffer from a fundamental bottleneck: the physical separation of processor and memory leads to massive energy consumption and poor efficiency for AI and machine learning workloads.

**Neuromorphic computing** addresses this by mimicking the brain's architecture — where memory and computation coexist. Memristive devices act as artificial synapses, enabling in-memory computation that is orders of magnitude more energy-efficient.

New non-volatile memory technologies being explored include: **RRAM, FRAM, MRAM, and PCM**.

---

## The Device: TiN/La₂NiO₄₊δ/Pt

The TiN/La₂NiO₄/Pt memristor is a **Valence Change Memory (VCM)** device that exhibits analog, gradual resistive switching — ideal for neuromorphic synaptic weight representation.

| Layer | Role |
|-------|------|
| TiN | Active Electrode (AE) — top |
| TiNₓOᵧ interlayer (Disc) | Active switching region |
| La₂NiO₄₊δ (Plug) | Stable oxide layer |
| Pt | Ohmic Electrode (OE) — bottom |

Switching is driven by **oxygen vacancy migration**: vacancies move between the disc and plug layers under applied voltage, modulating resistance between High Resistance State (HRS) and Low Resistance State (LRS).

---

## The JART VCM v1b Model

The **JART VCM v1b** is an open-source, physics-based SPICE compact model describing bipolar resistive switching via the Valence Change Mechanism.

> Model available at: http://www.emrl.de/JART.html  
> Reference: Bengel et al., *IEEE Transactions on Circuits and Systems I*, 2020.

### Equivalent Circuit

The model represents the device as a series circuit of:
- **R_contact** — TiN/TiNₓOᵧ Schottky contact
- **R_disc** — thin TiNₓOᵧ interlayer (active switching region)
- **R_plug** — stable La₂NiO₄₊δ layer
- **R_series** — line resistance

The **state variable** governing resistance changes is `N_disc` — the oxygen vacancy concentration in the disc layer:

$$\frac{dN_{disc}}{dt} = -\frac{I_{ion}}{z_{V_O} \cdot e \cdot A \cdot l_{var}}$$

---

## Methodology

### Compact Modeling Workflow

```
Step 1               Step 2               Step 3 (iterative)      Step 4           Step 5
Experimental    →   Model Selection  →   Parameter           →   Transfer to  →   Validate in
I-V Analysis        (JART VCM v1b)       Optimization            Verilog-A        SPICE
                                         in MATLAB
```

1. **Experimental Analysis** — Study I-V curves of TiN/La₂NiO₄/Pt, identify key features (gradual SET/RESET, nonlinearity, hysteresis)
2. **Model Selection** — JART VCM v1b selected as a physics-based VCM model
3. **Parameter Optimization** — Iterative MATLAB tuning until simulation matches experimental data
4. **Verilog-A Transfer** — Export optimized model to industry-standard Verilog-A
5. **SPICE Validation** — Import into SPICE simulator for circuit-level design

---

## Parameter Optimization

### Strategy
- Change **one parameter at a time**, keeping all others fixed
- Assess stability using four criteria:

| Criterion | Question |
|-----------|----------|
| Numerical Stability | Does the simulation run without diverging? |
| Experimental Validity | Does the I-V curve match the device? |
| Resistance Behavior | Do disc and Schottky resistances switch correctly between HRS and LRS? |
| Inter-Parameter Consistency | Do parameter values make physical sense together? |

---

## Parameters

### Primary Parameters (Optimized)

| Symbol | Description | Optimized Value | Valid Range |
|--------|-------------|-----------------|-------------|
| `v.a` | Ion hopping distance | 0.38e-9 | 0.15 < v.a < 3.5 |
| `v_0` | Attempt frequency | 2e13 | 2e13 < v_0 < 50e13 |
| `delta_WA` | Activation energy | 0.88 | 0.71 < WA < 0.99 |
| `phi_bn0` | Schottky barrier | 0.39 | 0.1 < phi < 0.39 |
| `mu_n` | Electron mobility | 5e-6 | 1e-6 < mu_n < 1e-1 |
| `R_TiOx` | Series resistance | 590 Ω | 100 < R < 1500 |
| `R_0` | Contact line resistance | 67 Ω | 10 < R_0 < 250 |
| `R_th_eff_SET` | Thermal resistance (SET) | 1.5e4 | 1e3 < R < 5e5 |
| `R_th_eff_RESET` | Thermal resistance (RESET) | 5e4 | 1e4 < R < 50e4 |
| `v.N_min` | Min vacancy concentration in disc | 1e24 | 1e24 < N < 4e24 |
| `v.N_max` | Max vacancy concentration in disc | 5e26 | 4e25 < N < 6e27 |
| `v.N_plug_init` | Initial plug concentration | 2e26 | constant |
| `v.N_disc_init` | Initial disc concentration | 4e24 | 7e23 < N < 3e25 |
| `v.beta` | Limiting factor | 10 | 1 < beta < 30 |
| `v.T_0` | Ambient temperature | 293 K | constant |

### Fixed Geometric Parameters

| Symbol | Description | Value |
|--------|-------------|-------|
| `v.r_fil` | Filament radius | 200e-9 m |
| `v.l_disc` | Disc thickness | 3e-9 m |
| `v.l_plug` | Plug length | 30e-9 m |

---

## Key Results

After iterative optimization of all 15 primary parameters, the simulated I-V curve converges toward the experimental TiN/La₂NiO₄/Pt data:

- ✅ Correct hysteresis loop shape (SET and RESET)
- ✅ Disc and Schottky resistance switch cleanly between HRS and LRS
- ✅ Numerical stability across all temperature conditions (295 K – 415 K)
- ✅ Inter-parameter consistency validated

---

## Repository Structure

```
memristor-compact-model/
│
├── README.md
│
├── matlab/
│   ├── main_simulation.m          # Top-level simulation script
│   ├── parameter_optimization.m   # Iterative parameter tuning loop
│   ├── plot_iv_curves.m           # I-V curve comparison plots
│   ├── plot_resistance.m          # Disc & Schottky resistance vs time
│   └── m-files/
│       ├── calc_I_ion_drift.m     # Ionic current calculation (Mott-Gurney)
│       └── search_implicit.m      # Implicit solver for disc/plug resistance
│
├── verilog-a/
│   └── jart_vcm_La2NiO4.vams     # Optimized Verilog-A model (future step)
│
├── data/
│   └── experimental_IV.mat        # Experimental I-V reference data
│
├── results/
│   └── README.md                  # Description of generated output plots
│
├── docs/
│   └── presentation.pdf           # Full internship presentation
│
└── references/
    └── Bengel2020_JART_VCM.pdf    # Key reference paper
```

---

## Tools & Environment

| Tool | Purpose |
|------|---------|
| MATLAB | Parameter optimization, simulation, plotting |
| JART VCM v1b | Open-source base compact model |
| Verilog-A | Industry-standard model transfer format *(next step)* |
| SPICE | Circuit-level validation *(next step)* |

---

## Background: Key Physics

### Ionic Current (Mott-Gurney Model)
The ionic current driving oxygen vacancy migration is:

$$I_{ion} = z_{V_O} \cdot e \cdot A \cdot c_{V_O} \cdot a \cdot \nu_0 \cdot F_{limit} \cdot \left[\exp\left(-\frac{\Delta W_{A,min}}{k_B T}\right) - \exp\left(-\frac{\Delta W_{A,max}}{k_B T}\right)\right]$$

### Disc/Plug Resistance
$$R_{plug/disc} = \frac{l_{plug/var}}{z_{V_O} \cdot e \cdot A \cdot N_{plug/disc} \cdot \mu_n}$$

---

## References

- Bengel et al., *"Variability-Aware Modeling of Filamentary Oxide-Based Bipolar Resistive Switching Cells Using SPICE Level Compact Models"*, IEEE Transactions on Circuits and Systems I, pp. 1–13, 2020.
- JART VCM v1b open-source model: http://www.emrl.de/JART.html

---

## Author

**Nouman Ahmad**  
M1 Photonics Engineering — Université Jean Monnet, Saint-Étienne  
Research Intern — LMGP, Grenoble INP  
[linkedin.com/in/nouman001ahmad](https://linkedin.com/in/nouman001ahmad)
