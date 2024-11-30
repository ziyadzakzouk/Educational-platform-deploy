

Go
CREATE PROC ViewInfo --1  --handle the edge cases from the input till the validation
@LearnerID int
AS
if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
end
else
begin
select * from Learner 
where Learner_ID = @LearnerID
end


Go
CREATE PROC LearnerInfo--2
@LearnerID int
AS
if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
end
else 
begin
select * from PersonalProfile 
where Learner_ID = @LearnerID
end


Go
CREATE PROC EmotionalState--3
@LearnerID int,
 @emotional_state varchar(50) output
AS

if(not exists(select 1 from Emotional_feedback where LearnerID = @LearnerID))
begin 
print 'the learner does not exist'
end
else 
begin
select @emotional_state = emotional_state from Emotional_feedback 
where LearnerID = @LearnerID
end
go

Go
CREATE PROC LogDetails--4
@LearnerID int
AS

if(not exists(select 1 from Interaction_log where LearnerID = @LearnerID))
begin 
print 'the learner does not exist'
end
else
begin
select * from Interaction_log 
where LearnerID = @LearnerID
end
go

Go
CREATE PROC InstructorReview--5
@InstructorID int
AS

if(not exists(select 1 from Instructor where Instructor_ID = @InstructorID))
begin 
print 'the instructor does not exist'
end
else 
begin
select e.* from Emotional_feedback e inner join Emotionalfeedback_review er
on er.FeedbackID = e.FeedbackID where @InstructorID = er.InstructorID
end
go

Go
CREATE PROC CourseRemove--6
@courseID INT 
AS
BEGIN
    -- Check if the course exists
    IF NOT EXISTS (SELECT 1 FROM Course WHERE Course_ID = @courseID)
    BEGIN 
        PRINT 'The course does not exist';
        RETURN;
    END

    -- Delete dependent rows from the Ranking table
    DELETE FROM Ranking WHERE CourseID = @courseID;

    -- Delete the course
    DELETE FROM Course WHERE Course_ID = @courseID;

   
END;
Go
CREATE PROC Highestgrade --7
AS
begin
select MAX(totalMarks) from Assessment
group by Course_ID
end
go
Go
CREATE VIEW InstructorCount
AS
SELECT 
    c.Course_ID, 
    c.title ,    
	COUNT(t.Instructor_ID) AS InstructorCount
FROM 
    Course c
INNER JOIN 
    Teaches t 
ON 
    c.Course_ID = t.Course_ID
GROUP BY 
    c.Course_ID, c.title
HAVING 
    COUNT(t.Instructor_ID) > 1;
Go

CREATE PROC ViewNot --9
@LearnerID int
AS
BEGIN
if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
end
else
begin
select n.* from Notification n inner join RecivedNotfy r on n.Notification_ID = r.Notification_ID
where @LearnerID = r.Learner_ID
end
end
go

Go
CREATE PROC CreateDiscussion --10 --some discussion attributes need to be null and the forumid need to be identity
@ModuleID int, @courseID int, @title varchar(50), @description varchar(50)
AS
begin
if(exists(select * from Discussion_forum where Module_ID = @ModuleID and Course_ID=@courseID and title = @title and description = @description))
begin 
print('discussion forum already exist')
end
else
begin
insert into Discussion_forum(Module_ID,Course_ID,title,description) values (@ModuleID, @courseID, @title, @description)
print('the module has been inserted')
end
end
go

Go
CREATE PROC RemoveBadge -- 11
@BadgeID int
AS
if(not exists(select 1 from Badge where BadgeID = @BadgeID))
begin 
print 'the badge does not exist'
end
else
begin
delete from Badge where BadgeID = @BadgeID
print('the badge has been removed')
end
go

Go
CREATE PROC CriteriaDelete--12
@criteria varchar(50) 
AS
if(not exists(select 1 from Quest where criteria = @criteria))
begin 
print 'the criteria does not exist'
end
else
begin
delete from Quest where criteria = @criteria
end
go

Go
CREATE PROC NotificationUpdate --13 
@LearnerID int, @NotificationID int, @ReadStatus bit
AS
if(exists(select 1 from Notification where Notification_ID = @NotificationID and readstatus = @ReadStatus and @ReadStatus =1)) 
begin
delete from Notification where @NotificationID = Notification_ID
end
else 
begin 
update Notification
set readstatus = 1
where Notification_ID = @NotificationID and @ReadStatus = 0
end
go

go 
create proc EmotionalTrendAnalysis --14
@CourseID int, @ModuleID int, @TimePeriod datetime
as
if(not exists(select 1 from learningActivity where Course_ID = @CourseID)) 
begin
print('the course does not exist')
end
if(not exists(select 1 from learningActivity where Module_ID = @ModuleID)) 
begin
print('the module does not exist')
end
else 
begin 
select emotional_state from Emotional_feedback e inner join learningActivity l
on l.Activity_ID = e.Activity_ID where l.Course_ID = @CourseID and l.Module_ID=@ModuleID

END

---- instructor procedures
Go 
CREATE PROC SkillLearners  --1
    @Skillname VARCHAR(50)  
