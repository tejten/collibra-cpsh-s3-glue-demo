---
title: Collibra CPSH + AWS Glue (S3) — CPS Events Demo
layout: default
---

# Collibra CPSH + AWS Glue (S3) — DCSA Events Demo

This site walks you through a short, repeatable demo where **Collibra CPSH (via Edge)** orchestrates **ephemeral AWS Glue crawlers** to catalog CPS Shipment/Transport/Equipment events from **Amazon S3**, ingests results to **Collibra Catalog**, and publishes a governed, queryable dataset with an **Athena saved query**.

**Start here →** [AWS setup](aws-setup.md) • [Collibra setup](collibra-setup.md) • [Demo flow](demo-flow.md)

---

## What you’ll show
- Edge creates & later deletes Glue crawlers; one **Glue DB per domain** (Shipment/Transport/Equipment).
- Catalog assets with **owners/stewards**, **glossary terms**, **policy-to-data** relations, and **Accepted** status.
- One-click consumption via **Athena saved query** (“Rolled Calls – Last 3 Days”).

## Repo pointers
- **IAM policies**: `templates/iam/`
- **Athena SQL**: `sql/rolled_calls_last_3_days.sql`, `sql/transport_events_typed_view.sql`
- **Main README**: project overview and cleanup notes.

---

## How to use this site
1. Complete **[AWS setup](aws-setup.md)**.
2. Complete **[Collibra setup](collibra-setup.md)**.
3. Run the **[Demo flow](demo-flow.md)** script in 7 minutes.

