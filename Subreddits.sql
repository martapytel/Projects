+ -- Project title: Analyzing Subreddit posts
+ -- Database source: 
  -- Local data from CodeCademy titled "analyze-data-sql-practice"
+ -- Queried using: DBGate

+ -- Tasks: 
-- 1. What are the column names of each table?
Select * from users
Limit 10;
Select * from posts
Limit 10;
Select * from subreddits
Limit 10;

-- 2. What is the primary key for each table? Can you identify any foreign keys?
Primary keys are ID columns for each table. Foreign keys are user_id and subreddit_id in the posts table. 

-- 3. Write a query to count how many different subreddits there are.
Select Distinct Count(name)
From subreddits
There are 20 distinct subreddits.

-- 4. Write a few more queries to figure out the following information:
-- 4a.What user has the highest score?
Select username, max(score)
From users;
-- Max score for user ctills1w with 300895.

-- 4b. What post has the highest score?
Select user_id, title, max(score) From posts
Union 
Select user_id, title, max(score) From posts2;
-- Highest post was from user 78 titled 'Picture of a kitten' with 149176 score.

-- 4c. What are the top 5 subreddits with the highest subscriber_count?
Select name, subscriber_count
From subreddits
Group by 1
Order by 2 DESC
Limit 5;
-- Top 5 subreddits are AskReddit, gaming, aww, pics and science. 

-- 5. Use a LEFT JOIN with the users and posts tables to find out how many posts each user has made. Have the users table as the left table and order the data by the number of posts in descending order.
Select users.id, users.username, Count(posts.id) AS '# of posts made'
From users
Left Join posts
ON users.id = posts.user_id
Group by 1
Order by 3 DESC;

-- 6. Over time, posts may be removed and users might delete their accounts.
-- We only want to see existing posts where the users are still active, so use an INNER JOIN to write a query to get these posts.
Select *
From posts
Inner Join users
On posts.user_id = users.id;

-- 7. Some new posts have been added to Reddit! Stack the new posts2 table under the existing posts table to see them.
Select * from posts
Union
Select * from posts2
Order by created_date DESC;

-- 8. Now you need to find out which subreddits have the most popular posts. We’ll say that a post is popular if it has a score of at least 5000. We’ll do this using a WITH and a JOIN.
With popular_posts AS (
Select * from posts
Where score >= 5000
Union
Select * from posts2
Where score >= 5000
)
Select subreddits.name AS 'Subreddit name', popular_posts.title, popular_posts.score
From subreddits
Inner Join popular_posts
On subreddits.id = popular_posts.subreddit_id
Order by 3 DESC;

-- 9. Next, you need to find out the highest scoring post for each subreddit.
-- Do this by using an INNER JOIN, with posts as the left table.
With posts_union AS (
  Select * from posts
  Union
  Select * from posts2
)
Select subreddits.name AS 'Subreddit name', posts_union.title AS 'Post name', max(posts_union.score) AS 'Highest post score'
From subreddits
Inner Join posts_union
ON subreddits.id = posts_union.subreddit_id
Group by 1
Order by 3 DESC;

-- 10. Finally, you need to write a query to calculate the average score of all the posts for each subreddit.
-- Consider utilizing a JOIN, AVG, and GROUP BY to accomplish this, with the subreddits table as the left table.
With posts_union AS (
  Select * from posts
  Union
  Select * from posts2
)
Select subreddits.name, posts_union.title, round(avg(posts_union.score),0)
From subreddits
Inner Join posts_union
ON subreddits.id = posts_union.subreddit_id
Group by 1
Order by 1 ASC;