AS  
BEGIN  
 IF @Skillname IS NULL  
    BEGIN  
        PRINT 'Error: Skill name cannot be NULL';  
        RETURN;  
    END  

    SELECT  
        s.skill AS SkillName,  
        CONCAT(l.first_name, ' ', l.last_name) AS LearnerName  
    FROM  
        Skills s  
        INNER JOIN Learner l ON s.Learner_ID = l.Learner_ID  
    WHERE  
        s.skill = @Skillname;  

    
    IF @@ROWCOUNT = 0  
    BEGIN  
        PRINT 'No learners found for the specified skill.';  
    END  
END;

GO
CREATE PROC NewActivity --2
@CourseID INT,  
    @ModuleID INT, @activitytype VARCHAR(50), @instructiondetails VARCHAR(MAX), @maxpoints INT  
AS  
BEGIN  
      
    IF @CourseID IS NULL OR @CourseID <= 0  
    BEGIN  
        PRINT 'Error: CourseID must be a positive integer.'  
        RETURN;  
    END  

    
    IF @ModuleID IS NULL OR @ModuleID <= 0  
    BEGIN  
        PRINT 'Error: ModuleID must be a positive integer.'  
        RETURN;  
    END  

      
    IF @activitytype IS NULL OR @activitytype = ''  
    BEGIN  
        PRINT 'Error: activitytype cannot be NULL or empty.'  
        RETURN;  
    END  
 
    IF @instructiondetails IS NULL OR @instructiondetails = ''  
    BEGIN  
        PRINT 'Error: instructiondetails cannot be NULL or empty.'  
        RETURN;  
    END  

     
    IF @maxpoints IS NULL OR @maxpoints <= 0  
    BEGIN  
        PRINT 'Error: maxpoints must be greater than 0.'  
        RETURN;  
    END  

    
    INSERT INTO learningActivity (Course_ID, Module_ID, activityType, instruction_details, maxScore)  
    VALUES (@CourseID, @ModuleID, @activitytype, @instructiondetails, @maxpoints);  

    PRINT 'New activity added successfully.'  
END;  

GO
CREATE PROC NewAchievement --3 
@LearnerID int, 
@BadgeID int,
@description varchar(max), 
@date_earned date, 
@type varchar(50)
AS  
BEGIN  
    
    IF @LearnerID IS NULL OR @LearnerID <= 0  
    BEGIN  

      PRINT 'Error: LearnerID must be a positive integer.'  
        RETURN;  
    END  

      
    IF @BadgeID IS NULL OR @BadgeID <= 0  
    BEGIN  
        PRINT 'Error: BadgeID must be a positive integer.'  
       RETURN;  
    END  

     
    IF @description IS NULL OR @description = ''  
    BEGIN  

         PRINT 'Error: Description cannot be NULL or empty.'  
        RETURN;  
    END  

     
    IF @date_earned IS NULL OR @date_earned > GETDATE()  
    BEGIN  
        PRINT 'Error: DateEarned must not be NULL or in the future.'  
        RETURN;  
    END  

    
     IF @type IS NULL OR @type = ''  
    BEGIN  
        PRINT 'Error: Type cannot be NULL or empty.'  
        RETURN;  


    END  

    
    INSERT INTO Achievement (LearnerID, BadgeID, Description, DateEarned, Type)  
    VALUES (@LearnerID, @BadgeID, @description, @date_earned, @type);  

    PRINT 'New achievement added successfully.'  
END;

GO
CREATE PROC LearnerBadge --4
@BadgeID int

AS  
BEGIN  
   
    IF @BadgeID IS NULL OR @BadgeID <= 0  
    BEGIN  
        PRINT 'Error: BadgeID must be a positive integer.';  
        RETURN;  
    END  

    -- Retrieve learners associated with the given BadgeID from Achivment  
    SELECT  
        l.Learner_ID,  
        CONCAT(l.first_name, ' ', l.last_name) AS LearnerName,  
        b.title AS BadgeName  
    FROM  
        Achievement a  
        INNER JOIN Learner l ON a.LearnerID = l.Learner_ID  
        INNER JOIN Badge b ON a.BadgeID = b.BadgeID  
    WHERE  
        b.BadgeID = @BadgeID;  

     
    IF @@ROWCOUNT = 0  
    BEGIN  
        PRINT 'No learners found for the specified BadgeID.';  
    END  
END;  

GO
create proc NewPath --5 
@LearnerID int, 
@ProfileID int,
@completion_status varchar(50),
@custom_content varchar(max),
@adaptiverules varchar(max)
AS  
BEGIN  
     
    IF @LearnerID IS NULL OR @LearnerID <= 0  
    BEGIN  
        PRINT 'Error: LearnerID must be a positive integer.';  
        RETURN;  
    END  

    IF @ProfileID IS NULL OR @ProfileID <= 0  
    BEGIN  
        PRINT 'Error: ProfileID must be a positive integer.';  
        RETURN;  
    END  

    IF @completion_status IS NULL OR @completion_status = ''  
    BEGIN  
        PRINT 'Error: CompletionStatus cannot be NULL or empty.';  
        RETURN;  
    END  
  
    IF @custom_content IS NULL OR @custom_content = ''  
    BEGIN  
        PRINT 'Error: CustomContent cannot be NULL or empty.';  
        RETURN;  
    END  

    IF @adaptiverules IS NULL OR @adaptiverules = ''  
    BEGIN  
        PRINT 'Error: AdaptiveRules cannot be NULL or empty.';  
        RETURN;  
    END  

    INSERT INTO LearningPath (Learner_ID, profileID, completion_status, customContent, adaptiveRules)  VALUES (@LearnerID, @ProfileID, @completion_status, @custom_content, @adaptiverules);  

    PRINT 'New learning path created successfully.';  
