select * from menu_items
select * from order_details


--1. View the menu_items table and write a query to find the number of items on the menu
select distinct count(item_name) as no_of_items
from menu_items

-- 2. What are the least and most expensive items on the menu?

-- most expensive
select price, item_name 
from menu_items
order by price desc
limit 1

-- least expensive
select price, item_name 
from menu_items
order by price asc
limit 1


-- 3. How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?

-- italian dishes number
select count(item_name) "number of italian dishes"
from menu_items
where category = 'Italian'

-- expensive italian dishes
select price, item_name
from menu_items
where category = 'Italian'
order by price desc
limit 1

-- least expensive italian dishes
select price, item_name
from menu_items
where category = 'Italian'
order by price asc
limit 1

-- 4. How many dishes are in each category? What is the average dish price within each category?

--dishes in each category
select category, count(item_name)
from menu_items
group by category
order by count(item_name) desc

-- average dish price within each categories
select round(avg(price)) Average_price, category
from menu_items
group by category
order by avg(price)desc

-- 5. View the order_details table. What is the date range of the table?
select max(order_date) as current_date, min(order_date) as early_date
from order_details

-- 6. How many orders were made within this date range? How many items were ordered within this date range?
select max(order_date) as current_date, min(order_date) as early_date, count(order_details_id) no_of_orders
from order_details

-- 7. Which orders had the most number of items?
select order_id, count(item_name) "no_of_items"
from order_details o
inner join menu_items m on m.menu_item_id = o.item_id
group by order_id
order by count(menu_item_id) desc
limit 10

-- 8. How many orders had more than 12 items?
select order_id, count(item_name) "no_of_items"
from order_details o
inner join menu_items m on m.menu_item_id = o.item_id
group by order_id
having count(item_name) > 12
order by count(menu_item_id) desc

-- 9. Combine the menu_items and order_details tables into a single table
with combine_table as(

                      select m.*, o.* 
                      from menu_items m join order_details o
                      on m.menu_item_id = o.item_id)
select * from combine_table

-- 10. What were the least and most ordered items? What categories were they in?

--most ordered item
with combine_table as(

                      select m.*, o.* 
                      from menu_items m join order_details o
                      on m.menu_item_id = o.item_id)
					  
select count(order_id) most_order_id,item_name, category
from combine_table
group by category,item_name
order by count(order_id) desc
limit 1

--least ordered item
with combine_table as(

                      select m.*, o.* 
                      from menu_items m join order_details o
                      on m.menu_item_id = o.item_id)
					  
select count(order_id) least_order_id,item_name, category
from combine_table
group by category,item_name
order by count(order_id) asc
limit 1

-- 11.What were the top 5 orders that spent the most money?
with combine_table as(
                      select m.*, o.* 
                      from menu_items m join order_details o
                      on m.menu_item_id = o.item_id)
select order_id, sum(price) price
from combine_table
group by order_id
order by sum(price) desc
limit 5


-- 12. View the details of the highest spend order. Which specific items were purchased?
with combine_table as(
                      select m.*, o.* 
                      from menu_items m join order_details o
                      on m.menu_item_id = o.item_id)

select order_id, order_date, item_name, category, sum(price)
from combine_table
group by order_id, order_date, item_name, category
order by sum(price) desc
limit 5

-- 13. View the details of the top 5 highest spend order
with combine_table as(
                      select m.*, o.* 
                      from menu_items m join order_details o
                      on m.menu_item_id = o.item_id)

select order_id, sum(price) total_amount, order_date
from combine_table
group by order_id, order_date
order by sum(price) desc 
limit 5




					  
					  











































