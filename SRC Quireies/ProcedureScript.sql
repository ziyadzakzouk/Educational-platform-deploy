use nope  --please put bit variable and inseart if stats to handle ege case

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
@courseID int 
AS
if(not exists(select 1 from Course where Course_ID = @courseID))
begin 
print 'the course does not exist'
end
else 
begin
delete from Course where @courseID = Course_ID
end
go
Go
CREATE PROC Highestgrade --7
AS
begin
select MAX(totalMarks) from Assessment
group by Course_ID
end
go
Go
CREATE view InstructorCount --8
AS
select c.* from Course c inner join Teaches t on c.Course_ID = t.Course_ID
where count(t.Instructor_ID)>1

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

    
    IF NOT EXISTS (SELECT 1 FROM Assessment WHERE Course_ID IN (SELECT Course_ID FROM Course WHERE LearnerID = @LearnerID) AND Assessment_ID = @AssessmentID)
    BEGIN
        PRINT 'Error: Assessment is not linked to this Learner.';
        RETURN;
    END

    
    IF @Newgrade < 0 OR @Newgrade > (SELECT totalMarks FROM Assessment WHERE Assessment_ID = @AssessmentID)
    BEGIN
        PRINT 'Error: Invalid grade value.';
        RETURN;
    END

   
    UPDATE Assessment 
    SET totalMarks = @Newgrade 
    WHERE LearnerID = @LearnerID AND Assessment_ID = @AssessmentID;

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
@timestamp TIMESTAMP,
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

    
    IF EXISTS (SELECT 1 FROM Notification WHERE Notification_ID = @NotificationID)
    BEGIN
        PRINT 'Error: Notification ID already exists.';
        RETURN;
    END

   
    IF @timestamp IS NULL
    BEGIN
        SET @timestamp = CURRENT_TIMESTAMP;
    END

    
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

   
    IF NOT EXISTS (SELECT 1 FROM Course WHERE Course_ID = @CourseID AND Instructor_ID = @InstructorID)
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
    SELECT C.title, L.first_name + ' ' + L.last_name AS LearnerName, L.email AS LearnerEmail
    FROM Course_Enrollment CE
    INNER JOIN Course C ON CE.Course_ID = C.Course_ID
    INNER JOIN Instructor I ON C.Instructor_ID = I.Instructor_ID
    INNER JOIN Learner L ON CE.Learner_ID = L.Learner_ID
    WHERE C.Course_ID = @CourseID AND I.Instructor_ID = @InstructorID;

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
            ProficiencyLevel
        FROM
            SkillProgression
        WHERE
            LearnerID = @LearnerID AND Skill = @Skill
        ORDER BY
            ProficiencyLevel DESC;
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

   
    IF NOT EXISTS (SELECT 1 FROM SkillProgression WHERE LearnerID = @LearnerID AND Skill = @Skill)
    BEGIN
        PRINT 'Error: No matching record found for the given LearnerID and Skill.';
        RETURN;
    END

    
    UPDATE SkillProgression
    SET proficiency_level = @Level
    WHERE LearnerID = @LearnerID AND Skill = @Skill;

    
END;



GO
CREATE PROC  LeastBadge --18
  @LearnerID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
  
    IF NOT EXISTS (SELECT 1 FROM LearnerBadges)
    BEGIN
        PRINT 'Error: The LearnerBadges table is empty.';
        SET @LearnerID = NULL;  
        RETURN;
    END
    
     IF @LearnerID IS NULL
    BEGIN
        PRINT 'Error: No learner found.';
    END
    ELSE
    BEGIN
		    
    SELECT TOP 1 @LearnerID = LearnerID
    FROM LearnerBadges
    GROUP BY LearnerID
    ORDER BY COUNT(BadgeID) ASC, LearnerID ASC;
    END
   
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
CREATE PROC AssessmentAnalytics --20  --check the from tables 
    @CourseID INT,
    @ModuleID INT