END;  

GO
CREATE PROC TakenCourses --6 
@LearnerID Int 
AS  
BEGIN   
    IF @LearnerID IS NULL OR @LearnerID <= 0  
    BEGIN  
        PRINT 'Error: LearnerID must be a positive integer.';  
        RETURN;  
    END  

    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)  
    BEGIN  
        PRINT 'Error: LearnerID does not exist.';  
        RETURN;  
    END  

   
    SELECT  
        c.Course_ID,  
        c.title  
    FROM  
        Course c  
        INNER JOIN Course_Enrollment ce ON c.Course_ID = ce.Course_ID  
    WHERE  
        ce.Learner_ID = @LearnerID;  
 
    IF @@ROWCOUNT = 0  
    BEGIN  
        PRINT 'No courses found for the specified LearnerID.';  
    END  
END;  

GO
GO
CREATE PROC CollaborativeQuest
    @difficulty_level VARCHAR(50),
    @criteria VARCHAR(50),
    @description VARCHAR(50), 
    @title VARCHAR(50), 
    @Maxnumparticipants INT, 
    @deadline DATETIME
AS
BEGIN  
   
    IF @difficulty_level IS NULL OR LEN(@difficulty_level) = 0  
    BEGIN  
        PRINT 'Error: Difficulty level cannot be NULL or empty.';  
        RETURN;  
    END  

   
    IF @criteria IS NULL OR LEN(@criteria) = 0  
    BEGIN  
        PRINT 'Error: Criteria cannot be NULL or empty.';  
        RETURN;  
    END  

   
    IF @description IS NULL OR LEN(@description) = 0  
    BEGIN  
        PRINT 'Error: Description cannot be NULL or empty.';  
        RETURN;  
    END  

    
    IF @title IS NULL OR LEN(@title) = 0  
    BEGIN  
        PRINT 'Error: Title cannot be NULL or empty.';  
        RETURN;  
    END  

    
    IF @Maxnumparticipants IS NULL OR @Maxnumparticipants <= 0  
    BEGIN  
        PRINT 'Error: Max number of participants must be a positive integer.';  
        RETURN;  
    END  

    
    IF @deadline IS NULL OR @deadline < GETDATE()  
    BEGIN  
        PRINT 'Error: Deadline must be a future date.';  
        RETURN;  
    END  

   
    IF EXISTS (SELECT 1 FROM Quest WHERE Title = @title)
    BEGIN
        PRINT 'Error: A quest with the same title already exists.';
        RETURN;
    END

 
    INSERT INTO Quest (difficulty_level, criteria, description, title)  
    VALUES (@difficulty_level, @criteria, @description, @title);  

   
    DECLARE @QuestID INT = SCOPE_IDENTITY();  

    
    INSERT INTO Collaborative (QuestID, Deadline, Max_Num_Participants)  
    VALUES (@QuestID, @deadline, @Maxnumparticipants);  

   
END;
GO


GO
CREATE PROCEDURE DeadlineUpdate  --8 
@QuestID INT, 
@deadline DATETIME
AS  
BEGIN  
    IF @QuestID IS NULL OR @QuestID <= 0  
    BEGIN  
        PRINT 'Error: QuestID must be a positive integer.';  
        RETURN;  
    END  
 
    IF @deadline IS NULL OR @deadline < GETDATE()  
    BEGIN  
        PRINT 'Error: Deadline must be a future date.';  
        RETURN;  
    END  

  
    IF NOT EXISTS (SELECT 1 FROM Collaborative WHERE QuestID = @QuestID)  
    BEGIN  
        PRINT 'Error: QuestID does not exist in the Collaborative table.';  
        RETURN;  
    END  

    UPDATE Collaborative  
    SET Deadline = @deadline  
    WHERE QuestID = @QuestID;  

    PRINT 'Deadline updated successfully.';  
END;

GO 
CREATE PROC GradeUpdate  --9 
@LearnerID int, 
@AssessmentID int,
@Newgrade int 
AS
BEGIN

   IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Error: Learner not found.';
        RETURN;
    END

    
    IF NOT EXISTS (SELECT 1 FROM Assessment WHERE Assessment_ID = @AssessmentID)
    BEGIN
        PRINT 'Error: Assessment not found.';
        RETURN;
    END

    
    IF @Newgrade < 0 OR @Newgrade > (SELECT totalMarks FROM Assessment WHERE Assessment_ID = @AssessmentID)
    BEGIN
        PRINT 'Error: Invalid grade value.';
        RETURN;
    END

   
    UPDATE TakenAssessment 
    SET ScoredPoint = @Newgrade 
    WHERE Learner_ID = @LearnerID AND Assessment_ID = @AssessmentID;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Grade updated successfully.';
    END
    ELSE
    BEGIN
        PRINT 'No record found to update.';
    END
END;

