# goodyear-ap-supply-planning-intelligence
AP Regional Supply Planning Intelligence System — MySQL + Power BI — 7 Markets — CRI Analysis, Root Cause Detection, Logistics Planning
# 🏭 Goodyear AP Supply Planning Intelligence System

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-FF6B6B?style=for-the-badge)

## 📋 Overview
A complete end-to-end **Supply Planning Intelligence System** 
built to demonstrate AP regional consignment supply chain 
analytics capabilities across 7 Asia Pacific markets.

> Built by **Kyaw Thu Lwin** | Supply Chain & Data Analyst
> M.Eng AIT Thailand | SAP S/4HANA Certified | Power BI DA Certified

---

## 🗺️ Coverage
| Market | DC Location | Status |
|--------|-------------|--------|
| 🇹🇭 Thailand | Bangkok DC | ✅ OK |
| 🇲🇾 Malaysia | Kuala Lumpur DC | ✅ OK |
| 🇮🇩 Indonesia | Jakarta DC | ⚠️ RISK |
| 🇻🇳 Vietnam | Ho Chi Minh DC | ✅ OK |
| 🇵🇭 Philippines | Manila DC | 🔴 CRITICAL |
| 🇮🇳 India | Mumbai DC | ✅ OK |
| 🇸🇬 Singapore | Singapore DC | ✅ OK |

---

## 🛠️ Tech Stack
- **Database:** MySQL 9.6 — 11 tables + 11 views + Star schema
- **Visualization:** Power BI Desktop — Live MySQL connection
- **Analytics:** DAX — 15 custom measures
- **Data Model:** Star schema (3 dim tables + 8 fact tables)

---

## 📊 Dashboard Pages

### Page 1 — Executive Summary (Management View)
![Page1](screenshots/page1_executive_summary.png)
- AP region KPI cards (Total Stock, Critical DCs, CRI, Impact USD)
- Supply vs Demand line chart — Jan to Jun 2026
- Inventory Days Cover by DC — target ≥14 days
- CRI by Country — target 85%
- Supply Risk Alert panel

### Page 2 — Supply Risk & Root Cause (Supply Planning Team)
![Page2](screenshots/page2_supply_risk.png)
- Auto-detected supply issues with severity levels
- 3-level root cause analysis per issue
- Business impact in USD per issue
- Corrective actions with owner and due date
- End-to-End supply chain health table

### Page 3 — Retread Planning Team
![Page3](screenshots/page3_retread_planning.png)
- CRI trend Jan–Jun 2026 by country
- Ticket planning vs available casings analysis
- Production shortfall units by market
- Planned vs Feasible tickets comparison

### Page 4 — Logistics Team
![Page4](screenshots/page4_logistics.png)
- Container booking status and vessel schedule
- Freight cost by week (W26–W30)
- Container pipeline by product type
- Utilization tracking vs 88% target

---

## 🔍 Key Business Insights

| Issue | Country | Severity | Impact USD |
|-------|---------|----------|------------|
| CRI collapsed 65%→49% in 6 months | Philippines | 🔴 CRITICAL | $22,000 |
| W27 Retread shipment AT RISK | Indonesia | 🔴 CRITICAL | $28,000 |
| Stock declining 6 consecutive months | Indonesia | ⚠️ RISK | $45,000 |
| Container utilization below 88% | W27 AP | 🟡 LOW | $800 |
| Forecast accuracy declining | Indonesia | ⚠️ RISK | $18,000 |
| Critical stock — 7 days cover | Philippines | 🔴 CRITICAL | $15,400 |

**Total Business Impact at Risk: USD 129,200**
---

## 🚀 How to Run

### 1. Set up MySQL Database
```sql
-- Open MySQL Workbench
-- File → Open SQL Script → goodyear_FINAL_CLEAN.sql
-- Press Ctrl + Shift + Enter
-- Database: goodyear_ap_supply will be created automatically
```

### 2. Connect Power BI
---

## 🗄️ Database Structure
### 3. Open Dashboard
---

## 📁 Repository Structure
---

## 👨‍💼 About the Author

**Kyaw Thu Lwin**
Supply Chain & Procurement Analyst | 7+ Years | Thailand & Myanmar

- 📧 kyawthulwin8834@gmail.com
- 🌐 [ktlsupplychainanalyst.com](https://ktlsupplychainanalyst.com)
- 💼 [LinkedIn](https://linkedin.com/in/kyawthulwin-supplychain-procurement-specialist)

**Certifications:**
- Microsoft Power BI Data Analyst
- SAP Technology Consultant Specialization
- IELTS 7.0 — C1 Advanced English
- M.Eng — Asian Institute of Technology Thailand

---

*This is a prototype dashboard built with illustrative data 
for portfolio purposes. Data does not represent actual 
Goodyear operations.*
