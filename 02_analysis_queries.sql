-- ============================================================
--  COLLEGE PLACEMENT ANALYTICS — ANALYSIS QUERIES
--  MySQL
-- ============================================================

USE placement_analytics;

-- ────────────────────────────────────────────────────────────
-- Q1. Overall placement rate by department (batch 2024)
-- ────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    COUNT(DISTINCT s.student_id)                          AS total_students,
    COUNT(DISTINCT p.student_id)                          AS placed_students,
    ROUND(COUNT(DISTINCT p.student_id) * 100.0
          / COUNT(DISTINCT s.student_id), 2)              AS placement_pct
FROM departments d
JOIN students s ON s.dept_id = d.dept_id AND s.batch_year = 2024
LEFT JOIN placements p ON p.student_id = s.student_id
GROUP BY d.dept_name
ORDER BY placement_pct DESC;


-- ────────────────────────────────────────────────────────────
-- Q2. Average, highest & lowest CTC offered per department
-- ────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    ROUND(AVG(jr.ctc_lpa), 2)   AS avg_ctc_lpa,
    MAX(jr.ctc_lpa)             AS highest_ctc_lpa,
    MIN(jr.ctc_lpa)             AS lowest_ctc_lpa,
    COUNT(p.placement_id)       AS total_offers
FROM placements p
JOIN students s   ON s.student_id = p.student_id
JOIN departments d ON d.dept_id   = s.dept_id
JOIN job_roles jr  ON jr.role_id  = p.role_id
GROUP BY d.dept_name
ORDER BY avg_ctc_lpa DESC;


-- ────────────────────────────────────────────────────────────
-- Q3. Top 5 highest-paying placements (with student details)
-- ────────────────────────────────────────────────────────────
SELECT
    s.name            AS student_name,
    d.dept_name,
    c.company_name,
    jr.role_title,
    jr.ctc_lpa,
    p.placement_round
FROM placements p
JOIN students s    ON s.student_id  = p.student_id
JOIN departments d ON d.dept_id     = s.dept_id
JOIN job_roles jr  ON jr.role_id    = p.role_id
JOIN companies c   ON c.company_id  = jr.company_id
ORDER BY jr.ctc_lpa DESC
LIMIT 5;


-- ────────────────────────────────────────────────────────────
-- Q4. Company-wise offer count & avg CTC (which companies hire most)
-- ────────────────────────────────────────────────────────────
SELECT
    c.company_name,
    c.sector,
    c.tier,
    COUNT(p.placement_id)       AS offers_made,
    ROUND(AVG(jr.ctc_lpa), 2)   AS avg_ctc_lpa
FROM placements p
JOIN job_roles jr ON jr.role_id   = p.role_id
JOIN companies c  ON c.company_id = jr.company_id
GROUP BY c.company_name, c.sector, c.tier
ORDER BY offers_made DESC;


-- ────────────────────────────────────────────────────────────
-- Q5. CGPA vs placement outcome — does CGPA actually matter?
-- ────────────────────────────────────────────────────────────
SELECT
    CASE
        WHEN s.cgpa >= 9.0 THEN '9.0+'
        WHEN s.cgpa >= 8.0 THEN '8.0–8.9'
        WHEN s.cgpa >= 7.0 THEN '7.0–7.9'
        ELSE                    'Below 7.0'
    END                                                   AS cgpa_bucket,
    COUNT(DISTINCT s.student_id)                          AS total_students,
    COUNT(DISTINCT p.student_id)                          AS placed,
    ROUND(COUNT(DISTINCT p.student_id) * 100.0
          / COUNT(DISTINCT s.student_id), 2)              AS placement_pct,
    ROUND(AVG(jr.ctc_lpa), 2)                            AS avg_ctc_lpa
FROM students s
LEFT JOIN placements p ON p.student_id = s.student_id
LEFT JOIN job_roles jr ON jr.role_id   = p.role_id
GROUP BY cgpa_bucket
ORDER BY avg_ctc_lpa DESC;


-- ────────────────────────────────────────────────────────────
-- Q6. Dream offer (CTC >= 8 LPA) rate by department
-- ────────────────────────────────────────────────────────────
SELECT
    d.dept_name,
    COUNT(DISTINCT s.student_id)                                    AS total_students,
    SUM(p.is_dream_offer)                                           AS dream_offers,
    ROUND(SUM(p.is_dream_offer) * 100.0
          / COUNT(DISTINCT s.student_id), 2)                        AS dream_offer_pct
FROM students s
JOIN departments d  ON d.dept_id    = s.dept_id
LEFT JOIN placements p ON p.student_id = s.student_id
GROUP BY d.dept_name
ORDER BY dream_offer_pct DESC;


-- ────────────────────────────────────────────────────────────
-- Q7. Gender-wise placement breakdown
-- ────────────────────────────────────────────────────────────
SELECT
    s.gender,
    COUNT(DISTINCT s.student_id)                          AS total_students,
    COUNT(DISTINCT p.student_id)                          AS placed,
    ROUND(COUNT(DISTINCT p.student_id) * 100.0
          / COUNT(DISTINCT s.student_id), 2)              AS placement_pct,
    ROUND(AVG(jr.ctc_lpa), 2)                            AS avg_ctc_lpa