GO
CREATE PROC AssessmentNot  --10
@NotificationID INT, 
@timestamp datetime,
@message VARCHAR(MAX), 
@urgencylevel VARCHAR(50), 
@LearnerID INT
AS
BEGIN
    
    IF @urgencylevel NOT IN ('High', 'Medium', 'Low')
    BEGIN
        PRINT 'Error: Invalid urgency level. Valid values are "High", "Medium", or "Low".';
        RETURN;
    END

    
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Error: Learner not found.';
        RETURN;
    END

	 IF @timestamp IS NULL
    BEGIN
        SET @timestamp = CURRENT_TIMESTAMP;
    END
    
    IF EXISTS (SELECT 1 FROM Notification WHERE Notification_ID = @NotificationID)
    BEGIN
        PRINT 'Error: Notification ID already exists.';
        RETURN;
    END

   
    IF @timestamp IS NULL
    BEGIN
        SET @timestamp = CURRENT_TIMESTAMP;
    END

   SET IDENTITY_INSERT Notification ON;
    INSERT INTO Notification (Notification_ID, time_stamp, message, urgency)
    VALUES (@NotificationID, @timestamp, @message, @urgencylevel);
		
 
    INSERT INTO RecivedNotfy (Learner_ID, Notification_ID)
    VALUES (@LearnerID, @NotificationID);

    PRINT 'Notification sent successfully.';
END;

GO
CREATE PROC NewGoal --11
@GoalID INT, 
@status VARCHAR(MAX), 
@deadline DATETIME,
@description VARCHAR(MAX)
AS 
BEGIN
    
    IF @status IS NULL OR TRIM(@status) = ''
    BEGIN
        PRINT 'Error: Status cannot be empty.';
        RETURN;
    END

    
    IF @deadline <= GETDATE()
    BEGIN
        PRINT 'Error: Deadline must be a future date.';
        RETURN;
    END

    
    IF EXISTS (SELECT 1 FROM Learning_goal WHERE ID = @GoalID)
    BEGIN
        PRINT 'Error: GoalID already exists.';
        RETURN;
    END

  SET IDENTITY_INSERT  Learning_goal ON;
    INSERT INTO Learning_goal (ID, status, deadline, description)
    VALUES (@GoalID, @status, @deadline, @description);
	
    PRINT 'Goal created successfully.';
END;

Go
CREATE PROC LearnersCourses --12
@CourseID INT,
@InstructorID INT
AS 
BEGIN

    
    IF NOT EXISTS (SELECT 1 FROM Course WHERE Course_ID = @CourseID)
    BEGIN
        PRINT 'Error: Course not found.';
        RETURN;
    END

   
    IF NOT EXISTS (SELECT 1 FROM Instructor WHERE Instructor_ID = @InstructorID)
    BEGIN
        PRINT 'Error: Instructor not found.';
        RETURN;
    END

   
    IF NOT EXISTS (SELECT 1 FROM Course WHERE Course_ID = @CourseID)
    BEGIN
        PRINT 'Error: The instructor is not associated with this course.';
        RETURN;
    END

    
    IF NOT EXISTS (SELECT 1 FROM Course_Enrollment WHERE Course_ID = @CourseID)
    BEGIN
        PRINT 'Error: No learners are enrolled in this course.';
        RETURN;
    END

    -- Return the learners enrolled in the course taught by the provided instructor
    SELECT C.title,L.Learner_ID, L.first_name + ' ' + L.last_name AS LearnerName
    FROM Course_Enrollment CE
    INNER JOIN Course C ON CE.Course_ID = C.Course_ID
    INNER JOIN Teaches t ON C.Course_ID = t.Course_ID
    INNER JOIN Learner L ON CE.Learner_ID = L.Learner_ID
    WHERE C.Course_ID = @CourseID AND t.Instructor_ID = @InstructorID;

END;

Go
CREATE PROC LastActive --13
@ForumID INT,
@lastactive DATETIME OUTPUT
AS 
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM Discussion_forum WHERE forumID = @ForumID)
    BEGIN
        PRINT 'Error: Forum not found.';
        SET @lastactive = NULL; -- Set output to NULL if forum doesn't exist
        RETURN;
    END

    
    SELECT @lastactive = last_active
    FROM Discussion_forum 
    WHERE forumID = @ForumID;

    
    IF @lastactive IS NULL
    BEGIN
        PRINT 'Error: Last active date is NULL for this forum.';
    END
END;

GO 
CREATE PROC CommonEmotionalState --14
@state VARCHAR(50) OUTPUT
AS
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM Emotional_feedback)
    BEGIN
        PRINT 'Error: No feedback records found.';
        SET @state = NULL; -- Set the output to NULL as there is no data
        RETURN;
    END

    
    SELECT TOP 1 @state = emotional_state
    FROM Emotional_feedback
    GROUP BY emotional_state
    ORDER BY COUNT(emotional_state) DESC;

    
    IF @state IS NULL
    BEGIN
        PRINT 'Error: Unable to determine the common emotional state.';
    END
END;

GO
CREATE PROCEDURE ModuleDifficulty --15
    @courseID INT
AS
BEGIN

  IF NOT EXISTS (SELECT 1 FROM Course WHERE Course_ID = @courseID)
    BEGIN
        PRINT 'Error: Course not found.';
        RETURN;
    END

    
    IF NOT EXISTS (SELECT 1 FROM Module WHERE Course_ID = @courseID)
    BEGIN
        PRINT 'Error: No modules found for this course.';
        RETURN;
    END

    SELECT M.Module_ID, M.title, M.difficulty_level, M.contentURL
    FROM Module M
    WHERE M.Course_ID = @courseID
    ORDER BY 
        CASE 
            WHEN M.difficulty_level = 'Easy' THEN 1
            WHEN M.difficulty_level = 'Medium' THEN 2
            WHEN M.difficulty_level = 'Hard' THEN 3
            ELSE 4 
        END;
