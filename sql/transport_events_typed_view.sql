CREATE OR REPLACE VIEW "<transport_db>".transport_events_typed AS
SELECT
  carriervoyagenumber,
  vesselimonumber,
  json_extract_scalar(CAST(location AS JSON),'$.UNLocationCode') AS unloc,
  try(from_iso8601_timestamp(regexp_replace(eventdatetime, 'Z?$', 'Z'))) AS event_ts,
  transporteventtypecode
FROM "<transport_db>".transport_events;
