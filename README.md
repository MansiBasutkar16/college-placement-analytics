# 🎓 College Placement Analytics — SQL Project

A end-to-end SQL analytics project built on simulated placement data from an engineering college.  
Covers schema design, data modeling, and 14 business-focused queries using core and advanced MySQL features.

---

## 📌 Problem Statement

Training & Placement Officers (TPOs) deal with placement data scattered across spreadsheets. This project models that data into a relational database and answers real questions about placement outcomes, salary trends, company behaviour, and student eligibility — the kind of insights that drive smarter placement strategy.

---

## 🗃️ Database Schema

```
departments ──< students ──< placements >── job_roles >── companies
```

| Table         | Description                                              |
|---------------|----------------------------------------------------------|
| `departments` | Engineering branches with seat count                     |
| `students`    | Student profiles — CGPA, batch, backlogs, gender         |
| `companies`   | Recruiting companies with sector and tier classification |
| `job_roles`   | Roles offered — CTC, eligibility criteria, type         |
| `placements`  | Core fact table linking students to offers               |

---

## 📊 Analysis Queries (14 Total)

| # | Query | Concept Used |
|---|-------|-------------|
| 1 | Department-wise placement rate | GROUP BY, LEFT JOIN, aggregation |
| 2 | Avg / Max / Min CTC per department | Multi-table joins, aggregation |
| 3 | Top 5 highest-paying placements | ORDER BY, LIMIT |
| 4 | Company-wise offer count & avg CTC | GROUP BY, aggregation |
| 5 | CGPA bucket vs placement outcome | CASE WHEN, conditional aggregation |
| 6 | Dream offer rate by department | Boolean SUM, percentage calculation |
| 7 | Gender-wise placement breakdown | GROUP BY gender |
| 8 | Sector-wise hiring trends | JOIN across 3 tables |
| 9 | Year-over-year placement comparison | Batch-level aggregation |
| 10 | Backlog impact on placement | CASE WHEN, LEFT JOIN |
| 11 | Unplaced students list | NOT IN subquery |
| 12 | Monthly placement trend (cumulative) | Window function: SUM OVER |
| 13 | Rank students by CTC within dept | Window function: RANK() PARTITION BY |
| 14 | Companies that return every year | GROUP_CONCAT, HAVING |

---

## 🛠️ Tech Stack

- **Database:** MySQL 8.0+
- **Concepts:** DDL, DML, Joins, Subqueries, CASE WHEN, Window Functions, Aggregations

---

## 🚀 How to Run

```bash
# 1. Open MySQL and run schema + data
mysql -u root -p < 01_schema_and_data.sql

# 2. Run analysis queries
mysql -u root -p placement_analytics < 02_analysis_queries.sql
```

Or paste files directly into **MySQL Workbench** and execute.

---

## 💡 Key Insights from the Data

- **AI & DS and CE** branches show the highest dream offer (CTC ≥ 8 LPA) rates
- **CGPA above 8.0** strongly correlates with both placement rate and CTC
- **Students with 2+ backlogs** have significantly lower placement outcomes
- **BFSI and Product** sector companies offer the highest average packages
- **Goldman Sachs and Razorpay** represent the top-paying recruiters on campus

---

## 📁 File Structure

```
college-placement-analytics/
├── 01_schema_and_data.sql    # Table creation + sample data
├── 02_analysis_queries.sql   # 14 analytical queries
└── README.md
```

---

## 🙋 Author

**Mansi Basutkar**  
B.Tech Computer Engineering | Walchand Institute of Technology, Solapur  
[LinkedIn](https://linkedin.com/in/mansibasutkar) | [GitHub](https://github.com/MansiBasutkar16)