END;

GO
CREATE PROC  Profeciencylevel --16 --handle the cases in my procedure 
@LearnerID int,
@skill varchar(50) Output
AS
BEGIN

    IF @LearnerID IS NULL OR @LearnerID <= 0
    BEGIN
        PRINT 'Error: Invalid LearnerID provided.';
        RETURN;
    END

   
    IF @Skill IS NULL 
    BEGIN
        PRINT 'Error: Skill cannot be empty or null.';
        RETURN;
    END

   
    IF NOT EXISTS (SELECT 1 FROM SkillProgression WHERE LearnerID = @LearnerID)
    BEGIN
        PRINT 'Error: No learner found with the given LearnerID.';
        RETURN;
    END

    ELSE
    BEGIN
        SELECT
            Skill = @Skill,
            proficiency_level
        FROM
            SkillProgression
        WHERE
            LearnerID = @LearnerID AND skill_name = @Skill
        ORDER BY
            proficiency_level DESC;
    END
END



GO
CREATE PROC  ProfeciencyUpdate --17
    @Skill VARCHAR(50),
    @LearnerID INT,
    @Level VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

   
    IF @LearnerID IS NULL OR @LearnerID <= 0
    BEGIN
        PRINT 'Error: Invalid LearnerID provided.';
        RETURN;
    END

    IF @Skill IS NULL OR LEN(@Skill) = 0
    BEGIN
        PRINT 'Error: Skill cannot be empty or null.';
        RETURN;
    END

    IF @Level IS NULL OR LEN(@Level) = 0
    BEGIN
        PRINT 'Error: Level cannot be empty or null.';
        RETURN;
    END

   
    IF NOT EXISTS (SELECT 1 FROM SkillProgression WHERE LearnerID = @LearnerID AND skill_name = @Skill)
    BEGIN
        PRINT 'Error: No matching record found for the given LearnerID and Skill.';
        RETURN;
    END

    
    UPDATE SkillProgression
    SET proficiency_level = @Level
    WHERE LearnerID = @LearnerID AND skill_name = @Skill;

    
END;


GO
CREATE PROCEDURE LeastBadge --18
    @LearnerID INT OUTPUT
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Achievement)
    BEGIN
        SET @LearnerID = NULL;
        RETURN;
    END;

   
    WITH BadgeCounts AS (
        SELECT LearnerID, COUNT(*) AS BadgeCount
        FROM Achievement
        GROUP BY LearnerID
    )
    SELECT TOP 1 @LearnerID = LearnerID
    FROM BadgeCounts
    WHERE BadgeCount = (SELECT MIN(BadgeCount) FROM BadgeCounts);
END;



GO
CREATE PROC PreferedType --19
 @type VARCHAR(50) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
  
    IF NOT EXISTS (SELECT 1 FROM LearningPrefrences)
    BEGIN
        PRINT 'Error: The LearningPrefrences table is empty.';
        SET @type = NULL; 
        RETURN;
    END
    
    IF @type IS NULL
    BEGIN
        PRINT 'Error: No valid preferences found in the LearningPrefrences table.';
        RETURN;
    END
    
    SELECT TOP 1 @type = prefrences
    FROM LearningPrefrences
    WHERE prefrences IS NOT NULL AND LEN(prefrences) > 0
    GROUP BY prefrences
    ORDER BY COUNT(prefrences) DESC, prefrences ASC;

    
END;


GO
CREATE PROC AssessmentAnalytics --20
    @CourseID INT,
    @ModuleID INT
AS
BEGIN
  
    IF NOT EXISTS (SELECT 1 FROM Course WHERE Course_ID = @CourseID)
    BEGIN
        PRINT 'Rejection: Course ID does not exist.';
        RETURN;
    END

   
    IF NOT EXISTS (SELECT 1 FROM Module WHERE Module_ID = @ModuleID AND Course_ID = @CourseID)
    BEGIN
        PRINT 'Rejection: Module ID does not exist for the specified Course.';
        RETURN;
    END

    
    SELECT 
        a.Assessment_ID,
        a.Module_ID,        
        c.Course_ID,
        COUNT(la.Learner_ID) AS NumberOfLearners,
        AVG(CAST(la.ScoredPoint AS FLOAT)) AS AverageScore,
        a.TotalMarks
    FROM 
        Assessment a
    INNER JOIN 
        Module m ON a.Module_ID = m.Module_ID
    INNER JOIN 
        Course c ON m.Course_ID = c.Course_ID
    LEFT JOIN 
        TakenAssessment la ON a.Assessment_ID = la.Assessment_ID ------xxxxxxxxx review this
    WHERE 
        m.Module_ID = @ModuleID AND c.Course_ID = @CourseID
    GROUP BY 
        a.Assessment_ID, a.Module_ID, m.title, c.title, a.TotalMarks,c.Course_ID
    ORDER BY 
        a.Assessment_ID;
END;
GO

