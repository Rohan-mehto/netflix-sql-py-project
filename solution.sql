--Q1 count the number of Movies vs tv shows
select 
type,
count(*) as total_content
from netflix
group by type

--Q2 find the most common rating for movie and tv shows

SELECT 
type,
rating
FROM
(

SELECT 
   type,
   rating,
   count(*),
   RANK()OVER(PARTITION BY type ORDER BY COUNT(*)DESC) as ranking
FROM netflix
GROUP BY 1,2
) as t1
WHERE 
  ranking=1

--Q3 List  all movies relased in a specific year(eg,2020)

  SELECT *FROM netflix
   WHERE 
     type='Movie'
	 AND
	 release_year=2020

--Q4 Find the top 5 countries with the most content on netflix
SELECT 
  UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
  COUNT(show_id) as total_content
  from netflix
  group by 1
  order by 2 DESC
  LIMIT 5

--Q5 Identify the longest movie
select *from netflix
WHERE 
  type ='Movie'
  And
  duration=(select max(duration) From netflix)

-- Q6 Find contectn added in the last 5 years
Select *
From netflix
where
  To_DATE(date_added,'Month DD,YYYY')>=CURRENT_DATE-INTERVAL'5years'
  select CURRENT_DATE -INTERVAL '5 years'


--Q7 Find all the movies/tv shows by director 'Rajiv chilaka'

SELECT *FROM netflix
where director ILIKE '%Rajiv Chilaka%'

--Q8 list all the tv shows with more than 5 seasons
select * from netflix
where 
 type='TV Show'
 AND
 SPLIT_PART(duration,' ',1) :: numeric >5

--Q9 COUNT THE NUMBER OF CONTENT ITEMS IN EACH GENERS



SELECT 
  UNNEST(STRING_TO_ARRAY(listed_in,',')) as genre,
  COUNT(show_id) as total_content

FROM netflix
group by 1

--Q10 Find each year and the average numbers of content release in India on netflix return top 5 year with highest avg content release

select 
  EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD,YYYY')) as year,
  Count(*) as yearly_,
  ROUND(
  Count(*) :: numeric/(select count(*) from netflix where country ='India') :: numeric *100,2) as avg_content_per_yera
  FROM netflix
  WHERE country='INDIA'
  group by 1

--Q11 List all movies that are documentaries
select * From netflix
Where 
 listed_in ILIKE '%documentaries%'

--Q12 Find all content without a director 
select * from netflix
where
  director Is NULL
--Q13 find how many movies actor'salman khan' appeared in last 10 yeras
select * from netflix
where casts ILIKE '%salman%'
AND
release_year>EXTRACT(YEAR FROM CURRENT_DATE)-10


--Q14 Find the top 10 actors who have appeared in the highest number of movies

Select 
UNNEST(STRING_TO_ARRAY(casts,',')) as actors,
COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%india'
group by 1
ORDER BY 2 DESC
LIMIT 10

 --Q15 Categorize the content based on the presence of the keywords 'kill' and 'violence ' in the description field.label content containing these keywords as 'Bad' and all other content as 'good' .count how many fall into  category.
 WITH new_table
 As (
select 
*,
case 
when 
  description ILIKE '%kill%' or
  description ILIKE '%violence' THEN 'Bad_content'
  ELse'Good content'
  END category
 FROM netflix
 )
 Select category,
 count(*) as total_content
 From new_table
 Group by 1
 )


  