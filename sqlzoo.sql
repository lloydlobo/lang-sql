/*
SELECT from Nobel Tutorial
nobel
yr	subject	winner
1960	Chemistry	Willard F. Libby
1960	Literature	Saint-John Perse
1960	Medicine	Sir Frank Macfarlane Burnet
1960	Medicine	Peter Madawar
...

`nobel` Nobel Laureates
We continue practicing simple SQL queries on a single table.

This tutorial is concerned with a table of Nobel prize winners:

`nobel(yr, subject, winner)`

Using the `SELECT` statement.
*/

-- Winners from 1950
-- 1.
-- Change the query shown so that it displays Nobel prizes for 1950.

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

-- Correct answer
-- yr	subject	winner
-- 1950	Chemistry	Kurt Alder
-- 1950	Chemistry	Otto Diels
-- 1950	Literature	Bertrand Russell
-- 1950	Medicine	Philip S. Hench
-- 1950	Medicine	Edward C. Kendall
-- 1950	Medicine	Tadeus Reichstein
-- 1950	Peace	Ralph Bunche
-- 1950	Physics	Cecil Powell

-- 1962 Literature
-- 2.
-- Show who won the 1962 prize for literature.

SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'literature'

-- Correct answer
-- winner
-- John Steinbeck

-- Albert Einstein
-- 3.
-- Show the year and subject that won 'Albert Einstein' his prize.

SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

-- Correct answer
-- yr	subject
-- 1921	Physics

-- Recent Peace Prizes
-- 4.
-- Give the name of the 'peace' winners since the year 2000, including 2000.

SELECT winner 
FROM nobel
WHERE yr > 1999
  AND subject in ('peace');

-- Correct answer
-- winner
-- Tunisian National Dialogue Quartet
-- Kailash Satyarthi
-- Malala Yousafzai
-- European Union
-- Ellen Johnson Sirleaf
-- Leymah Gbowee
-- Tawakel Karman
-- Liu Xiaobo
-- Barack Obama
-- Martti Ahtisaari
-- Intergovernmental Panel on Climate Change
-- Al Gore
-- Grameen Bank
-- Muhammad Yunus
-- International Atomic Energy Agency
-- Mohamed ElBaradei
-- Wangari Maathai
-- Shirin Ebadi
-- Jimmy Carter
-- United Nations
-- Kofi Annan
-- Kim Dae-jung

-- Literature in the 1980's
-- 5.
-- Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.

SELECT yr,subject,winner 
FROM nobel
WHERE yr BETWEEN 1980 AND 1989
  AND subject in ('Literature');

-- Correct answer
-- yr	subject	winner
-- 1989	Literature	Camilo José Cela
-- 1988	Literature	Naguib Mahfouz
-- 1987	Literature	Joseph Brodsky
-- 1986	Literature	Wole Soyinka
-- 1985	Literature	Claude Simon
-- 1984	Literature	Jaroslav Seifert
-- 1983	Literature	William Golding
-- 1982	Literature	Gabriel García Márquez
-- 1981	Literature	Elias Canetti
-- 1980	Literature	Czeslaw Milosz

-- Only Presidents
-- 6.
-- Show all details of the presidential winners:
-- 
-- * Theodore Roosevelt
-- * Thomas Woodrow Wilson
-- * Jimmy Carter
-- * Barack Obama

SELECT * 
FROM nobel
WHERE winner IN (
  'Theodore Roosevelt', 
  'Woodrow Wilson', 
  'Jimmy Carter', 
  'Barack Obama'
  );

-- Correct answer
-- yr	subject	winner
-- 2009	Peace	Barack Obama
-- 2002	Peace	Jimmy Carter
-- 1919	Peace	Woodrow Wilson
-- 1906	Peace	Theodore Roosevelt

-- John
-- 7.
-- Show the winners with first name John

SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

-- Correct answer
-- winner
-- John O'Keefe
-- John B. Gurdon
-- John C. Mather
-- John L. Hall
-- John B. Fenn
-- John E. Sulston
-- John Pople
-- John Hume
-- John E. Walker
-- John C. Harsanyi
-- John F. Nash Jr.
-- John C. Polanyi
-- John R. Vane
-- John H. van Vleck
-- John Cornforth
-- John R. Hicks
-- John Bardeen
-- John C. Kendrew
-- John Steinbeck
-- John Bardeen
-- John F. Enders
-- John Cockcroft
-- John H. Northrop
-- John R. Mott
-- John Galsworthy
-- John Macleod

-- Chemistry and Physics from different years
-- 8.
-- Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.

SELECT yr, subject, winner 
FROM nobel
WHERE (yr = 1980 AND subject = 'physics')
  OR (yr = 1984 AND subject = 'chemistry');

-- Correct answer
-- yr	subject	winner
-- 1984	Chemistry	Bruce Merrifield
-- 1980	Physics	James Cronin
-- 1980	Physics	Val Fitch