CREATE PROCEDURE EmotionalTrendAnalysisIns  
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod datetime
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Course WHERE Course_ID = @CourseID)
    BEGIN
        PRINT 'Rejection: Course ID does not exist.';
        RETURN;
    END

    
    IF NOT EXISTS (SELECT 1 FROM Module WHERE Module_ID = @ModuleID AND Course_ID = @CourseID)
    BEGIN
        PRINT 'Rejection: Module ID does not exist for the specified Course.';
        RETURN;
    END
	else 
	begin
	select e.LearnerID ,e.emotional_state from Emotional_feedback e inner join learningActivity l on e.Activity_ID = l.Activity_ID
	inner join Teaches t on l.Course_ID = t.Course_ID where l.Module_ID = @ModuleID and t.Course_ID = @CourseID and e.timestamp = @TimePeriod
	end
END;



---------here is the start of the learner procedures



 
Go --1  --check the input (Edge cases)
CREATE PROC ProfileUpdate
    @LearnerID INT, @ProfileID INT, @PreferedContentType VARCHAR(50),@emotional_state VARCHAR(50), @PersonalityType VARCHAR(50)
    AS
	if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
	begin 
	print 'the learner does not exist'
	RETURN;
	end
	else
	begin
    UPDATE PersonalProfile
    SET 
		profileID = @ProfileID,
        PreferedContent_type = @PreferedContentType,
        emotionalState = @emotional_state,
        personality_type = @PersonalityType
     WHERE Learner_ID = @LearnerID;
	 end
GO

CREATE PROC TotalPoints --2 --check the input (Edge cases)
    @LearnerID INT,
    @RewardType VARCHAR(50)
AS
if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
RETURN;
end

else
if(not exists(select 1 from Reward where type = @RewardType))
begin 
print 'the reward type does not exist'
RETURN;
end
else
begin
    SELECT SUM(r.value) AS TotalPoints
    FROM Reward r inner join QuestReward q on r.RewardID = q.QuestID inner join
	Learner l on q.LearnerID = l.Learner_ID
    WHERE LearnerID = @LearnerID
    AND type = @RewardType;
end
GO

GO
CREATE PROC EnrolledCourses  --3 --check the input (Edge cases)
    @LearnerID INT
AS
if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
RETURN;
end
else
begin 
    SELECT c.*
    FROM Course c
    INNER JOIN Course_Enrollment e ON c.Course_ID = e.Course_ID
    WHERE e.Learner_ID = @LearnerID;
	end


    -- check to be reviewed 
GO
CREATE PROC Prerequisites --4 ----xxxxxxxxx
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
       if(not exists(select 1 from CoursePrerequisites where Course_ID = @CourseID))
begin 
print 'the course does not exist'
RETURN;
end
else
if(exists(select p.* from CoursePrerequisites p inner join Course_Enrollment ce on p.Course_ID = ce.Course_ID where 
 ce.Learner_ID = @LearnerID and p.Course_ID = @CourseID and p.prerequisite = (select prerequisite from CoursePrerequisites)))
begin 
print 'All prerequisites are completed.'
RETURN;
end
else 
begin 
PRINT 'Not all prerequisites are completed.'
END
END


GO
CREATE PROC Moduletraits--5  --check the input (Edge cases)if it exists
    @TargetTrait VARCHAR(50), 
    @CourseID INT
AS
	if(not exists(select 1 from TargetTraits where trait = @TargetTrait))
	begin 
	print 'the trait does not exist'
	end
	else
	if(not exists(select 1 from Module where Course_ID = @CourseID))
	begin 
	print 'the course does not exist in the module'
	RETURN;
	end
	else
	begin 
    SELECT m.*
    FROM Module m
    INNER JOIN TargetTraits tt ON m.Module_ID = tt.Module_ID
    WHERE tt.trait = @TargetTrait 
    AND m.Course_ID = @CourseID;
END;

GO
CREATE PROC LeaderboardRank  --6  --check the input (Edge cases)
    @LeaderboardID INT
    AS 
	if(not exists(select 1 from Ranking where BoardID = @LeaderboardID))
	begin 
	print 'the board does not exist'
	RETURN;
	end
	else
	begin
    SELECT l.*,r.rank
    FROM learner l inner join Ranking r on l.Learner_ID = r.LearnerID
    WHERE r.BoardID = @LeaderboardID
    ORDER BY r.rank; 
	end
GO
CREATE PROC ActivityEmotionalFeedback  --7
    @ActivityID INT,
    @LearnerID INT,
    @timestamp Time,
    @emotionalstate VARCHAR(50)
