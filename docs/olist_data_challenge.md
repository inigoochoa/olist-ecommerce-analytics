# Olist Data Challenge
## Marketplace Performance & Customer Experience

### Background

Olist operates an e-commerce marketplace in Brazil, connecting customers with thousands of sellers across the country.

The company has accumulated a large volume of transactional data covering orders, products, sellers, customers, payments, reviews and delivery performance.

Management wants to better understand how the marketplace is performing and where the main opportunities for improvement lie.

You have joined the company as a **Data Analyst**.

Your task is to analyze Olist's historical data and present the most relevant insights to the management team.

The analysis should focus not only on describing what happened, but also on understanding **why it happened and what the business should do next**.

---

# Business Objective

Olist wants to answer one broad question:

**How can the company improve marketplace growth while maintaining a strong customer experience?**

Your analysis should help management understand:

- how the marketplace has evolved;
- what is driving revenue and order volume;
- which products, sellers and regions perform best;
- where the customer experience is deteriorating;
- whether logistics performance is affecting satisfaction;
- where management should prioritize action.

---

# Your Role

You are responsible for:

- preparing and modelling the data;
- identifying relevant KPIs;
- exploring the dataset;
- answering the business questions;
- identifying meaningful patterns;
- building a management dashboard;
- presenting actionable recommendations.

You are free to define your own methodology.

There is no single correct answer.

---

# Core Business Questions

## 1. Marketplace Performance

How has Olist's marketplace evolved over time?

Investigate metrics such as:

- order volume;
- revenue / GMV;
- average order value;
- number of customers;
- number of products sold;
- number of active sellers.

Look for:

- growth trends;
- seasonality;
- unusual periods;
- acceleration or slowdown;
- changes in customer activity.

Your goal is to explain the overall health and trajectory of the marketplace.

---

## 2. Revenue Drivers

What is driving Olist's commercial performance?

Analyze performance across dimensions such as:

- product category;
- seller;
- customer location;
- seller location;
- time period.

Consider questions such as:

- Which categories generate the most revenue?
- Which categories generate the most orders?
- Which sellers contribute the most to GMV?
- Is marketplace revenue highly concentrated?
- Are some categories growing faster than others?
- Are there categories with high volume but low average order value?

Try to distinguish between **volume drivers** and **value drivers**.

---

## 3. Customer Behaviour

What can Olist learn about its customers?

Explore questions such as:

- How many customers purchase more than once?
- What proportion of customers are repeat customers?
- Do returning customers behave differently?
- Are there geographical differences in purchasing behaviour?
- Which regions generate the highest order value?
- Do customer purchasing patterns change over time?

Think critically about what the dataset can and cannot tell you about retention.

---

## 4. Customer Satisfaction

What factors appear to influence customer satisfaction?

Use review scores as the main customer satisfaction indicator.

Explore relationships between review score and factors such as:

- delivery performance;
- product category;
- seller;
- order value;
- freight cost;
- number of products in the order;
- geography.

Identify:

- categories with strong sales but poor satisfaction;
- sellers with consistently poor reviews;
- characteristics shared by low-rated orders.

Do not assume correlation implies causation.

---

## 5. Delivery Performance

How effective is Olist's fulfilment process?

Analyze the different stages of the order lifecycle:

**Purchase → Approval → Carrier → Customer**

Evaluate metrics such as:

- total delivery time;
- approval time;
- seller handling time;
- carrier delivery time;
- difference between estimated and actual delivery date.

Determine:

- how often orders arrive late;
- how late they arrive;
- whether delays vary by region;
- whether delays vary by seller;
- whether delays vary by category;
- whether logistics performance changes over time.

Try to identify **where in the fulfilment process delays originate**.

---

## 6. Delivery vs Customer Satisfaction

Does delivery performance affect customer satisfaction?

Investigate the relationship between:

- delivery delay and review score;
- total delivery time and review score;
- seller processing time and review score;
- freight cost and review score.

Consider grouping orders into meaningful segments such as:

- early delivery;
- on-time delivery;
- 1–3 days late;
- 4–7 days late;
- more than 7 days late.

Determine whether customer satisfaction deteriorates meaningfully as delivery performance worsens.

---

## 7. Seller Performance

Which sellers are helping or hurting the marketplace?

Develop a framework for evaluating sellers using factors such as:

- revenue;
- order volume;
- average review score;
- delivery performance;
- cancellation rate;
- average order value.

Identify sellers that could be classified as:

- high-value / high-quality;
- high-value / low-quality;
- low-value / high-quality;
- low-value / low-quality.

Think about how Olist could use this information operationally.

---

## 8. Product & Category Opportunities

Where are the strongest commercial opportunities?

Look for combinations such as:

- high growth + high satisfaction;
- high revenue + low satisfaction;
- high volume + low value;
- low volume + high value;
- strong categories concentrated in particular regions.

Your objective is to identify areas where Olist could:

- invest;
- improve service quality;
- recruit more sellers;
- investigate operational issues;
- protect strategically important categories.

---

# Optional Advanced Questions

These are not mandatory.

Use them only if they add value to the story.

### Payments

Explore:

- preferred payment methods;
- use of instalments;
- relationship between instalments and order value;
- categories with higher instalment usage.

### Freight

Analyze:

