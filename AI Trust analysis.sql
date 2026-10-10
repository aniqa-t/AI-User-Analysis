TRUNCATE ai_survey;
COPY ai_survey FROM 'D:\AI Project\ai_trust_clean.csv' DELIMITER ',' CSV HEADER;
SELECT COUNT(*) FROM ai_survey;

-- Query 1: Overall trust in AI accuracy 
SELECT
  COUNT(*) AS total_respondents,
  ROUND(100.0 * AVG(trusts_ai), 1) AS trust_pct,
  ROUND(100.0 * AVG(distrusts_ai), 1) AS distrust_pct
FROM ai_survey;

-- Query 2: Does trust track how often people actually use AI? 
SELECT
  ai_usage,
  COUNT(*) AS respondents,
  ROUND(100.0 * AVG(trusts_ai), 1) AS trust_pct,
  ROUND(100.0 * AVG(distrusts_ai), 1) AS distrust_pct
FROM ai_survey
GROUP BY ai_usage
ORDER BY ai_usage;

-- Query 3:Testing the popular claim that senior developers are the AI sceptics
SELECT
  experience_band,
  COUNT(*) AS respondents,
  ROUND(100.0 * AVG(trusts_ai), 1) AS trust_pct
FROM ai_survey
WHERE experience_band IS NOT NULL
GROUP BY experience_band
ORDER BY experience_band;

-- Query 4: Do people who FEEL positive about AI actually trust what it produces?
SELECT
  ai_sentiment,
  COUNT(*) AS respondents,
  ROUND(100.0 * AVG(trusts_ai), 1) AS trust_pct,
  ROUND(100.0 * AVG(distrusts_ai), 1) AS distrust_pct
FROM ai_survey
WHERE ai_sentiment IS NOT NULL
GROUP BY ai_sentiment
ORDER BY trust_pct DESC;

-- Query 5: Does hands-on exposure reduce or increase job anxiety?
SELECT
  ai_usage,
  COUNT(*) AS respondents,
  ROUND(100.0 * AVG(CASE WHEN ai_job_threat = 'Yes' THEN 1 ELSE 0 END), 1) AS sees_threat_pct
FROM ai_survey
WHERE ai_job_threat IS NOT NULL
GROUP BY ai_usage
ORDER BY ai_usage;

