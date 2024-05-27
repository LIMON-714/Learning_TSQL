
use assignment;

--task 11 anagram 
CREATE FUNCTION dbo.SplitStringToTable (@inputString VARCHAR(MAX))
RETURNS @outputTable TABLE (
    id INT IDENTITY(1,1),
    character CHAR(1)
)
AS
BEGIN
    DECLARE @pos INT = 1;
    DECLARE @len INT = LEN(@inputString);

    WHILE @pos <= @len
    BEGIN
        INSERT INTO @outputTable (character)
        VALUES (SUBSTRING(@inputString, @pos, 1));

        SET @pos = @pos + 1;
    END;

    RETURN;
END;

CREATE FUNCTION dbo.AreAnagrams (@str1 VARCHAR(MAX), @str2 VARCHAR(MAX))
RETURNS BIT
AS
BEGIN
    DECLARE @isAnagram BIT;

    --case-insensitive comparison
    SET @str1 = LOWER(REPLACE(@str1, ' ', ''));
    SET @str2 = LOWER(REPLACE(@str2, ' ', ''));

    -- Sort the characters in both strings
    DECLARE @sortedStr1 VARCHAR(MAX);
    DECLARE @sortedStr2 VARCHAR(MAX);
    SET @sortedStr1 = (SELECT STRING_AGG(character, '') WITHIN GROUP (ORDER BY character) FROM dbo.SplitStringToTable(@str1));
    SET @sortedStr2 = (SELECT STRING_AGG(character, '') WITHIN GROUP (ORDER BY character) FROM dbo.SplitStringToTable(@str2));

    -- Check
    IF @sortedStr1 = @sortedStr2
        SET @isAnagram = 1; -- (Anagrams)
    ELSE
        SET @isAnagram = 0; --(Not anagrams)
    
    -- Return the result
    RETURN @isAnagram;
END;


SELECT dbo.AreAnagrams('army', 'mary') AS AreAnagrams; -- 1 (True)
SELECT dbo.AreAnagrams('listen', 'silent') AS AreAnagrams; -- 1 (True)
SELECT dbo.AreAnagrams('hello', 'there') AS AreAnagrams; -- 0 (False)
