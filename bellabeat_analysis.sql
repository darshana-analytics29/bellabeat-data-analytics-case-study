-- Bellabeat Case Study
-- SQL Analysis

-- 1. Number of unique users
SELECT COUNT(DISTINCT id)
FROM daily_activity;

-- 2. Average daily steps
SELECT ROUND(AVG(total_steps), 2) AS average_daily_steps
FROM daily_activity;

-- 3. Average daily calories
SELECT ROUND(AVG(calories), 2) AS average_daily_calories
FROM daily_activity;

-- 4. Average activity and sedentary minutes
SELECT
    ROUND(AVG(very_active_minutes), 2) AS avg_very_active_minutes,
    ROUND(AVG(fairly_active_minutes), 2) AS avg_fairly_active_minutes,
    ROUND(AVG(lightly_active_minutes), 2) AS avg_lightly_active_minutes,
    ROUND(AVG(sedentary_minutes), 2) AS avg_sedentary_minutes
FROM daily_activity;

-- 5. Weekday vs Weekend activity
SELECT
    CASE
        WHEN EXTRACT(ISODOW FROM activity_date) IN (6, 7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    ROUND(AVG(total_steps), 2) AS average_steps,
    ROUND(AVG(sedentary_minutes), 2) AS average_sedentary_minutes
FROM daily_activity
GROUP BY day_type;

-- 6. Average sleep duration
SELECT
    ROUND(AVG(total_minutes_asleep), 2) AS average_minutes_asleep,
    ROUND(AVG(total_time_in_bed), 2) AS average_time_in_bed
FROM sleep_day;

-- 7. Sleep efficiency
SELECT
    ROUND(
        AVG(total_minutes_asleep * 100.0 /
        NULLIF(total_time_in_bed, 0)), 2
    ) AS average_sleep_efficiency
FROM sleep_day;

-- 8. Activity and sleep relationship
SELECT
    a.id,
    a.activity_date,
    a.total_steps,
    s.total_minutes_asleep,
    s.total_time_in_bed
FROM daily_activity a
JOIN sleep_day s
    ON a.id = s.id
    AND a.activity_date = s.sleep_day;

-- 9. Steps and sleep correlation
SELECT
    ROUND(
        CORR(a.total_steps, s.total_minutes_asleep)::numeric, 2
    ) AS steps_sleep_correlation
FROM daily_activity a
JOIN sleep_day s
    ON a.id = s.id
    AND a.activity_date = s.sleep_day;