- freight as a percentage of order value;
- regions with unusually high freight costs;
- categories where freight represents a large portion of total spending.

### Basket Analysis

Investigate:

- number of products per order;
- multi-item orders;
- whether larger baskets affect delivery times;
- whether larger baskets affect satisfaction.

### Geography

Explore:

- customer concentration;
- seller concentration;
- shipping distances using available geolocation information;
- whether long-distance deliveries have worse performance.

---

# Key Metrics

You must decide which metrics are most useful.

Possible KPIs include:

- GMV
- Orders
- Customers
- Active sellers
- Products sold
- Average Order Value
- Items per order
- Average freight cost
- Freight / order value
- Average delivery days
- Late delivery rate
- Average delivery delay
- Average review score
- Low-review rate
- Cancellation rate
- Repeat customer rate

You do not need to use all of them.

Select the metrics that best support your analysis.

---

# Data Modelling Requirement

Build a clean analytical layer before creating the final analysis.

A possible model could include:

## fact_orders

One row per order.

Potential fields:

- order_id
- customer_id
- order_status
- purchase_date
- approval_date
- carrier_date
- delivered_date
- estimated_delivery_date
- purchase_to_approval_days
- approval_to_carrier_days
- carrier_to_customer_days
- total_delivery_days
- delivery_delay_days
- number_of_reviews
- average_review_score

## fact_order_items

One row per item purchased.

Potential fields:

- order_id
- product_id
- seller_id
- price
- freight_value

Dimensions may include:

- customers;
- products;
- sellers;
- product categories;
- geography.

You may modify the model if your analysis requires it.

The objective is not to build the most complex data model possible.

The objective is to build a model that makes analysis reliable and reusable.

---

# Analytical Expectations

A strong submission should go beyond statements such as:

> São Paulo generates the highest revenue.

That is descriptive.

Instead, try to produce insights such as:

> São Paulo represents X% of total marketplace revenue, but sellers shipping to northern regions show significantly longer delivery times and lower customer satisfaction.

Or:

> Orders delivered more than seven days late have an average review score of X compared with Y for on-time deliveries.

Or:

> Category A is one of Olist's largest revenue generators but has a disproportionately high percentage of low reviews, suggesting an operational or seller-quality problem.

The objective is to connect:

**Metric → Pattern → Explanation → Business implication**

---

# Deliverables

## 1. SQL / BigQuery

Create a reproducible analytical layer in BigQuery.

Include:

- raw data;
- cleaned/staging tables;
- analytical tables;
- documented transformations.

Queries should be readable and logically organized.

---

## 2. Exploratory Analysis

Use SQL and/or Python to investigate the business questions.

Python may be particularly useful for:

- distributions;
- correlations;
- segmentation;
- statistical comparisons;
- exploratory charts.

You do not need to use Python simply for the sake of using Python.

Use it where it adds analytical value.

---

## 3. Power BI Dashboard

Build a dashboard aimed at management.

Recommended structure:

### Page 1 — Executive Overview

Answer:

**How is the marketplace performing?**

Possible elements:

- GMV
- Orders
- Customers
- Average Order Value
- Average Review Score
- Late Delivery Rate
- revenue trend
- order trend
- top categories

---

### Page 2 — Commercial Performance

Answer:

**What is driving marketplace performance?**

Possible analysis:

- categories;
- sellers;
- geography;
- revenue concentration;
- order value;
- growth.

---

### Page 3 — Customer & Delivery

Answer:

**Where is customer experience breaking down?**

Possible analysis:

- review scores;
- delivery times;
- delays;
- seller performance;
- geography;
- relationship between delivery and satisfaction.

Avoid filling the dashboard with charts.

Every visual should answer a question.

---

# Final Recommendations

Conclude the project with **3–5 recommendations**.

Each recommendation should contain:

1. the finding;
2. the supporting evidence;
3. the business implication;
4. the proposed action.

Example structure:

**Finding**

Orders delivered more than X days late receive substantially lower review scores.

**Evidence**

Average review score falls from X for on-time deliveries to Y for orders delayed more than X days.

**Business implication**

Delivery reliability appears to be an important driver of customer satisfaction.

**Recommendation**

Olist should identify sellers and logistics routes responsible for the highest percentage of severe delays and introduce service-level monitoring.

---

# Final Presentation

Imagine you have **10 minutes with Olist's Head of Marketplace**.

Your presentation should answer:

1. What happened?
2. Why did it happen?
3. Why does it matter?
4. What should Olist do?

Avoid presenting every analysis you performed.

Present the analyses that matter.

---

# Evaluation Criteria

Your project will be evaluated on five dimensions.

## Business thinking

Can you distinguish useful analysis from interesting-but-irrelevant analysis?

## SQL & Data Modelling

Is your analytical dataset reliable, understandable and reusable?

## Analytical depth

Do you move beyond descriptive statistics and investigate relationships?

## Data visualization

Are the visuals clear and appropriate for management?

## Communication

Can someone understand the main conclusions without reading your SQL or Python code?

---

# Success Criterion

The final project should not feel like:

> "I downloaded the Olist dataset and created some charts."

It should feel like:

> "Olist asked me to diagnose marketplace performance and I used SQL, Python and Power BI to identify the most important commercial and operational opportunities."

That is the standard you should aim for.
