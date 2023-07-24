
----------------------- What day of the week do most users register on ? ----------------------- 
-- query basic
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;
-- use subquery
SELECT 
    *,
    COUNT(*) AS 'quantity'
FROM users
GROUP BY  DAYNAME(created_at)
HAVING quantity = (
		SELECT 
		    COUNT(*) AS total
		FROM users
		GROUP BY  DAYNAME(created_at) 
		ORDER BY total DESC
		LIMIT 1
);
-- use windows functions
SELECT 
    day,
    total
FROM (
    SELECT 
        DAYNAME(created_at) AS day,
        COUNT(*) AS total,
        ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_num
    FROM users
    GROUP BY day
) AS subquery
WHERE row_num <= 2;

--------------------- Find the users who have never posted a photo ? -------------------------
-- Tối ưu
explain SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Không tối ưu
explain SELECT * FROM users
WHERE users.id NOT IN ( SELECT user_id FROM photos);

-- we're running a new contest to 
-- see who can get the most likes on a single photo.

SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total,
    photos.created_at
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC, photos.created_at ASC  -- Nếu tổng like bằng nhau thì lấy "photos.created_at" sớm nhất
LIMIT 1;

----------------------- Our investors want to know..---------------------
-- How many times does the avrage user post? 
SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 
                          
                          
                        
----------------------- A brand wants to knows which hashtags to use in a post  ---------------------     
-- What are the top 5 most commonly used hashtags?
-- C1
SELECT tag_id, count(tag_id) AS 'SoLanSuDung' FROM photo_tags
GROUP BY tag_id          
ORDER BY SoLanSuDung DESC
LIMIT 5

-- C2
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 
























