AS
BEGIN
  
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Course ID does not exist.';
        RETURN;
    END

   
    IF NOT EXISTS (SELECT 1 FROM Modules WHERE ModuleID = @ModuleID AND CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Module ID does not exist for the specified Course.';
        RETURN;
    END

    
    SELECT 
        a.AssessmentID,
        a.ModuleID,        
        c.CourseID,
        COUNT(la.LearnerID) AS NumberOfLearners,
        AVG(CAST(la.totalMarks AS FLOAT)) AS AverageScore,
        a.TotalMarks
    FROM 
        Assessments a
    INNER JOIN 
        Modules m ON a.ModuleID = m.ModuleID
    INNER JOIN 
        Courses c ON m.CourseID = c.CourseID
    LEFT JOIN 
        LearnerAssessments la ON a.AssessmentID = la.AssessmentID ------xxxxxxxxx review this
    WHERE 
        m.ModuleID = @ModuleID AND c.CourseID = @CourseID
    GROUP BY 
        a.AssessmentID, a.ModuleID, m.ModuleName, c.CourseName, a.TotalMarks
    ORDER BY 
        a.AssessmentID;
END;
GO

CREATE PROCEDURE EmotionalTrendAnalysis  
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod VARCHAR(50)
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Course ID does not exist.';
        RETURN;
    END

    
    IF NOT EXISTS (SELECT 1 FROM Module WHERE ModuleID = @ModuleID AND CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Module ID does not exist for the specified Course.';
        RETURN;
    END

   
    DECLARE @StartDate DATETIME;
    IF @TimePeriod = 'LAST_MONTH'
        SET @StartDate = DATEADD(MONTH, -1, GETDATE());
    ELSE IF @TimePeriod = 'LAST_WEEK'
        SET @StartDate = DATEADD(WEEK, -1, GETDATE());
    ELSE IF @TimePeriod = 'ALL_TIME'
        SET @StartDate = NULL;

   
    SELECT 
        ef.timestamp,
        ef.emotional_state,
        COUNT(ef.FeedbackID) AS FeedbackCount
    FROM 
        EmotionalFeedback ef
    INNER JOIN 
        Module m ON ef.ModuleID = m.ModuleID
    INNER JOIN 
        Course c ON ef.CourseID = c.CourseID
    WHERE 
        ef.CourseID = @CourseID
        AND ef.ModuleID = @ModuleID
        AND (@StartDate IS NULL OR ef.timestamp >= @StartDate)
    GROUP BY 
        ef.timestamp, ef.emotional_state
    ORDER BY 
        ef.timestamp;
END;
GO



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
CREATE PROC ViewMyDeviceCharge  --7 --------needs to be reviewed
    @ActivityID INT,
    @LearnerID INT,
    @timestamp DATETIME,
    @emotionalstate VARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM learningActivity WHERE Activity_ID = @ActivityID)
    BEGIN 
        PRINT 'The activity does not exist';
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO Emotional_feedback(LearnerID, timestamp, emotional_state)
        VALUES (@LearnerID, @timestamp, @emotionalstate);
    END
END;
    


GO
CREATE PROC JoinQuest
    @LearnerID INT,
    @QuestID INT
AS
BEGIN
    DECLARE @CurrentParticipants INT;
    DECLARE @MaxParticipants INT;
    DECLARE @AlreadyJoined BIT;

   
    
    SELECT 
        @CurrentParticipants = COUNT(*),
        @MaxParticipants = Max_Num_Participants
    FROM  Collaborative qp
    JOIN Quest q ON qp.QuestID = q.QuestID
    WHERE q.QuestID = @QuestID;


    SELECT 
        @AlreadyJoined = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM Collaborative
    WHERE QuestID = @QuestID AND LearnerID = @LearnerID;

   
    IF @AlreadyJoined = 1
    BEGIN
        PRINT 'Rejection: Learner has already joined this quest.';
        RETURN;
    END
	else
    IF @CurrentParticipants >= @MaxParticipants
    BEGIN
        PRINT 'Rejection: Quest is already at full capacity.';
        RETURN;
    END
	else
    
    INSERT INTO QuestParticipants (QuestID, LearnerID)
    VALUES (@QuestID, @LearnerID);

    PRINT 'Approval: Learner successfully joined the quest.';
END;
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
WHERE CourseID = @CourseID;
SELECT @AlreadyEnrolled = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
FROM Enrollments
WHERE LearnerID = @LearnerID AND CourseID = @CourseID;

IF CourseExists = 0
BEGIN
PRINT 'Rejection: Course does not exist.';
IF CourseExists = 1
BEGIN
IF AlreadyEnrolled = 0
PRINT 'Approval: Course successfully registered.';
ELSE
PRINT 'Rejection: Learner is already enrolled in this course.';
END

END

	INSERT INTO Enrollments (LearnerID, CourseID, CompletionStatus)
	VALUES (@LearnerID, @CourseID, 'Registered');
END;

GO
CREATE PROC Post --13
    @LearnerID INT,
    @DiscussionID INT,
    @Post VARCHAR(MAX)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID )
    BEGIN
		PRINT 'Rejection: Learner ID does not exist.';
		RETURN;
	END
    IF NOT EXISTS (SELECT 1 FROM Discussion_forum WHERE forumID = @DiscussionID)
    BEGIN
    PRINT 'Rejection: Discussion ID does not exist.';
    RETURN;
	END

    INSERT INTO Posts (LearnerID, DiscussionID, PostContent, Timestamp)
    VALUES (@LearnerID, @DiscussionID, @Post, GETDATE());
    UPDATE Discussion_forum
    SET last_active = GETDATE()
    WHERE forumID = @DiscussionID;
