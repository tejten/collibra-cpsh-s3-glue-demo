# Demo Flow (script + queries)

## Storyline (~7 minutes)
- *Findable*: search for “equipment events” and open the **equipment_events** table.
![CPSH Glue Demo](./images/table-view.png)
- *Trust*: show **Owner/Steward**, **Accepted** status, and **Policy → Is governed by** relation.
![CPSH Glue Demo](./images/responsibilities.png)
![CPSH Glue Demo](./images/policy.png)
- *Lineage*: Assets → equipment_events (File Group asset type) → Diagram
![CPSH Glue Demo](./images/lineage.png)
- *Meaning*: open `equipmenteventtypecode` and show **GTIN/GTOT** glossary relations.
![CPSH Glue Demo](./images/business-terms.png)
- *Actionable*: click **Open in Athena (Saved Query)** to run **Rolled Calls – Last 3 Days**.
![CPSH Glue Demo](./images/athena.png)

## Athena: Rolled Calls – Last 3 Days
Use the universal version that works whether `location` is a ROW or a JSON string:

```sql
WITH t AS (
  SELECT
      carriervoyagenumber,
      vesselimonumber,
      json_extract_scalar(CAST(location AS JSON), '$.UNLocationCode') AS unloc,
      try(from_iso8601_timestamp(regexp_replace(eventdatetime, 'Z?$', 'Z'))) AS event_ts
  FROM "<transport_db>".transport_events
  WHERE transporteventtypecode = 'ROLL'
)
SELECT carriervoyagenumber, vesselimonumber, unloc,
       COUNT(*) AS rolled_count, MAX(event_ts) AS last_roll_event
FROM t
WHERE event_ts >= date_add('day', -3, current_timestamp)
GROUP BY 1,2,3
ORDER BY rolled_count DESC, last_roll_event DESC;
```
## Business value:

| Outcome                              | Without Collibra                                                                 | With Collibra                                                                                                                                               |
|--------------------------------------|----------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Find the right event stream** (Shipment/Transport/Equipment) | S3/Glue tables by cryptic names; who owns them?                                   | Search by business term (“Rolled”, “UN/LOCODE”, “Gate in”), see **certified datasets** and owners.                                                           |
| **Trust & compliance**               | “Is this the official feed?” “Can I use it externally?”                           | **Domain ownership, policies, status** (Candidate → Accepted), and **data contracts** visible.                                                              |
| **Speed to insight**                 | Analysts ping SMEs; duplicate SQL; time lost reconciling definitions.             | **One catalog** across S3/Glue (and beyond), **lineage** to source, **saved queries** to start fast.                                                        |
| **Risk reduction**                   | Untracked copies, unclear use rights, no deprecation path.                        | **Stewardship, usage guidance, retention/deprecation workflows, access requests.**                                                                          |
| **Scale beyond AWS**                 | Every platform has its own catalog; no single pane.                               | **Cross-platform catalog + glossary** (Snowflake, Databricks, Redshift, etc.) with one language and policy set.                                             |

AWS Glue tells us what we have. Collibra tells us what we should use, who owns it, and why we can trust it, then gets people there in one click.
