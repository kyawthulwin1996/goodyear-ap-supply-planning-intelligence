-- ============================================================
-- GOODYEAR AP SUPPLY PLANNING — COMPLETE DATABASE
-- Schema: goodyear_ap_supply
-- Author: Kyaw Thu Lwin | Supply Planning Analyst Portfolio
-- Version: FINAL — All Tables + All Views + All Data
-- Date: Jun 2026
-- ============================================================
-- HOW TO USE:
-- 1. Open MySQL Workbench
-- 2. File → Open SQL Script → select this file
-- 3. Press Ctrl + Shift + Enter to run everything
-- 4. Wait for completion — check verification results at bottom
-- 5. Connect Power BI to localhost / goodyear_ap_supply
-- ============================================================

DROP SCHEMA IF EXISTS goodyear_ap_supply;
CREATE SCHEMA goodyear_ap_supply;
USE goodyear_ap_supply;

-- ============================================================
-- DIMENSION TABLE 1: dim_country
-- ============================================================
CREATE TABLE dim_country (
    country_id      INT          PRIMARY KEY AUTO_INCREMENT,
    country_code    VARCHAR(3)   NOT NULL UNIQUE,
    country_name    VARCHAR(50)  NOT NULL,
    dc_name         VARCHAR(60)  NOT NULL,
    region          VARCHAR(30)  NOT NULL,
    currency        VARCHAR(10)  NOT NULL,
    timezone        VARCHAR(40)  NOT NULL,
    sort_order      INT          NOT NULL
);

INSERT INTO dim_country
    (country_code, country_name, dc_name, region, currency, timezone, sort_order)
VALUES
    ('TH','Thailand',   'Bangkok DC',       'Southeast Asia','THB','Asia/Bangkok',     1),
    ('MY','Malaysia',   'Kuala Lumpur DC',  'Southeast Asia','MYR','Asia/Kuala_Lumpur',2),
    ('ID','Indonesia',  'Jakarta DC',       'Southeast Asia','IDR','Asia/Jakarta',     3),
    ('VN','Vietnam',    'Ho Chi Minh DC',   'Southeast Asia','VND','Asia/Ho_Chi_Minh', 4),
    ('PH','Philippines','Manila DC',        'Southeast Asia','PHP','Asia/Manila',      5),
    ('IN','India',      'Mumbai DC',        'South Asia',    'INR','Asia/Kolkata',     6),
    ('SG','Singapore',  'Singapore DC',     'Southeast Asia','SGD','Asia/Singapore',   7);

-- ============================================================
-- DIMENSION TABLE 2: dim_product
-- ============================================================
CREATE TABLE dim_product (
    product_id      INT          PRIMARY KEY AUTO_INCREMENT,
    product_type    VARCHAR(20)  NOT NULL UNIQUE,
    product_group   VARCHAR(20)  NOT NULL,
    description     VARCHAR(100) NOT NULL,
    requires_casing BOOLEAN      NOT NULL DEFAULT FALSE,
    sort_order      INT          NOT NULL
);

INSERT INTO dim_product
    (product_type, product_group, description, requires_casing, sort_order)
VALUES
    ('New Tire','Tire','Brand new Goodyear tire — outbound to consignment DC',FALSE,1),
    ('Retread',  'Tire','Retreaded casing — reprocessed tread product, lower cost',TRUE,2);

-- ============================================================
-- DIMENSION TABLE 3: dim_date
-- ============================================================
CREATE TABLE dim_date (
    date_id       INT         PRIMARY KEY,
    full_date     DATE        NOT NULL UNIQUE,
    day_num       INT         NOT NULL,
    week_num      INT         NOT NULL,
    week_label    VARCHAR(5)  NOT NULL,
    month_num     INT         NOT NULL,
    month_name    VARCHAR(12) NOT NULL,
    quarter_num   INT         NOT NULL,
    quarter_label VARCHAR(6)  NOT NULL,
    year_num      INT         NOT NULL,
    is_weekend    BOOLEAN     NOT NULL,
    weekday_name  VARCHAR(12) NOT NULL
);

INSERT INTO dim_date VALUES
(20260101,'2026-01-01',1,1,'W01',1,'January',1,'Q1',2026,FALSE,'Thursday'),
(20260102,'2026-01-02',2,1,'W01',1,'January',1,'Q1',2026,FALSE,'Friday'),
(20260105,'2026-01-05',5,2,'W02',1,'January',1,'Q1',2026,FALSE,'Monday'),
(20260115,'2026-01-15',15,3,'W03',1,'January',1,'Q1',2026,FALSE,'Thursday'),
(20260131,'2026-01-31',31,5,'W05',1,'January',1,'Q1',2026,TRUE,'Saturday'),
(20260201,'2026-02-01',1,5,'W05',2,'February',1,'Q1',2026,TRUE,'Sunday'),
(20260210,'2026-02-10',10,7,'W07',2,'February',1,'Q1',2026,FALSE,'Tuesday'),
(20260228,'2026-02-28',28,9,'W09',2,'February',1,'Q1',2026,TRUE,'Saturday'),
(20260301,'2026-03-01',1,9,'W09',3,'March',1,'Q1',2026,TRUE,'Sunday'),
(20260315,'2026-03-15',15,11,'W11',3,'March',1,'Q1',2026,TRUE,'Sunday'),
(20260331,'2026-03-31',31,14,'W14',3,'March',1,'Q1',2026,FALSE,'Tuesday'),
(20260401,'2026-04-01',1,14,'W14',4,'April',2,'Q2',2026,FALSE,'Wednesday'),
(20260415,'2026-04-15',15,16,'W16',4,'April',2,'Q2',2026,FALSE,'Wednesday'),
(20260430,'2026-04-30',30,18,'W18',4,'April',2,'Q2',2026,FALSE,'Thursday'),
(20260501,'2026-05-01',1,18,'W18',5,'May',2,'Q2',2026,FALSE,'Friday'),
(20260515,'2026-05-15',15,20,'W20',5,'May',2,'Q2',2026,FALSE,'Friday'),
(20260531,'2026-05-31',31,22,'W22',5,'May',2,'Q2',2026,TRUE,'Sunday'),
(20260601,'2026-06-01',1,23,'W23',6,'June',2,'Q2',2026,FALSE,'Monday'),
(20260610,'2026-06-10',10,24,'W24',6,'June',2,'Q2',2026,FALSE,'Wednesday'),
(20260620,'2026-06-20',20,25,'W25',6,'June',2,'Q2',2026,TRUE,'Saturday'),
(20260623,'2026-06-23',23,26,'W26',6,'June',2,'Q2',2026,FALSE,'Tuesday'),
(20260624,'2026-06-24',24,26,'W26',6,'June',2,'Q2',2026,FALSE,'Wednesday'),
(20260625,'2026-06-25',25,26,'W26',6,'June',2,'Q2',2026,FALSE,'Thursday'),
(20260630,'2026-06-30',30,27,'W27',6,'June',2,'Q2',2026,FALSE,'Tuesday'),
(20260701,'2026-07-01',1,27,'W27',7,'July',3,'Q3',2026,FALSE,'Wednesday'),
(20260702,'2026-07-02',2,27,'W27',7,'July',3,'Q3',2026,FALSE,'Thursday'),
(20260707,'2026-07-07',7,28,'W28',7,'July',3,'Q3',2026,FALSE,'Tuesday'),
(20260708,'2026-07-08',8,28,'W28',7,'July',3,'Q3',2026,FALSE,'Wednesday'),
(20260714,'2026-07-14',14,29,'W29',7,'July',3,'Q3',2026,FALSE,'Tuesday'),
(20260715,'2026-07-15',15,29,'W29',7,'July',3,'Q3',2026,FALSE,'Wednesday'),
(20260721,'2026-07-21',21,30,'W30',7,'July',3,'Q3',2026,FALSE,'Tuesday'),
(20260731,'2026-07-31',31,31,'W31',7,'July',3,'Q3',2026,FALSE,'Friday');

