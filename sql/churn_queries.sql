-- 1. Overall Churn Rate
SELECT
	ROUND(AVG(churned) * 100, 2) AS churned_rate_percent
FROM customers;

-- 2. Churn by Subscription Type
SELECT
	subscription_type,
	COUNT(*) AS total_users,
	SUM(churned) AS churned_users,
	ROUND(100 * AVG(churned), 2) AS churn_rate_percent
FROM customers
GROUP BY subscription_type
ORDER BY churn_rate_percent DESC;

-- 3. Behavioral Comparison: Churned vs Not Churned
SELECT
	churned,
	ROUND(AVG(weekly_hours), 2) AS avg_weekly_hours,
	ROUND(AVG(average_session_length), 2) AS avg_session_length,
	ROUND(AVG(song_skip_rate), 2) AS avg_skip_rate,
	ROUND(AVG(num_playlists_created), 2) AS avg_playlists
FROM customers
GROUP BY churned;

-- 4. Subscription Type vs Behavior Breakdown
SELECT 
	subscription_type,
	churned,
	ROUND(AVG(weekly_hours), 2) AS avg_weekly_hours,
	ROUND(AVG(song_skip_rate), 2) AS avg_skip_rate,
	ROUND(AVG(num_playlists_created), 2) AS avg_playlists
FROM customers
GROUP BY subscription_type, churned
ORDER BY subscription_type, churned;

-- 5. High-Risk Users Segment
SELECT 
	customer_id,
	subscription_type,
	weekly_hours,
	song_skip_rate,
	average_session_length,
	num_playlists_created,
	churned
FROM customers
WHERE weekly_hours < 25
  AND song_skip_rate > 0.5
  AND num_playlists_created < 40;

  -- 6. Churn by Payment Plan
SELECT
	payment_plan,
	COUNT(*) AS total_users,
	SUM(churned) AS churned_users,
	ROUND(100 * AVG(churned), 2) AS churn_rate_percent
FROM customers
GROUP BY payment_plan
ORDER BY churn_rate_percent DESC;
