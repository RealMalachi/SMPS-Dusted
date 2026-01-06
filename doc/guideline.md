The SMPS-Dusted Collaborative Guidelines

## Overview
SMPS-Dusted is a spec of a spec, SMPS. SMPS was designed as an everyman sound processor, with a colourful history of alterations for better and worse.
As devs had the source code, they were encouraged to add their own features when the given one was insufficent.
SMPS-Dusted intends to follow suit. While a capable driver on its own, SMPS-Dusted is to be designed with scalability in mind

## General Guidelines
Adaptability:
SMPS-Dusted and related tools should be capable of adding new features and maintaining old features with relative ease.

Game Data Independance:
Nothing should be hard-coded to game specific logic such as absolute addresses and non-driver ram

Community Ownership:
Ideally, this should become a community driven project.
In the event that the founder (Malachi) or any other significant figures depart, SMPS-Dusted should ideally survive without them.

Foreign sound format accomidation (fur, vgm, midi, etc):
The only other format that SMPS-Dusted is SMPS and variants of smps2asm
SMPS-Dusted is, however, encouraged to add additional features for making conversions from foreign formats easier, in the event that SMPS or SMPS-Dusted have no direct (or good) equivalent.
Examples:
- PSG3 and PSG4(noise) in unison
- FM3 multi-channel and CSM modes