-- ============================================================
-- FACT TABLE 1: fact_inventory_snapshot
-- ============================================================
CREATE TABLE fact_inventory_snapshot (
    snapshot_id           INT           PRIMARY KEY AUTO_INCREMENT,
    snapshot_date         DATE          NOT NULL,
    country_id            INT           NOT NULL,
    product_id            INT           NOT NULL,
    current_stock         INT           NOT NULL,
    target_stock          INT           NOT NULL,
    safety_stock          INT           NOT NULL,
    reorder_point         INT           NOT NULL,
    avg_daily_consumption DECIMAL(8,2)  NOT NULL,
    days_cover            DECIMAL(6,1)  NOT NULL,
    stock_status          VARCHAR(12)   NOT NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_inventory_snapshot
    (snapshot_date,country_id,product_id,current_stock,target_stock,safety_stock,reorder_point,avg_daily_consumption,days_cover,stock_status)
VALUES
-- Thailand New Tire
('2026-01-31',1,1,5200,5000,630,1260,45.0,115.6,'OK'),
('2026-02-28',1,1,4950,5000,630,1260,45.0,110.0,'OK'),
('2026-03-31',1,1,5100,5000,630,1260,45.0,113.3,'OK'),
('2026-04-30',1,1,5300,5000,630,1260,45.0,117.8,'OK'),
('2026-05-31',1,1,4800,5000,630,1260,45.0,106.7,'OK'),
('2026-06-30',1,1,4820,5000,630,1260,45.0,107.1,'OK'),
-- Thailand Retread
('2026-01-31',1,2,2500,2500,308,770,22.0,113.6,'OK'),
('2026-02-28',1,2,2350,2500,308,770,22.0,106.8,'OK'),
('2026-03-31',1,2,2600,2500,308,770,22.0,118.2,'OK'),
('2026-04-30',1,2,2400,2500,308,770,22.0,109.1,'OK'),
('2026-05-31',1,2,2200,2500,308,770,22.0,100.0,'OK'),
('2026-06-30',1,2,2340,2500,308,770,22.0,106.4,'OK'),
-- Malaysia New Tire
('2026-01-31',2,1,3400,3500,532,1064,38.0,89.5,'OK'),
('2026-02-28',2,1,3600,3500,532,1064,38.0,94.7,'OK'),
('2026-03-31',2,1,3200,3500,532,1064,38.0,84.2,'OK'),
('2026-04-30',2,1,3500,3500,532,1064,38.0,92.1,'OK'),
('2026-05-31',2,1,3300,3500,532,1064,38.0,86.8,'OK'),
('2026-06-30',2,1,3150,3500,532,1064,38.0,82.9,'OK'),
-- Malaysia Retread
('2026-01-31',2,2,1800,1800,252,630,18.0,100.0,'OK'),
('2026-02-28',2,2,1900,1800,252,630,18.0,105.6,'OK'),
('2026-03-31',2,2,1750,1800,252,630,18.0,97.2,'OK'),
('2026-04-30',2,2,1820,1800,252,630,18.0,101.1,'OK'),
('2026-05-31',2,2,1700,1800,252,630,18.0,94.4,'OK'),
('2026-06-30',2,2,1680,1800,252,630,18.0,93.3,'OK'),
-- Indonesia New Tire (RISK - declining)
('2026-01-31',3,1,2800,3000,770,1540,55.0,50.9,'OK'),
('2026-02-28',3,1,2600,3000,770,1540,55.0,47.3,'OK'),
('2026-03-31',3,1,2400,3000,770,1540,55.0,43.6,'RISK'),
('2026-04-30',3,1,2200,3000,770,1540,55.0,40.0,'RISK'),
('2026-05-31',3,1,2000,3000,770,1540,55.0,36.4,'RISK'),
('2026-06-30',3,1,1820,3000,770,1540,55.0,33.1,'RISK'),
-- Indonesia Retread
('2026-01-31',3,2,1200,1500,392,980,28.0,42.9,'RISK'),
('2026-02-28',3,2,1100,1500,392,980,28.0,39.3,'RISK'),
('2026-03-31',3,2,1000,1500,392,980,28.0,35.7,'RISK'),
('2026-04-30',3,2,950,1500,392,980,28.0,33.9,'RISK'),
('2026-05-31',3,2,920,1500,392,980,28.0,32.9,'RISK'),
('2026-06-30',3,2,890,1500,392,980,28.0,31.8,'RISK'),
-- Vietnam New Tire
('2026-01-31',4,1,2800,2800,448,896,32.0,87.5,'OK'),
('2026-02-28',4,1,2900,2800,448,896,32.0,90.6,'OK'),
('2026-03-31',4,1,2700,2800,448,896,32.0,84.4,'OK'),
('2026-04-30',4,1,2850,2800,448,896,32.0,89.1,'OK'),
('2026-05-31',4,1,2700,2800,448,896,32.0,84.4,'OK'),
('2026-06-30',4,1,2640,2800,448,896,32.0,82.5,'OK'),
-- Vietnam Retread
('2026-01-31',4,2,1200,1400,210,525,15.0,80.0,'OK'),
('2026-02-28',4,2,1300,1400,210,525,15.0,86.7,'OK'),
('2026-03-31',4,2,1150,1400,210,525,15.0,76.7,'OK'),
('2026-04-30',4,2,1250,1400,210,525,15.0,83.3,'OK'),
('2026-05-31',4,2,1100,1400,210,525,15.0,73.3,'OK'),
('2026-06-30',4,2,1120,1400,210,525,15.0,74.7,'OK'),
-- Philippines New Tire (RISK)
('2026-01-31',5,1,1400,1500,630,1260,45.0,31.1,'OK'),
('2026-02-28',5,1,1350,1500,630,1260,45.0,30.0,'OK'),
('2026-03-31',5,1,1200,1500,630,1260,45.0,26.7,'OK'),
('2026-04-30',5,1,1100,1500,630,1260,45.0,24.4,'RISK'),
('2026-05-31',5,1,1050,1500,630,1260,45.0,23.3,'RISK'),
('2026-06-30',5,1,980,1500,630,1260,45.0,21.8,'RISK'),
-- Philippines Retread (CRITICAL)
('2026-01-31',5,2,650,750,308,770,22.0,29.5,'OK'),
('2026-02-28',5,2,580,750,308,770,22.0,26.4,'OK'),
('2026-03-31',5,2,520,750,308,770,22.0,23.6,'RISK'),
('2026-04-30',5,2,480,750,308,770,22.0,21.8,'RISK'),
('2026-05-31',5,2,450,750,308,770,22.0,20.5,'RISK'),
('2026-06-30',5,2,420,750,308,770,22.0,19.1,'CRITICAL'),
-- India New Tire
('2026-01-31',6,1,5500,6000,770,1540,55.0,100.0,'OK'),
('2026-02-28',6,1,5800,6000,770,1540,55.0,105.5,'OK'),
('2026-03-31',6,1,5600,6000,770,1540,55.0,101.8,'OK'),
('2026-04-30',6,1,5900,6000,770,1540,55.0,107.3,'OK'),
('2026-05-31',6,1,5700,6000,770,1540,55.0,103.6,'OK'),
('2026-06-30',6,1,5680,6000,770,1540,55.0,103.3,'OK'),
-- India Retread
('2026-01-31',6,2,3000,3200,420,1050,30.0,100.0,'OK'),
('2026-02-28',6,2,3100,3200,420,1050,30.0,103.3,'OK'),
('2026-03-31',6,2,3200,3200,420,1050,30.0,106.7,'OK'),
('2026-04-30',6,2,3400,3200,420,1050,30.0,113.3,'OK'),
('2026-05-31',6,2,3300,3200,420,1050,30.0,110.0,'OK'),
('2026-06-30',6,2,3210,3200,420,1050,30.0,107.0,'OK'),
-- Singapore New Tire
('2026-01-31',7,1,1300,1200,252,630,18.0,72.2,'OK'),
('2026-02-28',7,1,1250,1200,252,630,18.0,69.4,'OK'),
('2026-03-31',7,1,1280,1200,252,630,18.0,71.1,'OK'),
('2026-04-30',7,1,1300,1200,252,630,18.0,72.2,'OK'),
('2026-05-31',7,1,1260,1200,252,630,18.0,70.0,'OK'),
('2026-06-30',7,1,1240,1200,252,630,18.0,68.9,'OK'),
-- Singapore Retread
('2026-01-31',7,2,600,600,126,315,9.0,66.7,'OK'),
('2026-02-28',7,2,620,600,126,315,9.0,68.9,'OK'),
('2026-03-31',7,2,610,600,126,315,9.0,67.8,'OK'),
('2026-04-30',7,2,620,600,126,315,9.0,68.9,'OK'),
('2026-05-31',7,2,600,600,126,315,9.0,66.7,'OK'),
('2026-06-30',7,2,580,600,126,315,9.0,64.4,'OK');

-- ============================================================
-- FACT TABLE 2: fact_cri_monthly
-- ============================================================
CREATE TABLE fact_cri_monthly (
    cri_id              INT           PRIMARY KEY AUTO_INCREMENT,
    report_month        DATE          NOT NULL,
    country_id          INT           NOT NULL,
    expected_casings    INT           NOT NULL,
    actual_casings      INT           NOT NULL,
    cri_pct             DECIMAL(5,4)  NOT NULL,
    cri_target          DECIMAL(5,4)  NOT NULL DEFAULT 0.8500,
    cri_status          VARCHAR(12)   NOT NULL,
    trend_vs_prev_month DECIMAL(5,4)  NULL,
    corrective_action   VARCHAR(200)  NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id)
);