AS
BEGIN
    -- Check if the activity exists
    IF NOT EXISTS (SELECT 1 FROM learningActivity WHERE Activity_ID = @ActivityID)
    BEGIN 
        PRINT 'Rejection: The activity does not exist.';
        RETURN;
    END

    -- Check if feedback already exists for this ActivityID and LearnerID
    IF EXISTS (SELECT 1 FROM Emotional_feedback WHERE Activity_ID = @ActivityID AND LearnerID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Emotional feedback already submitted for this activity and learner.';
        RETURN;
    END

    -- Insert emotional feedback
    INSERT INTO Emotional_feedback (Activity_ID, LearnerID, timestamp, emotional_state)
    VALUES (@ActivityID, @LearnerID, @timestamp, @emotionalstate);

END;

    

GO
CREATE PROC JoinQuest @LearnerID INT, @QuestID INT 
AS 
BEGIN 
 IF NOT EXISTS ( SELECT 1 FROM Collaborative c LEFT JOIN 
( SELECT QuestID, COUNT(LearnerID) AS ParticipantCount FROM LearnerCollaboration GROUP BY QuestID ) 
l ON c.QuestID = l.QuestID WHERE c.QuestID = @QuestID AND ISNULL(l.ParticipantCount, 0) < c.Max_Num_Participants )
BEGIN PRINT('There is no space for another quest') 
END 
ELSE 
BEGIN -- Insert the new participant 
INSERT INTO LearnerCollaboration (LearnerID, QuestID, completion_status) 
VALUES (@LearnerID, @QuestID, 'Not Started') 
PRINT('You joined the collaboration successfully')
END 
END
GO

CREATE PROCEDURE SkillsProficiency   --9  handle the skill as an edge case
    @LearnerID INT
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END
	else
   begin
    SELECT proficiency_level from SkillProgression
	where LearnerID = @LearnerID
    END  
END;

GO
CREATE PROC Viewscore --10  
    @LearnerID INT,
    @AssessmentID INT,
    @score INT OUTPUT
AS
BEGIN
IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END
	IF NOT EXISTS (SELECT 1 FROM Assessment WHERE Assessment_ID = @AssessmentID)
    BEGIN
        PRINT 'Rejection: assesment ID does not exist.';
        RETURN;
    END

	else
   begin
    SELECT @score = ScoredPoint
    FROM Takenassessment where
	Assessment_ID = @AssessmentID
	and Learner_ID = @LearnerID
    
END;
END;
GO
CREATE PROC AssessmentsList --11
    @CourseID INT,
    @ModuleID INT,
    @LearnerID INT
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Assessment WHERE Course_ID = @CourseID AND Module_ID = @ModuleID)
    BEGIN
        PRINT 'Error: No assessments found for the given CourseID and ModuleID.';
        RETURN;
    END

SELECT ScoredPoint,ta.Assessment_ID from TakenAssessment ta Inner join Assessment a ON ta.Assessment_ID=a.Assessment_ID

WHERE a.Module_ID=@ModuleID AND a.Course_ID=@CourseID And ta.Learner_ID=@LearnerID
 

   
        END

GO
CREATE PROC Courseregister --12 
@LearnerID INT,
@CourseID INT
AS
DECLARE @CourseExists BIT;
DECLARE @AlreadyEnrolled BIT;
BEGIN
SELECT @CourseExists = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
FROM Course
WHERE Course_ID = @CourseID;
SELECT @AlreadyEnrolled = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
FROM Course_Enrollment
WHERE Learner_ID = @LearnerID AND Course_ID = @CourseID;

IF @CourseExists = 0
BEGIN
PRINT 'Rejection: Course does not exist.';
IF @CourseExists = 1
BEGIN
IF @AlreadyEnrolled = 0
PRINT 'Approval: Course successfully registered.';
ELSE
PRINT 'Rejection: Learner is already enrolled in this course.';
END

END

	INSERT INTO Course_Enrollment (Learner_ID, Course_ID)
	VALUES (@LearnerID, @CourseID);
	print('Registed')
END;

GO
CREATE PROC Post --13
    @LearnerID INT,
    @DiscussionID INT,
    @Post VARCHAR(MAX)
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Error: Learner does not exist.';
        RETURN;
    END;

    
    IF NOT EXISTS (SELECT 1 FROM Discussion_forum WHERE forumID = @DiscussionID)
    BEGIN
        PRINT 'Error: Discussion forum does not exist.';
        RETURN;
    END;

   
    IF @Post IS NULL OR LTRIM(RTRIM(@Post)) = ''
    BEGIN
        PRINT 'Error: Post content cannot be empty.';
        RETURN;
    END;

    
    BEGIN 
        INSERT INTO LearnerDiscussion (ForumID, LearnerID, post, time)
        VALUES (@DiscussionID, @LearnerID, @Post, GETDATE());
        END
END;


Go
CREATE PROC AddGoal
    @LearnerID INT,
    @GoalID INT
AS
BEGIN
    -- Validate LearnerID
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END;

    -- Validate GoalID
    IF NOT EXISTS (SELECT 1 FROM Learning_goal WHERE ID = @GoalID)
    BEGIN
        PRINT 'Rejection: Goal ID does not exist.';
        RETURN;
    END;

    -- Check for Duplicate Entry
    IF EXISTS (SELECT 1 FROM LearnersGoals WHERE GoalID = @GoalID AND LearnerID = @LearnerID)
    BEGIN
        PRINT 'Rejection: This goal is already assigned to the learner.';
        RETURN;
    END;

    -- Insert into LearnersGoals
    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);

    
END;
GO
CREATE PROC QuestMembers --16 
	@LearnerId int
    AS
    BEGIN
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerId)
    BEGIN
		PRINT 'Rejection: Learner ID does not exist.';
		RETURN;
	END
    DECLARE @QuestID INT
    DECLARE @DEADLINE DATE
    SELECT LearnerID= @LearnerId FROM LearnerCollaboration l INNER JOIN Collaborative c ON  l.QuestID=c.QuestID

 	WHERE Deadline > @DEADLINE
	
	END;

GO
   CREATE PROC QuestProgress  --17 
    @LearnerID INT
