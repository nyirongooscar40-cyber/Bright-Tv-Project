
SELECT
  -- Keep only one UserID column (choose UserID0 as the main one)
  UserID0 AS UserID,

  -- Keep other useful columns
  Channel2,
  RecordDate2,
  `Duration 2`,

  -- Convert RecordDate2 into proper DATETIME in South Africa Standard Time
  FROM_UTC_TIMESTAMP(RecordDate2, "Africa/Johannesburg") AS RecordDate_SAST

FROM
  `workspace`.`default`.`1774896982744_bright_tv_dataset_1`

-- Remove duplicates based on UserID and RecordDate2
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY UserID0, RecordDate2
  ORDER BY RecordDate2 DESC
) = 1;