END;

Go
CREATE PROC AddGoal  --14
    @LearnerID INT,
    @GoalID INT
AS
BEGIN
IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
	BEGIN
		PRINT 'Rejection: Learner ID does not exist.';
		RETURN;
	END
    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);
END;

GO
CREATE PROC CurrentPath --15 
    @LearnerID INT
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
    PRINT 'Rejection: Learner ID does not exist.';
		RETURN;
	END
    SELECT 
        Path_ID AS LearningPathID,
        completion_status AS Status
    FROM 
        LearningPath
    WHERE 
        Learner_ID = @LearnerID;
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


    CREATE PROC QuestProgress --17 ----------XXXXXXXXXXXXXX review please (Issue)
    @LearnerID INT,
    @QuestID INT
    AS
    BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Quest WHERE QuestID = @QuestID)
    BEGIN
		PRINT 'Rejection: Quest ID does not exist.';
		RETURN;
	END

    SELECT 
        q.QuestID AS QuestID,
       
         AS CompletionStatus
    FROM 
       QuestReward qp
    INNER JOIN 
        Quest q ON qp.QuestID = q.QuestID
    WHERE 
        qp.LearnerID = @LearnerID AND qp.QuestID = @QuestID;

   
    SELECT 
        b.BadgeID AS BadgeID,
        b.BadgeName AS BadgeName,
        lb.DateEarned AS DateEarned
    FROM 
       Achievement lb
    INNER JOIN 
        Badges b ON lb.BadgeID = b.BadgeID
    WHERE 
        lb.LearnerID = @LearnerID;
END;
GO

CREATE PROC GoalReminder --18 ## critical
    @LearnerID INT
