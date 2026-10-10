# AI Trust Analysis: Do Developers Distrust AI, or Just Not Use It?

A Python, SQL and Power BI analysis of the **Stack Overflow Annual Developer Survey 2025** (49,191 respondents; 33,260 answered the AI questions).

The headline everywhere is that developers don't trust AI. This project asks a sharper question: **is that distrust about the technology, or about how much people have actually used it?**

![Dashboard](AI%20Analysis%20dashboard.jpg)

## Recommendation

Only 33% of developers trust AI accuracy and 46% actively distrust it, which matches the reporting. But distrust is not evenly spread. It tracks hands-on exposure: developers who use AI daily trust it at 49%, while those who never use it trust it at 4%, a twelve-fold gap. Seniority barely matters by comparison, with only a three-point spread from junior to veteran.

The working problem is sharper still. Even among developers who describe themselves as favourable towards AI, 32% actively distrust its output. People are using tools daily that they feel obliged to double-check.

**The fix for AI distrust is not better tools. It is structured exposure.** But there is a trade-off worth naming: the heaviest users trust the output most *and* are the most worried about their jobs (17.5% versus 9.8% of non-users).

## Key findings

| Question | Finding |
|---|---|
| Overall trust in AI accuracy | 32.8% trust, 45.7% distrust |
| Does trust track usage? | Yes. Daily users 49.4%, never-users 4.0% |
| Are senior developers the sceptics? | Barely. 34.1% (early career) to 30.7% (20+ years) |
| Do people who like AI trust its output? | No. 32.4% of "favourable" developers actively distrust it |
| Who fears for their job? | Daily users most (17.5%) versus never-users (9.8%) |
| Does trust vary by country? | Substantially. India reports the highest trust and Germany the lowest, a spread of more than thirty percentage points. Australia sits towards the sceptical end. |

## Method

1. **Python (pandas)** cleaned the raw 137 MB, 172-column survey file: dropped 15,931 rows with no AI responses, kept nine relevant columns, shortened long survey labels, built experience bands, and removed implausible salary values. Output: an analysis-ready 12-column dataset of 33,260 responses.
2. **PostgreSQL** loaded the clean data with `TRUNCATE` and `COPY`, then ran five aggregate queries building the argument from the baseline rate through to the usage interaction.
3. **Power BI** presents the findings as an interactive dashboard, sliceable by experience band, organisation size, country and developer role.

## The dashboard

Fully interactive. The slicers filter every visual at once, so the findings can be explored for any experience level, role, country or company size.

It contains:

- **KPI cards** for total respondents, trust rate and distrust rate
- **Trust, distrust and perceived job risk by AI usage frequency**, the central finding, with all three measures side by side
- **A filled map and ranked table of trust by country.** The map shows the geographic pattern; the table carries the figures
- **Trust in AI accuracy by attitude towards AI**, showing the gap between liking AI and trusting its output
- **A matrix of trust by experience band and usage frequency**, showing that trust collapses horizontally (across usage) but holds steady vertically (across seniority)

## Repository contents

- `ai_survey.py.ipynb` is the Python cleaning pipeline
- `ai_trust_clean.csv` is the cleaned dataset the SQL runs against
- `AI Trust analysis.sql` holds the analysis queries, commented
- `AI Analysis dashboard.jpg` is the Power BI dashboard
- `AI_User Analysis.pbix` is the Power BI file
- `README.md` is this file

## Tools

Python (pandas) · PostgreSQL · Power BI

## Notes on method and limitations

**Optional questions.** The AI questions were optional, so the analysis covers the 33,260 respondents who answered them rather than all 49,191.

**Missing experience values.** About 2,500 respondents gave no professional-experience figure, and 60% of them were students, for whom the question does not apply. They were checked before exclusion, their trust rate being within one point of everyone else's, and were excluded only from the experience breakdown, not from any other figure.

**A rejected finding.** Salary initially appeared to predict trust: developers earning under $40k trusted AI at 41%, compared with 28% for those over $70k. This did not survive a within-country check. Inside the United States the relationship was flat, and in Germany it reversed. The pattern reflected the geographic distribution of salaries rather than any effect of pay, since lower salaries cluster in countries that happen to report higher trust. It was excluded from the analysis.

**Country figures.** Limited to the twelve countries with the largest response counts, so that rates are not computed on small samples.

**Self-reported data.** Trust, attitude and job-risk perception are all self-reported survey responses, not measured outcomes.

Every figure is reproducible by running the cleaning notebook against the raw survey file and then the queries in the SQL file.
