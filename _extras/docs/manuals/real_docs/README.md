# `real_docs/` — the primary sources

Scans of the actual Soviet/Russian manuals for the Tu-154M and its engines.
Inert, like everything under `_extras/` — nothing loads these.

Read this before citing anything from here: **two of the four engine PDFs are
duplicate scans with swapped filenames**, and the figures the powerplant code
quotes live in a file whose name does not mention them.

## Where the numbers the code cites actually are

Comments in `systems/powerplant/*.lua` cite *"Tu-154M Flight Manual Table 8.1.1
/ 8.1.2 / p.8.1.8"*. That is **РЛЭ Раздел 8.1 «Двигатель и его системы»**, and it
is in this folder at:

```
RUS RLE/Papka_2/Tu-154M_RLE_r8.pdf     <- Книга 2, opens on Раздел 8.1, p.8.1.1-8.1.40
```

| What | Where |
|---|---|
| Engine operating limits (the redlines: N1 95 %, N2 98.5 %, vibration 55 %, oil 0.9 kg/h, start 35-80 s, …) | `r8.pdf`, РЛЭ 8.1.1 limits table, p.8.1.1-8.1.3 |
| Table 8.1.1 — ground regimes, N1/N2/EGT per mode | `r8.pdf`, p.8.1.4 |
| Table 8.1.2 — H=11 km M=0.8 regimes (**including the altitude idle row**) | `r8.pdf`, p.8.1.4 |
| Table 8.1.3 — max EGT vs OAT, takeoff/nominal/0.9 nom/max reverse | `r8.pdf`, p.8.1.5 |
| Start procedure, the 550 °C / 4 s limit, starter cutout at N2 43 (+1/−2) % | `r8.pdf`, РЛЭ 8.1.2, p.8.1.8-8.1.8.1 |

The **English** `Tu-154M Flight Manual Book 1.pdf` in this folder covers only
Sections 1–7 and explicitly defers systems limits to Section 8 (p.2.15:
*"the systems and equipment operational limitations are covered for each system
in section 8"*). An English Book 2 would hold Section 8 — it is **not** in this
repository. Use the Russian `r8.pdf` above.

## RUS RLE — how the nine files map

`Papka_1` is Книга 1 (Sections 1–7), `Papka_2` is Книга 2 (Section 8 onward).
The files are cut roughly one РЛЭ section each, *not* by the binder list printed
inside them (that list describes the full 17-binder paper set, most of which is
not here).

| File | Contains |
|---|---|
| `Papka_1/Tu-154M_RLE_r1.pdf` | Front matter, Книга 1 title, Раздел 1 |
| `Papka_1/Tu-154M_RLE_r2.pdf` | Раздел 2 — общие эксплуатационные ограничения |
| `Papka_1/Tu-154M_RLE_r3…r6.pdf` | Разделы 3–6 |
| `Papka_1/Tu-154M_RLE_r7.pdf` | Раздел 7 — лётные характеристики (performance charts) |
| `Papka_2/Tu-154M_RLE_r8.pdf` | **Книга 2, Раздел 8 — эксплуатация систем** (engine = 8.1) |
| `Papka_2/Tu-154M_RLE_r9.pdf` | Remainder of Книга 2 |

## Engine/ — four files, two documents, two wrong names

All four are the **same** manual: *Двигатель Д-30КУ-154 2-й серии, Руководство
по технической эксплуатации 59-00-800РЭ* (МГА / «Воздушный транспорт», 1992,
amended to 2005/07). There is **no 1st-series data here** — the `ser1`/`ser2` in
the filenames does not denote an engine series.

| File | What it actually is |
|---|---|
| `D-30KU-154-ser2-book1_Printed.pdf` | Книга I — correctly named |
| `D-30KU-154-ser2-book2_Printed.pdf` | Книга II — correctly named |
| `D-30Ku-154-ser1-book1_Printed.pdf` | **Книга II** — duplicate scan, misnamed `book1` |
| `D-30Ku-154-ser1-book2_Printed.pdf` | **Книга I** — duplicate scan, misnamed `book2` |

Book I holds 072.00.00–072.84.01 (engine general data and regimes in
072.00.00 §5, compressor, combustor, turbines, gearboxes, reverser). Book II
holds 073.xx–081.00.00 (fuel control, ignition, indication, starting, and the
oil system at 072.90.00).

## Where the two manuals disagree

Known and deliberate, do not "fix" one to the other:

- **N2 regime floors.** РЛЭ 8.1.1 gives nominal 93.0–95.0 % and takeoff
  94.5–96.0 %; the engine manual (072.00.00 §5.9.1.1) gives 92.5–94.5 % and
  94.0–96.0 %. The plugin follows the РЛЭ — it is what a crew is cleared to fly.
- **Max reverse thrust.** Engine manual §5.9.2: 3400 kgf ±3 % with "straight"
  buckets, 2920 kgf ±3 % with flow-deflecting buckets. A РЛЭ note describes
  stepped-reverse aircraft with deflecting buckets as 3400 kgf. Unresolved;
  scan quality on that passage is poor.

Where they were cross-checked and **agree exactly**: Table 8.1.3 max-EGT-vs-OAT
values, the 550 °C / 4 s start limit, the 1 min continuous-reverse limit, and
the Р МАСЛА oil-pressure warning setpoint of 2.2 +0.45 kgf/cm².