AS
BEGIN
    DECLARE @CurrentDate DATETIME;
    SET @CurrentDate = GETDATE();

    -- Select goals that are past their deadline and not completed
    SELECT 
        GoalID,
        description,
        deadline
    INTO #OverdueGoals
    FROM 
        LearnersGoals
    WHERE 
        Learner_ID = @LearnerID AND
        deadline < @CurrentDate AND
        status != 'Completed';

    -- Check if there are any overdue goals
    IF EXISTS (SELECT 1 FROM #OverdueGoals)
    BEGIN
        DECLARE @GoalID INT, @Description VARCHAR(MAX), @Deadline DATETIME;
        DECLARE @Message VARCHAR(MAX);

        -- Loop through each overdue goal and send a notification
        DECLARE GoalCursor CURSOR FOR
        SELECT GoalID, description, deadline FROM #OverdueGoals;

        OPEN GoalCursor;
        FETCH NEXT FROM GoalCursor INTO @GoalID, @Description, @Deadline;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @Message = 'Reminder: You are falling behind on your learning goal: ' + @Description + 
                           '. The deadline was ' + CONVERT(VARCHAR, @Deadline, 101) + '.';

            -- Insert the notification into the Notifications table
            INSERT INTO Notification (LearnerID, Timestamp, Message, UrgencyLevel)
            VALUES (@LearnerID, @CurrentDate, @Message, 'High');

            FETCH NEXT FROM GoalCursor INTO @GoalID, @Description, @Deadline;
        END;

        CLOSE GoalCursor;
        DEALLOCATE GoalCursor;
    END
    ELSE
    BEGIN
        PRINT 'No overdue learning goals found for the learner.';
    END

    -- Clean up temporary table
    DROP TABLE #OverdueGoals;
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
        AND sp.Skill = @Skill
    )
    BEGIN
        PRINT 'Error: No data found for the specified LearnerID and Skill.';
        RETURN;
    END

   
    SELECT
        sp.LearnerID,
        sp.Skill,
        sp.proficiency_level,
        sp.DateRecorded
    FROM 
        SkillProgression sp
    WHERE
        sp.LearnerID = @LearnerID
        AND sp.Skill = @Skill
    ORDER BY 
        sp.DateRecorded;
END;

GO
   CREATE PROC AssessmentAnalysis --20
	@AssessmentID INT,
    @LearnerID INT
	AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learners WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END;

    
    IF NOT EXISTS (SELECT 1 FROM Assessments WHERE AssessmentID = @AssessmentID)
    BEGIN
        PRINT 'Rejection: Assessment ID does not exist.';
        RETURN;
    END;

   
    IF NOT EXISTS (SELECT 1 FROM TakenAssessment WHERE AssessmentID = @AssessmentID AND LearnerID = @LearnerID)  --i made it from taken assessment table 
    BEGIN
        PRINT 'Rejection: Learner has not taken this assessment.';
        RETURN;
    END;

    -- Overall assessment details
    SELECT 
        ta.AssessmentID,
        a.AssessmentName,
        ta.Score AS LearnerScore,
        a.TotalMarks AS MaxMarks,
        CAST((CAST(ta.Score AS FLOAT) / a.TotalMarks) * 100 AS DECIMAL(5, 2)) AS Percentage,
        CASE                                                                                         ---handle opinion case is an option
            WHEN ta.Score >= (0.9 * a.TotalMarks) THEN 'Excellent'
            WHEN ta.Score >= (0.75 * a.TotalMarks) THEN 'Good'
            WHEN ta.Score >= (0.5 * a.TotalMarks) THEN 'Average'
            ELSE 'Needs Improvement'
        END AS Performance,
        ta.AttemptDate
    FROM 
        TakenAssessment ta
    INNER JOIN 
        Assessments a ON ta.AssessmentID = a.AssessmentID
    WHERE 
        ta.AssessmentID = @AssessmentID AND ta.LearnerID = @LearnerID;

    
    SELECT 
        s.SectionName,
        ts.Score AS LearnerScore,
        s.Weightage AS TotalWeightage,
        CAST((CAST(ts.Score AS FLOAT) / s.Weightage) * 100 AS DECIMAL(5, 2)) AS Percentage   ---get overall score
    FROM 
        AssessmentSections s
    INNER JOIN 
        TakenSection ts ON s.SectionID = ts.SectionID AND s.AssessmentID = ts.AssessmentID
    WHERE 
        ts.LearnerID = @LearnerID AND s.AssessmentID = @AssessmentID;

END;
GO

CREATE PROC LeaderboardFilter
    @LearnerID INT
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learners WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    
    SELECT 
        l.LearnerID,
        l.Name AS LearnerName,
        lb.Rank,
        lb.Score
    FROM 
        Leaderboard lb
    INNER JOIN 
        Learners l ON lb.LearnerID = l.LearnerID
    WHERE 
        lb.Rank >= (SELECT Rank FROM Leaderboard WHERE LearnerID = @LearnerID)
    ORDER BY 
        lb.Rank DESC;
END;
GO






