# Ansible Standardisation

## Motivation

Ansible projects can become very complex and difficult to manage.
To improve how we work with Ansible and to make transferring from one project to another easier, we should keep all
foundations of each project the same.

**We need standardisation**

This project is our effort to standardise how we work with Ansible and will continue to evolve over time but the core
rules will not change wildly.

## Goal

The goal is to establish a single standard approach to Ansible projects
*   Clearly documented
*   Hopefully something that we might be able to enforce with automated QA, at least to some extent
*   Protects as much as possible against gotchas and pitfalls
*   Optimise for security and performance but above all it is optimised for legibility and clarity

## Contents

It is recommended that the following pages are read in the order below.

* [Structure](./Standards/Structure.md)
* [Variables](./Standards/Variables.md)
* [Plays and Plabybooks](./Standards/Plays.md)
* [Vault](./Standards/Vault.md)
* [Roles and Dependencies](./Standards/Roles.md)
* [Environment Management](./Standards/Environment.md)
* [Quality Assurance and Continuous Integration](./Standards/QA-CI.md)