INSERT INTO fact_cri_monthly
    (report_month,country_id,expected_casings,actual_casings,cri_pct,cri_status,trend_vs_prev_month,corrective_action)
VALUES
-- Thailand
('2026-01-01',1,500,440,0.8800,'OK',NULL,NULL),
('2026-02-01',1,520,473,0.9100,'OK',0.0300,NULL),
('2026-03-01',1,490,417,0.8500,'OK',-0.0600,'Monitor trend — hit target exactly'),
('2026-04-01',1,530,493,0.9300,'OK',0.0800,NULL),
('2026-05-01',1,510,454,0.8900,'OK',-0.0400,NULL),
('2026-06-01',1,500,435,0.8700,'OK',-0.0200,'Minor decline — review demand ratio Q3'),
-- Malaysia
('2026-01-01',2,420,386,0.9200,'OK',NULL,NULL),
('2026-02-01',2,400,352,0.8800,'OK',-0.0400,NULL),
('2026-03-01',2,440,414,0.9400,'OK',0.0600,NULL),
('2026-04-01',2,410,369,0.9000,'OK',-0.0400,NULL),
('2026-05-01',2,430,370,0.8600,'OK',-0.0400,NULL),
('2026-06-01',2,410,373,0.9100,'OK',0.0500,NULL),
-- Indonesia (DECLINING)
('2026-01-01',3,350,252,0.7200,'RISK',NULL,'Below target — initiate casing follow-up'),
('2026-02-01',3,360,245,0.6800,'RISK',-0.0400,'Declining — customer casing audit needed'),
('2026-03-01',3,370,274,0.7400,'RISK',0.0600,'Slight recovery — continue follow-up'),
('2026-04-01',3,380,247,0.6500,'RISK',-0.0900,'Sharp decline — escalate to sales team'),
('2026-05-01',3,390,238,0.6100,'RISK',-0.0400,'Critical trend — ticket planning review required'),
('2026-06-01',3,400,232,0.5800,'CRITICAL',-0.0300,'URGENT: 27 ppt below target. Customer audit + demand ratio revision'),
-- Vietnam
('2026-01-01',4,280,235,0.8400,'RISK',NULL,'Marginally below target — customer follow-up'),
('2026-02-01',4,290,252,0.8700,'OK',0.0300,NULL),
('2026-03-01',4,275,226,0.8200,'RISK',-0.0500,'Dip below target — review demand ratio'),
('2026-04-01',4,300,264,0.8800,'OK',0.0600,NULL),
('2026-05-01',4,285,242,0.8500,'OK',-0.0300,NULL),
('2026-06-01',4,290,241,0.8300,'RISK',-0.0200,'Monitor closely — 2 months trending down'),
-- Philippines (CRITICAL — collapsing)
('2026-01-01',5,200,130,0.6500,'RISK',NULL,'Below target — immediate casing follow-up'),
('2026-02-01',5,210,128,0.6100,'RISK',-0.0400,'Declining — visit top 3 customers'),
('2026-03-01',5,215,125,0.5800,'CRITICAL',-0.0300,'Critical — escalate to sales management'),
('2026-04-01',5,220,119,0.5400,'CRITICAL',-0.0400,'Severe — retread supply at risk. Emergency meeting.'),
('2026-05-01',5,225,117,0.5200,'CRITICAL',-0.0200,'Deteriorating — demand ratio revision required'),
('2026-06-01',5,230,113,0.4900,'CRITICAL',-0.0300,'CRISIS: 36 ppt below target. Ticket planning halted.'),
-- India
('2026-01-01',6,600,540,0.9000,'OK',NULL,NULL),
('2026-02-01',6,620,578,0.9300,'OK',0.0300,NULL),
('2026-03-01',6,610,555,0.9100,'OK',-0.0200,NULL),
('2026-04-01',6,640,608,0.9500,'OK',0.0400,NULL),
('2026-05-01',6,625,575,0.9200,'OK',-0.0300,NULL),
('2026-06-01',6,630,592,0.9400,'OK',0.0200,NULL),
-- Singapore
('2026-01-01',7,100,96,0.9600,'OK',NULL,NULL),
('2026-02-01',7,100,94,0.9400,'OK',-0.0200,NULL),
('2026-03-01',7,100,97,0.9700,'OK',0.0300,NULL),
('2026-04-01',7,100,95,0.9500,'OK',-0.0200,NULL),
('2026-05-01',7,100,98,0.9800,'OK',0.0300,NULL),
('2026-06-01',7,100,96,0.9600,'OK',-0.0200,NULL);