AS
BEGIN
    -- Validate that the Learner ID exists
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END;

    -- Retrieve quest progress for the learner
    SELECT 
        q.QuestID AS QuestID,
        q.title AS QuestTitle,
        CASE 
            WHEN qr.QuestID IS NOT NULL THEN 'Completed'
            ELSE 'In Progress'
        END AS CompletionStatus
    FROM 
        Quest q
    LEFT JOIN 
        QuestReward qr ON q.QuestID = qr.QuestID AND qr.LearnerID = @LearnerID;

    -- Retrieve badge progress for the learner
    SELECT 
        b.BadgeID AS BadgeID,
        b.title AS BadgeTitle,
        a.Type AS BadgeType,
        CASE 
            WHEN a.BadgeID IS NOT NULL THEN 'Earned'
            ELSE 'Not Earned'
        END AS BadgeStatus
    FROM 
        Badge b
    LEFT JOIN 
        Achievement a ON b.BadgeID = a.BadgeID AND a.LearnerID = @LearnerID;
END;
GO


GO
CREATE PROCEDURE GoalReminder
    @LearnerID INT
AS
BEGIN
   
    DECLARE @ReminderMessage VARCHAR(MAX);
    DECLARE @UrgencyLevel VARCHAR(50);
  
    IF NOT EXISTS (SELECT 1 FROM LearnersGoals WHERE LearnerID = @LearnerID)
    BEGIN
        PRINT 'No goals found for the given learner.';
        RETURN;
    END
    
    INSERT INTO Notification (message, urgency, readstatus)
    SELECT 
        CONCAT(
            'Reminder: Goal "', lg.description, 
            '" is past its deadline of ',  
            '. Please update your progress!'
        ) AS message,
        CASE 
            WHEN DATEDIFF(DAY, lg.deadline, GETDATE()) <= 7 THEN 'Medium'
            ELSE 'High'
        END AS urgency,
        0 AS readstatus    FROM Learning_goal lg
    INNER JOIN LearnersGoals lgmap ON lg.ID = lgmap.GoalID
    WHERE lgmap.LearnerID = @LearnerID
      AND lg.status != 'Completed' 
      AND lg.deadline < GETDATE(); 

  END;



    GO
CREATE PROC SkillProgressHistory --19
   @LearnerID INT, 
    @Skill VARCHAR(50)
AS
BEGIN
   
    IF @LearnerID IS NULL OR @Skill IS NULL OR TRIM(@Skill) = ''
    BEGIN
        PRINT 'Error: Invalid input. LearnerID and Skill must be provided.';
        RETURN;
    END
    
   
    IF NOT EXISTS (
        SELECT 1
        FROM SkillProgression sp
        WHERE sp.LearnerID = @LearnerID
    )
    BEGIN
        PRINT 'Error: LearnerID not found.';
        RETURN;
    END

    
    IF NOT EXISTS (
        SELECT 1
        FROM SkillProgression sp
        WHERE sp.LearnerID = @LearnerID
        AND sp.skill_name = @Skill
    )
    BEGIN
        PRINT 'Error: No data found for the specified LearnerID and Skill.';
        RETURN;
    END

   
    SELECT
        sp.LearnerID,
        sp.skill_name,
        sp.proficiency_level,
        sp.timestamp
    FROM 
        SkillProgression sp
    WHERE
        sp.LearnerID = @LearnerID
        AND sp.skill_name = @Skill
    ORDER BY 
        sp.timestamp;
END;

GO
   CREATE PROC AssessmentAnalysis --20
	@AssessmentID INT,
    @LearnerID INT
	AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END;

    
    IF NOT EXISTS (SELECT 1 FROM Assessment WHERE Assessment_ID = @AssessmentID)
    BEGIN
        PRINT 'Rejection: Assessment ID does not exist.';
        RETURN;
    END;

   
    IF NOT EXISTS (SELECT 1 FROM TakenAssessment WHERE Assessment_ID = @AssessmentID AND Learner_ID = @LearnerID)  --i made it from taken assessment table 
    BEGIN
        PRINT 'Rejection: Learner has not taken this assessment.';
        RETURN;
    END;

    -- Overall assessment details
    SELECT 
        ta.Assessment_ID,
        
        ta.ScoredPoint AS LearnerScore,
        a.totalMarks AS MaxMarks,
        CAST((CAST(ta.ScoredPoint AS FLOAT) / a.TotalMarks) * 100 AS DECIMAL(5, 2)) AS Percentage,
        CASE                                                                                         ---handle opinion case is an option
            WHEN ta.ScoredPoint >= (0.9 * a.TotalMarks) THEN 'Excellent'
            WHEN ta.ScoredPoint >= (0.75 * a.TotalMarks) THEN 'Good'
            WHEN ta.ScoredPoint >= (0.5 * a.TotalMarks) THEN 'Average'
            ELSE 'Needs Improvement'
        END AS Performance
        
    FROM 
        TakenAssessment ta
    INNER JOIN 
        Assessment a ON ta.Assessment_ID = a.Assessment_ID
    WHERE 
        ta.Assessment_ID = @AssessmentID AND ta.Learner_ID = @LearnerID; 

END;
GO

CREATE PROC LeaderboardFilter
    @LearnerID INT
AS
BEGIN
   if(not exists(select 1 from Ranking where LearnerID = @LearnerID))
   begin
   print('cannot find the learner')
   end
   else
   begin
   select r.rank,l.BoardID from Leaderboard l inner join Ranking r on r.BoardID = l.BoardID
   where r.LearnerID = @LearnerID
   order by r.rank desc 
   
   end
END;
GO