FROM students s
LEFT JOIN placements p ON p.student_id = s.student_id
LEFT JOIN job_roles jr ON jr.role_id   = p.role_id
GROUP BY s.gender;


-- ────────────────────────────────────────────────────────────
-- Q8. Sector-wise hiring trends
-- ────────────────────────────────────────────────────────────
SELECT
    c.sector,
    COUNT(p.placement_id)       AS total_hires,
    ROUND(AVG(jr.ctc_lpa), 2)   AS avg_ctc_lpa,
    MAX(jr.ctc_lpa)             AS max_ctc_lpa
FROM placements p
JOIN job_roles jr ON jr.role_id   = p.role_id
JOIN companies c  ON c.company_id = jr.company_id
GROUP BY c.sector
ORDER BY total_hires DESC;


-- ────────────────────────────────────────────────────────────
-- Q9. Year-over-year placement comparison (2023 vs 2024)
-- ────────────────────────────────────────────────────────────
SELECT
    s.batch_year,
    COUNT(DISTINCT s.student_id)                          AS total_students,
    COUNT(DISTINCT p.student_id)                          AS placed_students,
    ROUND(COUNT(DISTINCT p.student_id) * 100.0
          / COUNT(DISTINCT s.student_id), 2)              AS placement_pct,
    ROUND(AVG(jr.ctc_lpa), 2)                            AS avg_ctc_lpa
FROM students s
LEFT JOIN placements p ON p.student_id = s.student_id
LEFT JOIN job_roles jr ON jr.role_id   = p.role_id
GROUP BY s.batch_year
ORDER BY s.batch_year;


-- ────────────────────────────────────────────────────────────
-- Q10. Students with backlogs — placement impact analysis
-- ────────────────────────────────────────────────────────────
SELECT
    CASE
        WHEN s.backlogs = 0 THEN 'No Backlogs'
        WHEN s.backlogs = 1 THEN '1 Backlog'
        ELSE '2+ Backlogs'
    END                                                   AS backlog_category,
    COUNT(DISTINCT s.student_id)                          AS total_students,
    COUNT(DISTINCT p.student_id)                          AS placed,
    ROUND(COUNT(DISTINCT p.student_id) * 100.0
          / COUNT(DISTINCT s.student_id), 2)              AS placement_pct
FROM students s
LEFT JOIN placements p ON p.student_id = s.student_id
GROUP BY backlog_category
ORDER BY placement_pct DESC;


-- ────────────────────────────────────────────────────────────
-- Q11. Unplaced students list (for TPO follow-up)
-- ────────────────────────────────────────────────────────────
SELECT
    s.student_id,
    s.name,
    d.dept_name,
    s.batch_year,
    s.cgpa,
    s.backlogs
FROM students s
JOIN departments d ON d.dept_id = s.dept_id
WHERE s.student_id NOT IN (SELECT DISTINCT student_id FROM placements)
ORDER BY s.cgpa DESC;


-- ────────────────────────────────────────────────────────────
-- Q12. Running placement count per month (placement season trend)
--      Uses window function — shows momentum during drive season
-- ────────────────────────────────────────────────────────────
SELECT
    DATE_FORMAT(p.offer_date, '%Y-%m')          AS offer_month,
    COUNT(p.placement_id)                        AS offers_this_month,
    SUM(COUNT(p.placement_id))
        OVER (ORDER BY DATE_FORMAT(p.offer_date, '%Y-%m')) AS cumulative_offers
FROM placements p
GROUP BY offer_month
ORDER BY offer_month;


-- ────────────────────────────────────────────────────────────
-- Q13. Rank students within each department by CTC (window fn)
-- ────────────────────────────────────────────────────────────
SELECT
    s.name,
    d.dept_name,
    jr.ctc_lpa,
    c.company_name,
    RANK() OVER (PARTITION BY d.dept_name ORDER BY jr.ctc_lpa DESC) AS dept_rank
FROM placements p
JOIN students s    ON s.student_id  = p.student_id
JOIN departments d ON d.dept_id     = s.dept_id
JOIN job_roles jr  ON jr.role_id    = p.role_id
JOIN companies c   ON c.company_id  = jr.company_id
ORDER BY d.dept_name, dept_rank;


-- ────────────────────────────────────────────────────────────
-- Q14. Companies that return every year (consistency check)
-- ────────────────────────────────────────────────────────────
SELECT
    c.company_name,
    COUNT(DISTINCT YEAR(p.offer_date)) AS years_visited,
    GROUP_CONCAT(DISTINCT YEAR(p.offer_date) ORDER BY YEAR(p.offer_date)) AS year_list
FROM placements p
JOIN job_roles jr ON jr.role_id   = p.role_id
JOIN companies c  ON c.company_id = jr.company_id
GROUP BY c.company_name
HAVING years_visited > 1
ORDER BY years_visited DESC;