-- ============================================================
-- FACT TABLE 3: fact_shipment
-- ============================================================
CREATE TABLE fact_shipment (
    shipment_id        VARCHAR(10)  PRIMARY KEY,
    week_label         VARCHAR(5)   NOT NULL,
    week_num           INT          NOT NULL,
    country_id         INT          NOT NULL,
    product_id         INT          NOT NULL,
    containers         INT          NOT NULL,
    units              INT          NOT NULL,
    container_capacity INT          NOT NULL DEFAULT 600,
    container_util_pct DECIMAL(5,4) NOT NULL,
    etd_date           DATE         NOT NULL,
    eta_date           DATE         NOT NULL,
    transit_days       INT          NOT NULL,
    ship_status        VARCHAR(12)  NOT NULL,
    priority           VARCHAR(10)  NOT NULL,
    notes              VARCHAR(200) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_shipment VALUES
('SH001','W26',26,3,1,3,1800,600,1.0000,'2026-06-23','2026-06-28',5,'Confirmed','HIGH',  'Emergency replenishment — 9 days cover. Priority loading.'),
('SH002','W26',26,5,2,2,840, 600,0.7000,'2026-06-24','2026-06-27',3,'Confirmed','URGENT','CRITICAL — only 7 days cover remaining. Expedited.'),
('SH003','W27',27,1,1,4,2400,600,1.0000,'2026-06-30','2026-07-04',4,'Planned',  'NORMAL','Scheduled top-up — regular cycle. Stock healthy at 18 days.'),
('SH004','W27',27,4,2,2,960, 600,0.8000,'2026-07-01','2026-07-05',4,'Planned',  'NORMAL','CRI follow-up shipment — demand ratio to be revised.'),
('SH005','W27',27,3,2,3,1200,600,0.6667,'2026-07-02','2026-07-07',5,'At Risk',  'HIGH',  'Casing shortage — CRI 58%. Production may be delayed. Monitor daily.'),
('SH006','W28',28,2,1,3,1800,600,1.0000,'2026-07-07','2026-07-11',4,'Planned',  'NORMAL','Routine cycle — KL DC stock healthy at 22 days cover.'),
('SH007','W28',28,5,1,2,1200,600,1.0000,'2026-07-08','2026-07-11',3,'Confirmed','HIGH',  'Follow-up to W26 emergency. Philippines needs sustained replenishment.'),
('SH008','W29',29,6,1,5,3000,600,1.0000,'2026-07-14','2026-07-25',11,'Planned', 'NORMAL','Q3 cycle — largest single shipment. Mumbai DC.'),
('SH009','W29',29,1,2,2,840, 600,0.7000,'2026-07-15','2026-07-19',4,'Confirmed','NORMAL','Retread cycle — Bangkok DC CRI stable at 87%.'),
('SH010','W30',30,4,1,3,1800,600,1.0000,'2026-07-21','2026-07-25',4,'Planned',  'NORMAL','Vietnam new tire — pending container booking confirmation.');

-- ============================================================
-- FACT TABLE 4: fact_demand_forecast
-- ============================================================
CREATE TABLE fact_demand_forecast (
    forecast_id       INT           PRIMARY KEY AUTO_INCREMENT,
    forecast_month    DATE          NOT NULL,
    country_id        INT           NOT NULL,
    product_id        INT           NOT NULL,
    forecasted_demand INT           NOT NULL,
    actual_demand     INT           NULL,
    forecast_accuracy DECIMAL(5,4)  NULL,
    supply_available  INT           NOT NULL,
    supply_gap        INT           NOT NULL,
    gap_status        VARCHAR(12)   NOT NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_demand_forecast
    (forecast_month,country_id,product_id,forecasted_demand,actual_demand,forecast_accuracy,supply_available,supply_gap,gap_status)
VALUES
('2026-01-01',1,1,1400,1380,0.9857,1800,400,'SURPLUS'),
('2026-01-01',2,1,1180,1150,0.9746,1500,350,'SURPLUS'),
('2026-01-01',3,1,1700,1710,0.9941,1800,90,'SURPLUS'),
('2026-01-01',4,1,1000,980,0.9800,1200,220,'SURPLUS'),
('2026-01-01',5,1,1400,1420,0.9859,1500,80,'SURPLUS'),
('2026-01-01',6,1,1700,1680,0.9882,2000,320,'SURPLUS'),
('2026-01-01',7,1,560,540,0.9643,650,110,'SURPLUS'),
('2026-02-01',1,1,1400,1410,0.9929,1800,390,'SURPLUS'),
('2026-02-01',2,1,1180,1200,0.9833,1500,300,'SURPLUS'),
('2026-02-01',3,1,1700,1760,0.9659,1800,40,'SURPLUS'),
('2026-02-01',4,1,1000,1010,0.9901,1200,190,'SURPLUS'),
('2026-02-01',5,1,1400,1450,0.9655,1500,50,'SURPLUS'),
('2026-02-01',6,1,1700,1710,0.9941,2000,290,'SURPLUS'),
('2026-02-01',7,1,560,560,1.0000,650,90,'SURPLUS'),
('2026-03-01',1,1,1400,1390,0.9929,1800,410,'SURPLUS'),
('2026-03-01',2,1,1180,1170,0.9915,1500,330,'SURPLUS'),
('2026-03-01',3,1,1700,1820,0.9341,1800,-20,'SHORTAGE'),
('2026-03-01',4,1,1000,1020,0.9804,1200,180,'SURPLUS'),
('2026-03-01',5,1,1400,1480,0.9459,1500,20,'SURPLUS'),
('2026-03-01',6,1,1700,1690,0.9941,2000,310,'SURPLUS'),
('2026-03-01',7,1,560,550,0.9821,650,100,'SURPLUS'),
('2026-04-01',1,1,1450,1430,0.9862,1900,470,'SURPLUS'),
('2026-04-01',2,1,1200,1180,0.9833,1550,370,'SURPLUS'),
('2026-04-01',3,1,1750,1890,0.9259,1850,-40,'SHORTAGE'),
('2026-04-01',4,1,1050,1030,0.9810,1250,220,'SURPLUS'),
('2026-04-01',5,1,1450,1530,0.9478,1550,20,'SURPLUS'),
('2026-04-01',6,1,1750,1730,0.9886,2050,320,'SURPLUS'),
('2026-04-01',7,1,580,570,0.9828,680,110,'SURPLUS'),
('2026-05-01',1,1,1450,1460,0.9932,1900,440,'SURPLUS'),
('2026-05-01',2,1,1200,1220,0.9836,1550,330,'SURPLUS'),
('2026-05-01',3,1,1750,1920,0.9115,1900,-20,'SHORTAGE'),
('2026-05-01',4,1,1050,1080,0.9722,1250,170,'SURPLUS'),
('2026-05-01',5,1,1450,1560,0.9295,1560,0,'AT RISK'),
('2026-05-01',6,1,1750,1740,0.9943,2050,310,'SURPLUS'),
('2026-05-01',7,1,580,580,1.0000,680,100,'SURPLUS'),
('2026-06-01',1,1,1400,NULL,NULL,1820,420,'SURPLUS'),
('2026-06-01',2,1,1180,NULL,NULL,1500,320,'SURPLUS'),
('2026-06-01',3,1,1700,NULL,NULL,1820,120,'SURPLUS'),
('2026-06-01',3,2,860,NULL,NULL,890,30,'AT RISK'),
('2026-06-01',4,1,1000,NULL,NULL,1200,200,'SURPLUS'),
('2026-06-01',5,1,1400,NULL,NULL,980,-420,'SHORTAGE'),
('2026-06-01',5,2,680,NULL,NULL,420,-260,'SHORTAGE'),
('2026-06-01',6,1,1700,NULL,NULL,2000,300,'SURPLUS'),
('2026-06-01',7,1,560,NULL,NULL,650,90,'SURPLUS');

-- ============================================================
-- FACT TABLE 5: fact_daily_movement
-- ============================================================
CREATE TABLE fact_daily_movement (
    movement_id   INT          PRIMARY KEY AUTO_INCREMENT,
    movement_date DATE         NOT NULL,
    country_id    INT          NOT NULL,
    product_id    INT          NOT NULL,
    units_in      INT          NOT NULL DEFAULT 0,
    units_out     INT          NOT NULL DEFAULT 0,
    movement_type VARCHAR(20)  NOT NULL,
    reference_doc VARCHAR(20)  NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_daily_movement
    (movement_date,country_id,product_id,units_in,units_out,movement_type,reference_doc)
VALUES
('2026-06-01',1,1,0,45,'Consumption',NULL),
('2026-06-01',1,2,0,22,'Consumption',NULL),
('2026-06-01',2,1,0,38,'Consumption',NULL),
('2026-06-01',3,1,0,55,'Consumption',NULL),
('2026-06-01',4,1,0,32,'Consumption',NULL),
('2026-06-01',5,1,0,45,'Consumption',NULL),
('2026-06-01',5,2,0,22,'Consumption',NULL),
('2026-06-01',6,1,0,55,'Consumption',NULL),
('2026-06-01',7,1,0,18,'Consumption',NULL),
('2026-06-05',1,1,1800,45,'Shipment IN','SH-TH-0605'),
('2026-06-10',1,1,0,45,'Consumption',NULL),
('2026-06-10',2,1,0,38,'Consumption',NULL),
('2026-06-10',3,1,0,55,'Consumption',NULL),
('2026-06-10',4,1,0,32,'Consumption',NULL),
('2026-06-10',5,1,0,45,'Consumption',NULL),
('2026-06-10',6,1,0,55,'Consumption',NULL),
('2026-06-15',2,1,1500,38,'Shipment IN','SH-MY-0615'),
('2026-06-20',3,1,0,55,'Consumption',NULL),
('2026-06-20',3,2,0,28,'Consumption',NULL),
('2026-06-23',3,1,1800,55,'Shipment IN','SH001'),
('2026-06-24',5,2,840,22,'Shipment IN','SH002'),
('2026-06-25',1,1,0,45,'Consumption',NULL),
('2026-06-25',2,1,0,38,'Consumption',NULL),
('2026-06-25',3,1,0,55,'Consumption',NULL),
('2026-06-25',4,1,0,32,'Consumption',NULL),
('2026-06-25',5,1,0,45,'Consumption',NULL),
('2026-06-25',6,1,0,55,'Consumption',NULL),
('2026-06-25',7,1,0,18,'Consumption',NULL);

-- ============================================================
-- FACT TABLE 6: fact_supply_issues
-- Problem Detection + Root Cause Analysis
-- ============================================================
CREATE TABLE fact_supply_issues (
    issue_id           INT           PRIMARY KEY AUTO_INCREMENT,
    detected_date      DATE          NOT NULL,
    country_id         INT           NULL,
    product_id         INT           NULL,
    issue_category     VARCHAR(30)   NOT NULL,
    issue_type         VARCHAR(50)   NOT NULL,
    severity           VARCHAR(10)   NOT NULL,
    problem_statement  VARCHAR(300)  NOT NULL,
    root_cause_1       VARCHAR(200)  NOT NULL,
    root_cause_2       VARCHAR(200)  NULL,
    root_cause_3       VARCHAR(200)  NULL,
    business_impact    VARCHAR(200)  NOT NULL,
    impact_value_usd   DECIMAL(12,2) NULL,
    action_owner       VARCHAR(50)   NOT NULL,
    corrective_action  VARCHAR(300)  NOT NULL,
    due_date           DATE          NOT NULL,
    issue_status       VARCHAR(15)   NOT NULL DEFAULT 'Open',
    resolution_notes   VARCHAR(200)  NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_supply_issues
    (detected_date,country_id,product_id,issue_category,issue_type,severity,
     problem_statement,root_cause_1,root_cause_2,root_cause_3,
     business_impact,impact_value_usd,action_owner,corrective_action,
     due_date,issue_status,resolution_notes)
VALUES
('2026-06-20',5,2,'Inventory','Critical Stock Level','CRITICAL',
 'Philippines Manila DC has only 7 days retread cover — 420 units vs 750 unit target.',
 'CRI declined from 65% to 49% over 6 months — insufficient casings for retread production',
 'Replenishment frequency inadequate — monthly cycle insufficient for demand rate',
 'Emergency shipment SH002 confirmed but cycle gap too long',
 'Customer supply disruption within 7 days. Est. $15,400 revenue at risk per week.',
 15400.00,'Supply Planner + Logistics',
 'IMMEDIATE: Confirm SH002 (W26, 840 units, ETD Jun 24). Switch to bi-weekly cycle from W28. Initiate casing follow-up with top 5 customers.',
 '2026-06-24','In Progress',
 'SH002 confirmed June 24. Bi-weekly cycle approved.'),

('2026-06-01',3,2,'CRI','Casing Return Deficit','CRITICAL',
 'Indonesia CRI declined from 72% Jan to 58% Jun — 6 consecutive months decline. 27 ppt below 85% target.',
 'Customers not returning worn casings — structural behavior change since Q1 2026',
 'No systematic casing collection program at Jakarta DC',
 'Demand ratio outdated — actual tire usage higher than ratio assumes',
 'W27 Indonesia Retread SH005 AT RISK. Expected 400 casings, only 232 received. 168 unit shortfall.',
 28000.00,'Sales Team + Retread Planners',
 'WEEK 1: Sales team visits top 5 Indonesia customers — casing audit. WEEK 2: Adjust tickets to 232 available casings. WEEK 3: Revise demand ratio 0.85 to 0.70.',
 '2026-07-15','Open',NULL),

('2026-06-15',3,1,'Inventory','Declining Stock Trend','RISK',
 'Indonesia new tire stock declined 6 consecutive months: Jan 2,800 to Jun 1,820 units.',
 'Monthly replenishment cycle insufficient — demand growing 5-8% per month',
 'Supply plan not updated to reflect Indonesia demand growth trajectory',
 NULL,
 'If trend continues, Indonesia hits CRITICAL level by Sep 2026. Est. $45,000 revenue at risk.',
 45000.00,'Supply Planner + SDP Team',
 'Increase Indonesia shipment frequency to bi-weekly. Adjust target stock 3,000 to 3,500 units. Add W28 supplementary shipment.',
 '2026-07-07','Open',NULL),

('2026-06-22',NULL,NULL,'Logistics','Container Underutilization','LOW',
 'W27 average container utilization 84.4% — below 88% target. Vietnam retread SH004 only 80% full.',
 'Vietnam retread shipment quantity does not optimally fill 2 containers',
 'Quantities calculated for stock replenishment without container fill optimization',
 NULL,
 'Excess freight cost: approx $800 additional per shipment per month vs 88% target.',
 800.00,'Logistics Team + Supply Planner',
 'Add 120 units to Vietnam retread to reach 100% utilization. OR consolidate TH W27 + VN on same vessel if routing allows.',
 '2026-06-28','Open',NULL),

('2026-06-01',5,2,'CRI','Demand Ratio Revision Required','HIGH',
 'Philippines CRI at 49% — 36 ppt below 85% target. Declining 6 consecutive months. Structural issue.',
 'Large fleet customers reduced casing returns — confirmed by sales team',
 'One major customer switched portion of fleet to competitor brand',
 'Demand ratio 0.85 no longer valid for Philippines market conditions',
 'Retread ticket planning based on 85% CRI wastes production planning capacity. Supply continuity at risk.',
 22000.00,'Retread Planning Team + Sales',
 'IMMEDIATE: Halt tickets above available casing count (113 units). WEEK 1: Sales customer visit. WEEK 2: Revise Philippines demand ratio 0.85 to 0.55. WEEK 3: Update production plan.',
 '2026-07-15','Open',NULL),

('2026-06-01',3,1,'Demand','Forecast Accuracy Below Target','RISK',
 'Indonesia forecast accuracy declined: Mar 93.4%, Apr 92.6%, May 91.2%. Demand consistently above forecast.',
 'Forecast model using 12-month historical average — not capturing recent growth acceleration',
 'SDP team not updated for 3-month demand trend in Indonesia market',
 NULL,
 'Under-forecasting leads to under-supply planning. 3 consecutive months demand exceeding supply.',
 18000.00,'SDP Team + Supply Planner',
 'Request SDP update Indonesia forecast — switch to 3-month weighted average. Add 10% buffer to Indonesia shipment quantities pending revision.',
 '2026-07-01','Open',NULL);

-- ============================================================
-- FACT TABLE 7: fact_retread_ticket_plan
-- ============================================================
CREATE TABLE fact_retread_ticket_plan (
    ticket_id            INT          PRIMARY KEY AUTO_INCREMENT,
    plan_month           DATE         NOT NULL,
    country_id           INT          NOT NULL,
    planned_tickets      INT          NOT NULL,
    available_casings    INT          NOT NULL,
    casings_per_ticket   INT          NOT NULL DEFAULT 20,
    max_feasible_tickets INT          NOT NULL,
    ticket_gap           INT          NOT NULL,
    plan_status          VARCHAR(15)  NOT NULL,
    production_risk      VARCHAR(200) NULL,
    planner_action       VARCHAR(200) NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id)
);

INSERT INTO fact_retread_ticket_plan
    (plan_month,country_id,planned_tickets,available_casings,casings_per_ticket,
     max_feasible_tickets,ticket_gap,plan_status,production_risk,planner_action)
VALUES
('2026-07-01',1,22,435,20,21,-1,'OK',
 'Minor gap of 1 ticket — within acceptable tolerance',
 'Proceed with 21 tickets. Monitor Aug CRI.'),
('2026-07-01',2,20,373,20,18,-2,'RISK',
 'Short by 2 tickets — minor casing deficit',
 'Reduce July plan to 18 tickets. Increase Aug if CRI recovers.'),
('2026-07-01',3,20,232,20,11,-9,'CRITICAL',
 'SEVERE: Can only run 11 of 20 planned tickets. SH005 AT RISK.',
 'IMMEDIATE: Reduce July plan to 11 tickets. Delay SH005 to W28. Customer casing audit week 1.'),
('2026-07-01',4,15,241,20,12,-3,'RISK',
 'Short by 3 tickets — moderate casing deficit',
 'Reduce July plan to 12 tickets. Sales team follow-up on 3 largest accounts.'),
('2026-07-01',5,12,113,20,5,-7,'CRITICAL',
 'CRISIS: Only 5 tickets feasible vs 12 planned. Retread supply virtually halted.',
 'HALT tickets above 5. Emergency meeting with sales + management. Demand ratio revision required.'),
('2026-07-01',6,30,592,20,29,-1,'OK',
 'Minor gap — well within tolerance',
 'Proceed with 29 tickets. Excellent CRI — use as benchmark.'),
('2026-07-01',7,5,96,20,4,-1,'OK',
 'Minor gap — acceptable',
 'Proceed with 4 tickets. Strong CRI 96% — best in AP region.');

-- ============================================================
-- FACT TABLE 8: fact_logistics_plan
-- ============================================================
CREATE TABLE fact_logistics_plan (
    plan_id             INT           PRIMARY KEY AUTO_INCREMENT,
    plan_week           VARCHAR(5)    NOT NULL,
    week_num            INT           NOT NULL,
    country_id          INT           NOT NULL,
    product_id          INT           NOT NULL,
    required_containers INT           NOT NULL,
    booked_containers   INT           NOT NULL DEFAULT 0,
    vessel_name         VARCHAR(50)   NULL,
    port_of_loading     VARCHAR(50)   NOT NULL,
    port_of_discharge   VARCHAR(50)   NOT NULL,
    booking_deadline    DATE          NOT NULL,
    etd_date            DATE          NOT NULL,
    eta_date            DATE          NOT NULL,
    freight_cost_usd    DECIMAL(10,2) NULL,
    booking_status      VARCHAR(15)   NOT NULL,
    consolidation_note  VARCHAR(200)  NULL,
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_logistics_plan
    (plan_week,week_num,country_id,product_id,required_containers,booked_containers,
     vessel_name,port_of_loading,port_of_discharge,booking_deadline,
     etd_date,eta_date,freight_cost_usd,booking_status,consolidation_note)
VALUES
('W26',26,3,1,3,3,'MV Pacific Star',  'Bangkok Port','Jakarta Port',    '2026-06-16','2026-06-23','2026-06-28',4500.00,'Confirmed','Emergency booking — priority loading approved'),
('W26',26,5,2,2,2,'MV Asia Express',  'Bangkok Port','Manila Port',     '2026-06-17','2026-06-24','2026-06-27',3200.00,'Confirmed','Emergency booking — critical stock situation'),
('W27',27,1,1,4,4,'MV Thailand Pride','Bangkok Port','Bangkok DC',      '2026-06-23','2026-06-30','2026-07-04',5800.00,'Confirmed','Regular cycle — same vessel as VN retread'),
('W27',27,4,2,2,0,'MV Thailand Pride','Bangkok Port','Ho Chi Minh Port','2026-06-23','2026-07-01','2026-07-05',3100.00,'Pending', 'Consolidation with TH W27 — optimize to 100% (+120 units)'),
('W27',27,3,2,3,0,NULL,               'Bangkok Port','Jakarta Port',    '2026-06-23','2026-07-02','2026-07-07',4500.00,'At Risk', 'AT RISK: Booking on hold pending casing availability'),
('W28',28,2,1,3,3,'MV Sealand Malay', 'Bangkok Port','Port Klang',      '2026-06-30','2026-07-07','2026-07-11',4200.00,'Confirmed','Regular cycle — KL DC healthy stock'),
('W28',28,5,1,2,2,'MV Asia Express',  'Bangkok Port','Manila Port',     '2026-06-30','2026-07-08','2026-07-11',3200.00,'Confirmed','Follow-up to W26 emergency — priority'),
('W29',29,6,1,5,0,NULL,               'Bangkok Port','Nhava Sheva Port','2026-07-07','2026-07-14','2026-07-25',9500.00,'Pending', 'Largest shipment — 5 containers. Request dedicated vessel.'),
('W29',29,1,2,2,2,'MV Thai Spirit',   'Bangkok Port','Bangkok DC',      '2026-07-07','2026-07-15','2026-07-19',3000.00,'Confirmed','Retread cycle — regular booking'),
('W30',30,4,1,3,0,NULL,               'Bangkok Port','Ho Chi Minh Port','2026-07-14','2026-07-21','2026-07-25',4200.00,'Pending', 'Pending booking confirmation — submit by July 14');

-- ============================================================
-- VIEW 1: vw_current_inventory
-- Latest inventory snapshot per DC per product
-- ============================================================
CREATE OR REPLACE VIEW vw_current_inventory AS
SELECT
    c.country_code,
    c.country_name,
    c.dc_name,
    c.region,
    p.product_type,
    i.current_stock,
    i.target_stock,
    i.safety_stock,
    i.reorder_point,
    i.avg_daily_consumption,
    i.days_cover,
    i.stock_status,
    ROUND((i.current_stock / i.target_stock) * 100, 1) AS stock_vs_target_pct,
    i.current_stock - i.target_stock                   AS stock_vs_target_units,
    i.snapshot_date
FROM fact_inventory_snapshot i
JOIN dim_country c ON i.country_id = c.country_id
JOIN dim_product p ON i.product_id = p.product_id
WHERE i.snapshot_date = (
    SELECT MAX(s2.snapshot_date)
    FROM fact_inventory_snapshot s2
    WHERE s2.country_id = i.country_id
    AND   s2.product_id = i.product_id
);

-- ============================================================
-- VIEW 2: vw_cri_latest
-- Latest CRI per country
-- ============================================================
CREATE OR REPLACE VIEW vw_cri_latest AS
SELECT
    c.country_code,
    c.country_name,
    cr.report_month,
    cr.expected_casings,
    cr.actual_casings,
    cr.actual_casings - cr.expected_casings             AS casing_shortfall,
    ROUND(cr.cri_pct * 100, 1)                         AS cri_pct_display,
    ROUND(cr.cri_target * 100, 1)                      AS cri_target_display,
    ROUND((cr.cri_pct - cr.cri_target) * 100, 1)       AS gap_vs_target_ppt,
    cr.cri_status,
    cr.trend_vs_prev_month,
    cr.corrective_action
FROM fact_cri_monthly cr
JOIN dim_country c ON cr.country_id = c.country_id
WHERE cr.report_month = (
    SELECT MAX(cr2.report_month)
    FROM fact_cri_monthly cr2
    WHERE cr2.country_id = cr.country_id
);

-- ============================================================
-- VIEW 3: vw_shipment_pipeline
-- Full shipment schedule W26-W30
-- ============================================================
CREATE OR REPLACE VIEW vw_shipment_pipeline AS
SELECT
    s.shipment_id,
    s.week_label,
    s.week_num,
    c.country_name,
    c.dc_name,
    p.product_type,
    s.containers,
    s.units,
    s.container_capacity,
    s.container_capacity * s.containers                AS total_capacity,
    ROUND(s.container_util_pct * 100, 1)               AS util_pct_display,
    s.etd_date,
    s.eta_date,
    s.transit_days,
    s.ship_status,
    s.priority,
    s.notes,
    CASE
        WHEN s.ship_status = 'Confirmed' THEN 1
        WHEN s.ship_status = 'Planned'   THEN 2
        WHEN s.ship_status = 'At Risk'   THEN 3
        ELSE 4
    END AS status_sort_order
FROM fact_shipment s
JOIN dim_country c ON s.country_id = c.country_id
JOIN dim_product p ON s.product_id = p.product_id
ORDER BY s.week_num, status_sort_order;

-- ============================================================
-- VIEW 4: vw_supply_demand_gap
-- ============================================================
CREATE OR REPLACE VIEW vw_supply_demand_gap AS
SELECT
    DATE_FORMAT(fd.forecast_month,'%b %Y')  AS month_label,
    fd.forecast_month,
    c.country_name,
    p.product_type,
    fd.forecasted_demand,
    fd.actual_demand,
    fd.supply_available,
    fd.supply_gap,
    fd.gap_status,
    CASE
        WHEN fd.forecast_accuracy IS NOT NULL
        THEN ROUND(fd.forecast_accuracy * 100, 1)
        ELSE NULL
    END AS forecast_accuracy_pct
FROM fact_demand_forecast fd
JOIN dim_country c ON fd.country_id = c.country_id
JOIN dim_product p ON fd.product_id = p.product_id;

-- ============================================================
-- VIEW 5: vw_ap_executive_kpis
-- Single-row AP summary for KPI cards
-- ============================================================
CREATE OR REPLACE VIEW vw_ap_executive_kpis AS
SELECT
    SUM(current_stock)                                  AS total_ap_stock,
    SUM(target_stock)                                   AS total_target_stock,
    ROUND(SUM(current_stock)/SUM(target_stock)*100,1)  AS overall_stock_pct,
    COUNT(CASE WHEN stock_status='CRITICAL' THEN 1 END) AS critical_dc_count,
    COUNT(CASE WHEN stock_status='RISK'     THEN 1 END) AS risk_dc_count,
    COUNT(CASE WHEN stock_status='OK'       THEN 1 END) AS ok_dc_count,
    ROUND(AVG(days_cover),1)                            AS avg_days_cover,
    MIN(days_cover)                                     AS min_days_cover,
    MAX(days_cover)                                     AS max_days_cover
FROM vw_current_inventory;

-- ============================================================
-- VIEW 6: vw_container_utilization
-- Container fill rate by week and product type
-- ============================================================
CREATE OR REPLACE VIEW vw_container_utilization AS
SELECT
    week_label,
    week_num,
    product_type,
    SUM(containers)                                                    AS total_containers,
    SUM(units)                                                         AS total_units,
    SUM(container_capacity * containers)                               AS total_capacity,
    ROUND(SUM(units)/SUM(container_capacity*containers)*100,1)        AS avg_util_pct,
    COUNT(CASE WHEN ship_status='Confirmed' THEN 1 END)                AS confirmed_count,
    COUNT(CASE WHEN ship_status='At Risk'   THEN 1 END)                AS at_risk_count,
    COUNT(CASE WHEN ship_status='Planned'   THEN 1 END)                AS planned_count
FROM vw_shipment_pipeline
GROUP BY week_label, week_num, product_type
ORDER BY week_num;

-- ============================================================
-- VIEW 7: vw_supply_planner_issues
-- Problems + Root Cause Analysis for Supply Planning Team
-- ============================================================
CREATE OR REPLACE VIEW vw_supply_planner_issues AS
SELECT
    si.issue_id,
    si.detected_date,
    COALESCE(c.country_name,'AP Region')        AS country_name,
    COALESCE(p.product_type,'All Products')     AS product_type,
    si.issue_category,
    si.issue_type,
    si.severity,
    si.problem_statement,
    si.root_cause_1,
    si.root_cause_2,
    si.root_cause_3,
    si.business_impact,
    si.impact_value_usd,
    si.action_owner,
    si.corrective_action,
    si.due_date,
    si.issue_status,
    DATEDIFF(si.due_date, CURDATE())            AS days_until_due,
    CASE
        WHEN si.issue_status = 'Resolved'               THEN 'Resolved'
        WHEN DATEDIFF(si.due_date, CURDATE()) < 0       THEN 'Overdue'
        WHEN DATEDIFF(si.due_date, CURDATE()) <= 3      THEN 'Due Soon'
        ELSE 'On Track'
    END                                         AS action_urgency
FROM fact_supply_issues si
LEFT JOIN dim_country c ON si.country_id = c.country_id
LEFT JOIN dim_product p ON si.product_id = p.product_id
ORDER BY FIELD(si.severity,'CRITICAL','HIGH','RISK','LOW'), si.due_date;

-- ============================================================
-- VIEW 8: vw_retread_planner_report
-- CRI + Ticket Planning for Retread Planning Team
-- ============================================================
CREATE OR REPLACE VIEW vw_retread_planner_report AS
SELECT
    tp.plan_month,
    c.country_name,
    c.country_code,
    cr.cri_pct_display,
    cr.cri_status,
    cr.expected_casings,
    cr.actual_casings,
    cr.actual_casings - cr.expected_casings             AS casing_shortfall,
    tp.planned_tickets,
    tp.available_casings,
    tp.casings_per_ticket,
    tp.max_feasible_tickets,
    tp.ticket_gap,
    tp.plan_status                                      AS ticket_status,
    tp.max_feasible_tickets * tp.casings_per_ticket     AS max_producible_units,
    tp.planned_tickets      * tp.casings_per_ticket     AS originally_planned_units,
    (tp.planned_tickets - tp.max_feasible_tickets) * tp.casings_per_ticket AS production_shortfall_units,
    tp.production_risk,
    tp.planner_action,
    cr.corrective_action                                AS cri_corrective_action
FROM fact_retread_ticket_plan tp
JOIN dim_country c    ON tp.country_id   = c.country_id
JOIN vw_cri_latest cr ON cr.country_code = c.country_code
ORDER BY FIELD(tp.plan_status,'CRITICAL','RISK','OK'), c.sort_order;

-- ============================================================
-- VIEW 9: vw_logistics_team_report
-- Container Booking Plan for Logistics Team
-- ============================================================
CREATE OR REPLACE VIEW vw_logistics_team_report AS
SELECT
    lp.plan_id,
    lp.plan_week,
    lp.week_num,
    c.country_name,
    c.country_code,
    c.dc_name,
    p.product_type,
    lp.required_containers,
    lp.booked_containers,
    lp.required_containers - lp.booked_containers       AS containers_pending,
    lp.vessel_name,
    lp.port_of_loading,
    lp.port_of_discharge,
    lp.booking_deadline,
    lp.etd_date,
    lp.eta_date,
    DATEDIFF(lp.eta_date, lp.etd_date)                 AS transit_days,
    lp.freight_cost_usd,
    lp.booking_status,
    lp.consolidation_note,
    DATEDIFF(lp.booking_deadline, CURDATE())            AS days_to_booking_deadline,
    CASE
        WHEN lp.booking_status = 'Confirmed'            THEN 'Confirmed'
        WHEN lp.booking_status = 'At Risk'              THEN 'At Risk'
        WHEN DATEDIFF(lp.booking_deadline,CURDATE()) <= 3 THEN 'Book Now'
        ELSE 'Pending'
    END                                                 AS booking_urgency,
    fs.units                                            AS shipment_units,
    ROUND(fs.units / (lp.required_containers * 600) * 100, 1) AS utilization_pct
FROM fact_logistics_plan lp
JOIN dim_country c  ON lp.country_id = c.country_id
JOIN dim_product p  ON lp.product_id = p.product_id
LEFT JOIN fact_shipment fs ON (
    fs.week_num   = lp.week_num
    AND fs.country_id = lp.country_id
    AND fs.product_id = lp.product_id
)
ORDER BY lp.week_num, lp.etd_date;

-- ============================================================
-- VIEW 10: vw_e2e_supply_chain
-- End-to-End Supply Chain Process per Country
-- ============================================================
CREATE OR REPLACE VIEW vw_e2e_supply_chain AS
SELECT
    c.country_name,
    c.country_code,
    c.dc_name,
    c.region,
    -- Stage 1: Demand
    df.forecasted_demand                                AS demand_forecast,
    df.actual_demand,
    ROUND(df.forecast_accuracy * 100, 1)               AS forecast_accuracy_pct,
    df.gap_status                                       AS demand_gap_status,
    -- Stage 2: Inventory
    inv.current_stock,
    inv.target_stock,
    inv.avg_daily_consumption,
    inv.days_cover,
    inv.stock_status,
    ROUND(inv.current_stock / inv.target_stock * 100,1) AS stock_vs_target_pct,
    -- Stage 3: CRI
    cr.cri_pct_display                                  AS cri_pct,
    cr.cri_status,
    cr.casing_shortfall,
    cr.gap_vs_target_ppt                                AS cri_gap_vs_target,
    -- Stage 4: Ticket Planning
    tp.planned_tickets,
    tp.max_feasible_tickets                             AS feasible_tickets,
    tp.ticket_gap,
    tp.plan_status                                      AS ticket_plan_status,
    tp.max_feasible_tickets * tp.casings_per_ticket     AS max_producible_units,
    -- Stage 5: Shipment
    fs.week_label                                       AS next_shipment_week,
    fs.containers                                       AS containers_planned,
    fs.ship_status                                      AS shipment_status,
    fs.etd_date                                         AS next_etd,
    fs.priority                                         AS shipment_priority,
    -- Overall Health
    CASE
        WHEN inv.stock_status = 'CRITICAL'
          OR cr.cri_status    = 'CRITICAL' THEN 'CRITICAL'
        WHEN inv.stock_status = 'RISK'
          OR cr.cri_status    = 'RISK'     THEN 'RISK'
        ELSE 'OK'
    END                                                 AS overall_health,
    COALESCE(si.corrective_action,
             'No immediate action required')            AS priority_action,
    si.severity                                         AS issue_severity,
    si.action_owner                                     AS issue_action_owner
FROM dim_country c
LEFT JOIN fact_inventory_snapshot inv ON (
    inv.country_id    = c.country_id
    AND inv.product_id    = 1
    AND inv.snapshot_date = (
        SELECT MAX(s.snapshot_date)
        FROM fact_inventory_snapshot s
        WHERE s.country_id = c.country_id AND s.product_id = 1
    )
)
LEFT JOIN fact_demand_forecast df ON (
    df.country_id    = c.country_id
    AND df.product_id    = 1
    AND df.forecast_month = (
        SELECT MAX(fd2.forecast_month)
        FROM fact_demand_forecast fd2
        WHERE fd2.country_id = c.country_id AND fd2.product_id = 1
    )
)
LEFT JOIN vw_cri_latest cr ON cr.country_code = c.country_code
LEFT JOIN fact_retread_ticket_plan tp ON (
    tp.country_id = c.country_id AND tp.plan_month = '2026-07-01'
)
LEFT JOIN fact_shipment fs ON (
    fs.country_id = c.country_id
    AND fs.week_num = (
        SELECT MIN(s2.week_num)
        FROM fact_shipment s2
        WHERE s2.country_id = c.country_id
    )
)
LEFT JOIN fact_supply_issues si ON (
    si.country_id   = c.country_id
    AND si.issue_status != 'Resolved'
    AND si.severity     IN ('CRITICAL','HIGH')
    AND si.issue_id     = (
        SELECT MIN(s3.issue_id)
        FROM fact_supply_issues s3
        WHERE s3.country_id  = c.country_id
        AND s3.issue_status  != 'Resolved'
        AND s3.severity      IN ('CRITICAL','HIGH')
    )
)
ORDER BY c.sort_order;

-- ============================================================
-- VIEW 11: vw_management_decision_summary
-- Executive Issue Summary for Management
-- ============================================================
CREATE OR REPLACE VIEW vw_management_decision_summary AS
SELECT
    si.severity,
    si.issue_category,
    si.issue_type,
    COUNT(*)                                                            AS issue_count,
    SUM(si.impact_value_usd)                                           AS total_impact_usd,
    AVG(si.impact_value_usd)                                           AS avg_impact_usd,
    SUM(CASE WHEN si.issue_status='Open'        THEN 1 ELSE 0 END)     AS open_count,
    SUM(CASE WHEN si.issue_status='In Progress' THEN 1 ELSE 0 END)     AS in_progress_count,
    SUM(CASE WHEN si.issue_status='Resolved'    THEN 1 ELSE 0 END)     AS resolved_count,
    MIN(si.due_date)                                                   AS earliest_due_date,
    MAX(si.due_date)                                                   AS latest_due_date
FROM fact_supply_issues si
GROUP BY si.severity, si.issue_category, si.issue_type
ORDER BY FIELD(si.severity,'CRITICAL','HIGH','RISK','LOW'), total_impact_usd DESC;

-- ============================================================
-- VERIFICATION — Run these to confirm everything loaded
-- ============================================================
SELECT 'dim_country'              AS table_name, COUNT(*) AS row_count FROM dim_country
UNION ALL SELECT 'dim_product',                  COUNT(*) FROM dim_product
UNION ALL SELECT 'dim_date',                     COUNT(*) FROM dim_date
UNION ALL SELECT 'fact_inventory_snapshot',      COUNT(*) FROM fact_inventory_snapshot
UNION ALL SELECT 'fact_cri_monthly',             COUNT(*) FROM fact_cri_monthly
UNION ALL SELECT 'fact_shipment',                COUNT(*) FROM fact_shipment
UNION ALL SELECT 'fact_demand_forecast',         COUNT(*) FROM fact_demand_forecast
UNION ALL SELECT 'fact_daily_movement',          COUNT(*) FROM fact_daily_movement
UNION ALL SELECT 'fact_supply_issues',           COUNT(*) FROM fact_supply_issues
UNION ALL SELECT 'fact_retread_ticket_plan',     COUNT(*) FROM fact_retread_ticket_plan
UNION ALL SELECT 'fact_logistics_plan',          COUNT(*) FROM fact_logistics_plan;

SELECT '=== ALL VIEWS VERIFICATION ===' AS info;
SELECT 'vw_current_inventory'     AS view_name, COUNT(*) AS row_count FROM vw_current_inventory
UNION ALL SELECT 'vw_cri_latest',               COUNT(*) FROM vw_cri_latest
UNION ALL SELECT 'vw_shipment_pipeline',        COUNT(*) FROM vw_shipment_pipeline
UNION ALL SELECT 'vw_supply_demand_gap',        COUNT(*) FROM vw_supply_demand_gap
UNION ALL SELECT 'vw_ap_executive_kpis',        COUNT(*) FROM vw_ap_executive_kpis
UNION ALL SELECT 'vw_container_utilization',    COUNT(*) FROM vw_container_utilization
UNION ALL SELECT 'vw_supply_planner_issues',    COUNT(*) FROM vw_supply_planner_issues
UNION ALL SELECT 'vw_retread_planner_report',   COUNT(*) FROM vw_retread_planner_report
UNION ALL SELECT 'vw_logistics_team_report',    COUNT(*) FROM vw_logistics_team_report
UNION ALL SELECT 'vw_e2e_supply_chain',         COUNT(*) FROM vw_e2e_supply_chain
UNION ALL SELECT 'vw_management_decision_summary', COUNT(*) FROM vw_management_decision_summary;

SELECT '=== E2E SUPPLY CHAIN HEALTH ===' AS info;
SELECT country_name, days_cover, stock_status,
       cri_pct, cri_status, planned_tickets,
       feasible_tickets, shipment_status, overall_health
FROM vw_e2e_supply_chain;

SELECT '=== CRITICAL ISSUES ===' AS info;
SELECT severity, issue_type, action_owner, due_date, issue_status
FROM vw_supply_planner_issues
WHERE severity IN ('CRITICAL','HIGH');

-- ============================================================
-- POWER BI CONNECTION:
-- Server:   localhost
-- Port:     3306
-- Database: goodyear_ap_supply
-- Load ALL 11 Views from the Views folder
-- Load dim_country and dim_product from Tables folder
-- ============================================================