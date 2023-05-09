--hashir muzaffar
--22816
CREATE VIEW vegetables AS
    SELECT
        *
    FROM
        sales
    WHERE
        item_type = 'Vegetables';

SELECT
    *
FROM
    vegetables;

CREATE VIEW high_priority AS
    SELECT
        *
    FROM
        sales
    WHERE
        order_priority = 'H';

SELECT
    *
FROM
    high_priority;

CREATE VIEW region_wise AS
    SELECT
        COUNT(*) AS counter
    FROM
        sales
    GROUP BY
        region;

SELECT
    *
FROM
    region_wise;

CREATE VIEW count_total_orders AS
    SELECT
        order_date,
        COUNT(DISTINCT item_type) AS item_count,
        COUNT(order_id)           AS total_order_per_customer
    FROM
        sales
    GROUP BY
        order_date;

SELECT
    *
FROM
    count_total_orders;

CREATE VIEW date_wise AS
    SELECT
        ship_date,
        COUNT(*)        AS total_number,
        SUM(units_sold) AS computed_sum,
        AVG(units_sold) AS avg_units
    FROM
        sales
    GROUP BY
        ship_date;

SELECT
    *
FROM
    date_wise
ORDER BY
    ship_date;

CREATE VIEW region_wise_profit AS
    SELECT
        region,
        SUM(total_revenue - total_cost) AS profit,
        AVG(total_revenue - total_cost) AS avgprofit
    FROM
        sales
    GROUP BY
        region;

SELECT
    *
FROM
    region_wise_profit;

--dummy data
INSERT INTO sales VALUES (
    'Asia',
    'Laos',
    'Vegetables',
    'Online',
    'H',
    '15-SEP-11',
    789176547,
    '23-OCT-11',
    3732,
    154.06,
    90.93,
    574951.92,
    339350.76
);

CREATE VIEW order_per_day AS
    SELECT
        order_date,
        COUNT(*) AS number_of_orders
    FROM
        sales
    GROUP BY
        order_date;

SELECT
    *
FROM
    order_per_day;


--dummy data
INSERT INTO sales VALUES (
    'Asia',
    'Laos',
    'Vegetables',
    'Online',
    'H',
    '15-JUl-14',
    789176547,
    '23-OCT-11',
    3732,
    154.06,
    90.93,
    574951.92,
    339350.76
);

CREATE VIEW this_date AS
    SELECT
        *
    FROM
        sales
    WHERE
        order_date = '15-JUL-14';

SELECT
    *
FROM
    this_date;

CREATE VIEW these_dates AS
    SELECT
        *
    FROM
        sales
    WHERE
        order_date = '15-JUL-14'
        OR order_date = '30-MAY-14';

SELECT
    *
FROM
    these_dates;

CREATE VIEW tp_greater_ap AS
    SELECT
        *
    FROM
        (
            SELECT
                country,
                SUM(total_revenue - total_cost) AS profit,
                AVG(total_revenue - total_cost) AS avgprofit
            FROM
                sales
            GROUP BY
                country
        )
    WHERE
        profit > avgprofit;

SELECT
    *
FROM
    tp_greater_ap;

CREATE VIEW country_wise_profit AS
    SELECT
        country,
        SUM(total_revenue - total_cost) AS profit,
        AVG(total_revenue - total_cost) AS avgprofit
    FROM
        sales
    GROUP BY
        country;

SELECT
    *
FROM
    country_wise_profit;