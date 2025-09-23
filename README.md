# Collibra CPSH + AWS Glue (S3) – CPS Events Demo

This repo shows how Collibra CPSH (via Edge) orchestrates **ephemeral AWS Glue crawlers** to inventory CPS event data in S3, ingests the Glue Catalog into Collibra, and publishes a governed, queryable dataset with an Athena saved query (“Rolled Calls – Last 3 Days”).

👉 Start with **docs/aws-setup.md**, then **docs/collibra-setup.md**, and present using **docs/demo-flow.md**.

## What you’ll demonstrate
- Edge creates crawlers from Collibra definitions, crawls S3 prefixes, **creates one Glue database per Collibra domain**, ingests metadata into Catalog, then **deletes the crawlers**.
- Governance: owners/stewards, glossary terms, policy → data relationships, and status **Candidate → Accepted**.
- Consumption: Athena query + saved query link from the Collibra asset.

## Quick links
- **AWS setup** → [docs/aws-setup.md](docs/aws-setup.md)
- **Collibra setup** → [docs/collibra-setup.md](docs/collibra-setup.md)
- **Demo flow (script + SQL)** → [docs/demo-flow.md](docs/demo-flow.md)

## Prereqs
- AWS account with IAM + Glue + S3 access in a single region (e.g., `us-east-1`).
- Collibra DGC + Edge site with internet egress to AWS endpoints.
- A bucket you control (this guide uses `cps-edge-s3-glue-demo`).

## SQL & Policies
- Athena query: [`sql/rolled_calls_last_3_days.sql`](sql/rolled_calls_last_3_days.sql)
- Optional view: [`sql/transport_events_typed_view.sql`](sql/transport_events_typed_view.sql)
- IAM policy for Edge user: [`templates/iam/collibra-edge-glue-policy.json`](templates/iam/collibra-edge-glue-policy.json)
- Glue service role trust: [`templates/iam/glue-crawler-service-role-trust.json`](templates/iam/glue-crawler-service-role-trust.json)

## Cleanup
- Delete the S3 bucket (demo dataset + Athena results).
- Remove Glue databases/tables if you disabled the **“Delete Glue database left after previous synchronization”** capability flag in Edge.
- Deactivate or delete the Edge IAM user and keys.

## License
MIT
