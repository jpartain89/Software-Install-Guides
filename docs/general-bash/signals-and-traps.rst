=================
Signals and Traps
=================

When writing shell scripts, and you're creating ``tmp`` files or doing anything that needs to or should be cleaned up either after the script is finished or in the event of an error, you should include a "cleanup" function and possibly an "error" function that first calls the "cleanup" function and presents an error code or message.

The main way of doing this is by the ``trap`` function/command. Basically, it "traps" any exit codes/commands/signals presented by the script, by the user or by the system.

Below is the various signal names or number codes you should include in your trap line.

.. csv-table:: Trap Signals
  :header: "No", "Name", "Default Action", "Description"
  :widths: auto
  :align: center
  :file: signals-and-traps_table.csv

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Page reviewed for modernization baseline and footer standardization setup.

Reason for Change
  Standardize per-page change tracking and prepare for phased documentation modernization.

Compatibility Notes
  Not Applicable (administrative documentation footer addition).

Tested On
  Documentation review only.
