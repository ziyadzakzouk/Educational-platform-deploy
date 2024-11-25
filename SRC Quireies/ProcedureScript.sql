use EduPlatform  --please put bit variable and inseart if stats to handle ege case

Go
CREATE PROC ViewInfo   --handle the edge cases from the input till the validation
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
CREATE PROC LearnerInfo
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
CREATE PROC EmotionalState
@LearnerID int,
 @emotional_state varchar(50) output
AS

if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
end
else 
begin
select @emotional_state = emotional_state from Emotional_feedback 
where Learner_ID = @LearnerID
end


Go
CREATE PROC LogDetails
@LearnerID int
AS

if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
end
else
begin
select * from Interaction_log 
where Learner_ID = @LearnerID
end


Go
CREATE PROC InstructorReview
@InstructorID int
AS

if(not exists(select 1 from Instructor where InstructorID = @InstructorID))
begin 
print 'the instructor does not exist'
end
else 
begin
select e.* from Emotional_feedback e inner join Emotionalfeedback_review er
on er.FeedbackID = e.FeedbackID where @InstructorID = er.InstructorID
end


Go
CREATE PROC CourseRemove
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

Go
CREATE PROC Highestgrade 
AS
select MAX(totalMarks) from Assessment
group by Course_ID

Go
CREATE PROC InstructorCount 
AS
select c.* from Course c inner join Teaches t on c.Course_ID = t.Course_ID
where count(t.Instructor_ID)>1

Go
CREATE PROC ViewNot 
@LearnerID int
AS
if(not exists(select 1 from Learner where Learner_ID = @LearnerID))
begin 
print 'the learner does not exist'
end
else
begin
select n.* from Notification n inner join RecivedNotfy r on n.Notification_ID = r.Notification_ID
where @LearnerID = r.Learner_ID
end

Go
CREATE PROC CreateDiscussion --some discussion attributes need to be null and the forumid need to be identity
@ModuleID int, @courseID int, @title varchar(50), @description varchar(50)
AS
insert into Discussion_forum(Module_ID,Course_ID,title,description) values (@ModuleID, @courseID, @title, @description)

Go
CREATE PROC RemoveBadge
@BadgeID int
AS
if(not exists(select 1 from Badge where BadgeID = @BadgeID))
begin 
print 'the learner does not exist'
end
else
begin
delete from Badge where BadgeID = @BadgeID
end

Go
CREATE PROC CriteriaDelete
@criteria varchar(50) 
AS
if(not exists(select 1 from Quest where criteria = @criteria))
begin 
print 'the learner does not exist'
end
else
begin
delete from Quest where criteria = @criteria
end

Go
CREATE PROC NotificationUpdate -- needs to be reviewed -------------------------------------------------------
@LearnerID int, @NotificationID int, @ReadStatus bit
AS
if @ReadStatus = 1 
begin
delete from Notification where @NotificationID = Notification_ID
end


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

Go
CREATE PROC CollaborativeQuest  --7
@difficulty_level varchar(50),
@criteria varchar(50),
@description varchar(50), 
@title varchar(50), 
@Maxnumparticipants int, 
@deadline datetime
AS  
BEGIN  
    
    IF @difficulty_level IS NULL OR @difficulty_level <= 0  
    BEGIN  
        PRINT 'Error: Difficulty level must be a positive integer.';  
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

    
    INSERT INTO Quest (difficulty_level, criteria, description, title)  
    VALUES (@difficulty_level, @criteria, @description, @title);  

    -- Get the newly generated QuestID  
    DECLARE @QuestID INT = SCOPE_IDENTITY();  

    INSERT INTO Collaborative (QuestID, Deadline, Max_Num_Participants)  
    VALUES (@QuestID, @deadline, @Maxnumparticipants);  

    PRINT 'Collaborative quest created successfully.';  
END;

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

    
    IF NOT EXISTS (SELECT 1 FROM Assessment WHERE Course_ID IN (SELECT Course_ID FROM Course WHERE Learner_ID = @LearnerID) AND Assessment_ID = @AssessmentID)
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
    UPDATE PersonalProfile
    SET 
        PreferedContent_type = @PreferedContentType,
        emotionalState = @EmotionalState,
        personality_type = @PersonalityType
     WHERE Learner_ID = @LearnerID AND profileID = @ProfileID;
GO

CREATE PROC TotalPoints --2 --check the input (Edge cases)
    @LearnerID INT,
    @RewardType VARCHAR(50)
AS
    SELECT SUM(value) AS TotalPoints
    FROM Rewards
    WHERE LearnerID = @LearnerID
    AND RewardType = @RewardType;
GO

GO
CREATE PROC EnrolledCourses  --3 --check the input (Edge cases)
    @LearnerID INT
AS
    SELECT c.CourseID, c.CourseName, c.Description, c.CreditHours
    FROM Course c
    INNER JOIN Enrollments e ON c.CourseID = e.CourseID
    WHERE e.LearnerID = @LearnerID;


    -- check to be reviewed 
GO
CREATE PROC Prerequisites --4 ----xxxxxxxxx
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
    -- Check if the learner has completed all prerequisites for the given course
    DECLARE @PrerequisitesCompleted INT;

    -- Count the prerequisites for the course
    SELECT @PrerequisitesCompleted = COUNT(*)
    FROM Prerequisites p
    INNER JOIN Enrollments e ON p.PrerequisiteCourseID = e.CourseID
    WHERE e.LearnerID = @LearnerID
    AND e.CompletionStatus = 'Completed'  -- Assuming 'Completed' is a value in the CompletionStatus column
    AND p.CourseID = @CourseID;

    -- If all prerequisites are completed, return a message
    IF @PrerequisitesCompleted = (SELECT COUNT(*) FROM Prerequisites WHERE CourseID = @CourseID)
    BEGIN
        SELECT 'All prerequisites completed.' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Prerequisites not completed.' AS Message;
    END
END


GO
CREATE PROC Moduletraits--5  --check the input (Edge cases)if it exists
    @TargetTrait VARCHAR(50), 
    @CourseID INT
AS
BEGIN
   
    SELECT m.Module_ID, m.title, m.difficulty_level
    FROM Module m
    INNER JOIN TargetTraits tt ON m.Module_ID = tt.Module_ID
    WHERE tt.trait = @TargetTrait 
    AND m.Course_ID = @CourseID;
END;

GO
CREATE PROC LeaderboardRank  --6  --check the input (Edge cases)
    @LeaderboardID INT
    AS  
    SELECT r.LearnerID, r.CourseID, r.rank, r.total_points
    FROM Ranking r
    WHERE r.BoardID = @LeaderboardID
    ORDER BY r.rank; 


GO
CREATE PROC ViewMyDeviceCharge  --7
    @ActivityID INT,
    @LearnerID INT,
    @timestamp DATETIME,
    @emotionalstate VARCHAR(50)
AS
BEGIN
    INSERT INTO Emotional_feedback (LearnerID, timestamp, emotional_state)
    VALUES (@LearnerID, @timestamp, @emotionalstate);
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

    IF @CurrentParticipants >= @MaxParticipants
    BEGIN
        PRINT 'Rejection: Quest is already at full capacity.';
        RETURN;
    END

    
    INSERT INTO QuestParticipants (QuestID, LearnerID)
    VALUES (@QuestID, @LearnerID);

    PRINT 'Approval: Learner successfully joined the quest.';
END;
GO



GO

CREATE PROCEDURE SkillsProficiency   --8  handle the skill as an edge case
    @LearnerID INT
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

   
    SELECT 
        s.skill AS Skill,
        sp.ProficiencyLevel AS ProficiencyLevel
    FROM 
        Skills s,SkillProgression
    LEFT JOIN 
        SkillProficiency sp ON s.Learner_ID = sp.Learner_ID AND s.skill = sp.skill
    WHERE 
        s.Learner_ID = @LearnerID;
END;
GO



GO
CREATE PROC Viewscore --10  --check the input (Edge cases)
    @LearnerID INT,
    @AssessmentID INT,
    @score INT OUTPUT
AS
BEGIN
    SELECT @score = s.score
    FROM Scores s
    WHERE s.LearnerID = @LearnerID AND s.AssessmentID = @AssessmentID;

    -- If no score found, set the score to NULL
    IF @score IS NULL
    BEGIN
        SET @score = -1; 
    END
END;


GO
CREATE PROC AssessmentsList --11
    @CourseID INT,
    @ModuleID INT
AS
BEGIN

    SELECT 
        a.Assessment_ID,
        a.title AS AssessmentTitle,
        s.score AS Grade
    FROM 
        Assessment a
    LEFT JOIN 
        Scores s ON a.Assessment_ID = s.Assessment_ID
    WHERE 
        a.Course_ID = @CourseID 
        AND a.Module_ID = @ModuleID;
END;

GO
CREATE PROC Courseregister --12  EDge case could be handled almost completly
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
    -- Insert the post into the Posts table
    INSERT INTO Posts (LearnerID, DiscussionID, PostContent, Timestamp)
    VALUES (@LearnerID, @DiscussionID, @Post, GETDATE());
    UPDATE Discussion_forum
    SET last_active = GETDATE()
    WHERE forumID = @DiscussionID;
END;

Go
CREATE PROC AddGoal  --14 --check the input (Edge cases)
    @LearnerID INT,
    @GoalID INT
AS
BEGIN
    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);
END;

GO
CREATE PROC CurrentPath --15 --check the input (Edge cases)
    @LearnerID INT
AS
    SELECT 
        Path_ID AS LearningPathID,
        completion_status AS Status
    FROM 
        LearningPath
    WHERE 
        Learner_ID = @LearnerID;
GO
CREATE PROC QuestMembers --16 --check the input (Edge cases)
	@LearnerId int
    AS
    BEGIN
    DECLARE @QuestID INT
    DECLARE @DEADLINE DATE
    SELECT LearnerID= @LearnerId FROM Learner
    SELECT QuestID, Deadline FROM Collaborative
	WHERE QuestID = @QuestID AND Deadline > @DEADLINE
	
	END;

    GO


    CREATE PROC QuestProgress --17
    @LearnerID INT,
    @QuestID INT
    AS
    BEGIN
     -- Validate if the learner exists
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    -- Fetch quest progress
    SELECT 
        q.QuestID AS QuestID,
        q.QuestName AS QuestName,
        qp.CompletionStatus AS CompletionStatus
    FROM 
       QuestReward qp
    INNER JOIN 
        Quest q ON qp.QuestID = q.QuestID
    WHERE 
        qp.LearnerID = @LearnerID AND qp.QuestID = @QuestID;

    -- Fetch badges earned by the learner
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

CREATE PROC GoalReminder --18 --check the input (Edge cases)
	@LearnerID INT,
    @GoalID INT
    AS
    BEGIN
    DECLARE @Deadline DATE;
    SELECT Deadline = @Deadline FROM Learning_goal
	WHERE GoalID = @GoalID AND Deadline > @Deadline
	END;

    GO
CREATE PROC SkillProgressHistory --19
    @LearnerId INT,
    @Skill VARCHAR(50)
    AS
    BEGIN
    SELECT  LearnerID = @LearnerId ,Skill = @Skill, ProficiencyLevel, Timestamp
    FROM SkillProgression
	END;

   GO
   CREATE PROC AssessmentAnalysis --20
	@AssessmentID INT,
    @LearnerID INT
	AS
	BEGIN
	 -- Validate Learner ID
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    -- Validate Assessment ID
    IF NOT EXISTS (SELECT 1 FROM Assessments WHERE AssessmentID = @AssessmentID)
    BEGIN
        PRINT 'Rejection: Assessment ID does not exist.';
        RETURN;
    END

    -- Fetch Assessment Overview
    SELECT 
        a.AssessmentID,
        a.AssessmentName,
        la.TotalScore,
        a.TotalMarks
    FROM 
        Assessments a
    LEFT JOIN 
        LearnerAssessments la ON a.AssessmentID = la.AssessmentID
    WHERE 
        a.AssessmentID = @AssessmentID AND la.LearnerID = @LearnerID;

    -- Fetch Section-wise Breakdown
    SELECT 
        s.SectionName,
        ss.Score AS LearnerScore,
        s.Weightage AS TotalWeightage,
        CAST((CAST(ss.Score AS FLOAT) / s.Weightage) * 100 AS DECIMAL(5, 2)) AS Percentage
    FROM 
        AssessmentSections s
    LEFT JOIN 
        SectionScores ss ON s.SectionID = ss.SectionID AND s.AssessmentID = ss.AssessmentID
    WHERE 
        ss.LearnerID = @LearnerID AND s.AssessmentID = @AssessmentID;

    -- Optional: Add Analysis (Strengths/Weaknesses)
    -- Consider adding thresholds to categorize performance, such as:
    PRINT 'Analysis: Focus on sections with less than 50% scores to improve performance.';
END;
GO

CREATE PROC LeaderboardFilter
    @LearnerID INT
AS
BEGIN
    -- Validate Learner ID
    IF NOT EXISTS (SELECT 1 FROM Learners WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    -- Fetch and filter the leaderboard by learner rank in descending order
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







---- instructor procedures
Go 
CREATE PROC SkillLearners  --1  --handle the edge cases in the input or output
 @Skillname VARCHAR(50)
 AS 
 BEGIN
  SELECT  s.SkillName, l.LearnerName
    FROM 
        Skills s
        INNER JOIN  LearnersSkills ls ON s.SkillID = ls.SkillID INNER JOIN  Learners l ON ls.LearnerID = l.LearnerID
    WHERE 
        s.SkillName = @Skillname;
        END;

GO
CREATE PROC NewActivity --2
@CourseID int,
@ModuleID int,
@activitytype varchar(50),
@instructiondetails varchar(max),
@maxpoints int
AS
BEGIN
INSERT INTO learningActivity(CourseID,ModuleID,activitytype, instructiondetails,maxpoints) values 
(@CourseID,@ModuleID,@activitytype, @instructiondetails,@maxpoints)
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
INSERT INTO Achievement(LearnerID, BadgeID , description, date_earned, type) VALUES 
(@LearnerID, @BadgeID , @description, @date_earned, @type)
END;

GO
CREATE PROC LearnerBadge --4
@BadgeID int

AS
BEGIN

SELECT l.LearnerID,
l.LearnerName,
b.BadgeName
    FROM 
       Learners l
    INNER JOIN LearnersBadges lb ON l.LearnerID = lb.LearnerIDINNER JOIN Badges b ON lb.BadgeID = b.BadgeID
    WHERE 
        b.BadgeID = @BadgeID;
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
INSERT INTO LearningPaths (LearnerID, ProfileID, CompletionStatus, CustomContent, Adapt) VALUES 
(@LearnerID, @ProfileID, @Completion_Status, @Custom_Content, @Adapt);
END;

GO
CREATE PROC TakenCourses --6 
@LearnerID Int 
AS 
BEGIN 
SELECT
c.Course_ID,
c.title
 FROM  Course c
    INNER JOIN LearnersCourses lc ON c.Course_ID = lc.Course_ID
    WHERE 
        lc.LearnerID = @LearnerID;
END;

Go
CREATE PROC CollaborativeQuest  --7
@difficulty_level varchar(50),
@criteria varchar(50),
@description varchar(50), 
@title varchar(50), 
@Maxnumparticipants int, 
@deadline datetime
AS
BEGIN
    
    INSERT INTO Quest (difficulty_level, criteria, description, title) VALUES 
    (@difficulty_level, @criteria, @description, @title); 
    INSERT INTO Collaborative (QuestID, Deadline, Max_Num_Participants) VALUES 
    (@QuestID, @deadline, @Maxnumparticipants);
    END;

GO
CREATE PROCEDURE DeadlineUpdate  --8 
@QuestID INT, 
@deadline DATETIME
AS
BEGIN
    UPDATE Collaborative
    SET Deadline = @deadline
    WHERE QuestID = @QuestID;
END;

GO 
CREATE PROC GradeUpdate  --9 
@LearnerID int, 
@AssessmentID int,
@Newgrade int 
AS
BEGIN
UPDATE Assessment 
SET totalMarks = @Newgrade 
WHERE LearnerID = @LearnerID AND AssessmentID = @AssessmentID;

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
    INSERT INTO Notifications (NotificationID, Timestamp, Message, UrgencyLevel, LearnerID) VALUES 
    (@NotificationID, @timestamp, @message, @urgencylevel, @LearnerID);
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
    INSERT INTO Learning_goal (ID, status, deadline, description) VALUES
    (@GoalID, @status, @deadline, @description);
END;

Go
CREATE PROC LearnersCourses --12
@CourseID INT,
@InstructorID INT
AS 
BEGIN
    SELECT C.title, L.LearnerName, L.LearnerEmail
    FROM Course_Enrollment CE
    INNER JOIN Course C ON CE.Course_ID = C.Course_ID INNER JOIN Instructor I ON C.Instructor_ID = I.Instructor_ID INNER JOIN Learner L ON CE.Learner_ID = L.Learner_ID
    WHERE C.Course_ID = @CourseID AND I.Instructor_ID = @InstructorID;
END;

Go
CREATE PROC LastActive --13
@ForumID INT,
@lastactive DATETIME OUTPUT
AS
BEGIN
    SELECT @lastactive = last_active
    FROM Discussion_forum WHERE forumID = @ForumID;
END;

GO 
CREATE PROC CommonEmotionalState --14
@state VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT TOP 1 @state = emotionalState
    FROM PersonalProfile
    GROUP BY emotionalState
    ORDER BY COUNT(emotionalState) DESC;
END;

GO
CREATE PROCEDURE ModuleDifficulty --15
    @courseID INT
AS
BEGIN
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
@LearnerID INT,
@Skill varchar(50)
AS
BEGIN
SELECT Skill=@Skill 
FROM SkillProgression
WHERE LearnerID=@LearnerID 
ORDER BY proficiency_level DESC

END;
GO
CREATE PROC  ProfeciencyUpdate --17
@Skill varchar(50),
@LearnerID INT,
@Level  VARCHAR(50)
AS
BEGIN
UPDATE SkillProgression
SET proficiency_level=@Level
WHERE LearnerID=@LearnerID AND Skill=@Skill
END;
GO
CREATE PROC  LeastBadge --18
@LearnerID INT OUTPUT
AS
BEGIN
    -- Find the learner with the least number of badges earned
    SELECT TOP 1 @LearnerID = LearnerID
    FROM LearnerBadges
    GROUP BY LearnerID
    ORDER BY COUNT(BadgeID) ASC;
END;


GO
CREATE PROC PreferedType --19
@type VARCHAR(50) OUTPUT
AS
BEGIN
	
	SELECT  @type = prefrences
	FROM LearningPrefrences
	GROUP BY prefrences
	ORDER BY COUNT(prefrences) DESC;
END;
GO

CREATE PROC AssessmentAnalytics --20  --check the from tables bec iam tired
    @CourseID INT,
    @ModuleID INT
AS
BEGIN
    -- Validate Course ID
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Course ID does not exist.';
        RETURN;
    END

    -- Validate Module ID
    IF NOT EXISTS (SELECT 1 FROM Modules WHERE ModuleID = @ModuleID AND CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Module ID does not exist for the specified Course.';
        RETURN;
    END

    -- Fetch analytics for assessments in the specified module and course
    SELECT 
        a.AssessmentID,
        a.ModuleID,
        m.ModuleName,
        c.CourseName,
        COUNT(la.LearnerID) AS NumberOfLearners,
        AVG(CAST(la.Score AS FLOAT)) AS AverageScore,
        a.TotalMarks
    FROM 
        Assessments a
    INNER JOIN 
        Modules m ON a.ModuleID = m.ModuleID
    INNER JOIN 
        Courses c ON m.CourseID = c.CourseID
    LEFT JOIN 
        LearnerAssessments la ON a.AssessmentID = la.AssessmentID
    WHERE 
        m.ModuleID = @ModuleID AND c.CourseID = @CourseID
    GROUP BY 
        a.AssessmentID, a.ModuleID, m.ModuleName, c.CourseName, a.TotalMarks
    ORDER BY 
        a.AssessmentID;
END;
GO

CREATE PROCEDURE EmotionalTrendAnalysis  --check the from tables bec iam tired
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod VARCHAR(50)
AS
BEGIN
    -- Validate Course ID
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Course ID does not exist.';
        RETURN;
    END

    -- Validate Module ID
    IF NOT EXISTS (SELECT 1 FROM Modules WHERE ModuleID = @ModuleID AND CourseID = @CourseID)
    BEGIN
        PRINT 'Rejection: Module ID does not exist for the specified Course.';
        RETURN;
    END

    -- Determine time filter based on @TimePeriod
    DECLARE @StartDate DATETIME;
    IF @TimePeriod = 'LAST_MONTH'
        SET @StartDate = DATEADD(MONTH, -1, GETDATE());
    ELSE IF @TimePeriod = 'LAST_WEEK'
        SET @StartDate = DATEADD(WEEK, -1, GETDATE());
    ELSE IF @TimePeriod = 'ALL_TIME'
        SET @StartDate = NULL;

    -- Fetch emotional feedback trends
    SELECT 
        ef.Timestamp,
        ef.Emotion,
        COUNT(ef.FeedbackID) AS FeedbackCount
    FROM 
        EmotionalFeedback ef
    INNER JOIN 
        Modules m ON ef.ModuleID = m.ModuleID
    INNER JOIN 
        Courses c ON ef.CourseID = c.CourseID
    WHERE 
        ef.CourseID = @CourseID
        AND ef.ModuleID = @ModuleID
        AND (@StartDate IS NULL OR ef.Timestamp >= @StartDate)
    GROUP BY 
        ef.Timestamp, ef.Emotion
    ORDER BY 
        ef.Timestamp;
END;
GO



---------here is the start of the learner procedures



 
Go --1  --check the input (Edge cases)
CREATE PROC ProfileUpdate
    @LearnerID INT, @ProfileID INT, @PreferedContentType VARCHAR(50),@emotional_state VARCHAR(50), @PersonalityType VARCHAR(50)
    AS
    UPDATE PersonalProfile
    SET 
        PreferedContent_type = @PreferedContentType,
        emotionalState = @EmotionalState,
        personality_type = @PersonalityType
     WHERE Learner_ID = @LearnerID AND profileID = @ProfileID;
GO

CREATE PROC TotalPoints --2 --check the input (Edge cases)
    @LearnerID INT,
    @RewardType VARCHAR(50)
AS
    SELECT SUM(value) AS TotalPoints
    FROM Rewards
    WHERE LearnerID = @LearnerID
    AND RewardType = @RewardType;
GO

GO
CREATE PROC EnrolledCourses  --3 --check the input (Edge cases)
    @LearnerID INT
AS
    SELECT c.CourseID, c.CourseName, c.Description, c.CreditHours
    FROM Course c
    INNER JOIN Enrollments e ON c.CourseID = e.CourseID
    WHERE e.LearnerID = @LearnerID;


    -- check to be reviewed 
GO
CREATE PROC Prerequisites --4 ----xxxxxxxxx
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
    -- Check if the learner has completed all prerequisites for the given course
    DECLARE @PrerequisitesCompleted INT;

    -- Count the prerequisites for the course
    SELECT @PrerequisitesCompleted = COUNT(*)
    FROM Prerequisites p
    INNER JOIN Enrollments e ON p.PrerequisiteCourseID = e.CourseID
    WHERE e.LearnerID = @LearnerID
    AND e.CompletionStatus = 'Completed'  -- Assuming 'Completed' is a value in the CompletionStatus column
    AND p.CourseID = @CourseID;

    -- If all prerequisites are completed, return a message
    IF @PrerequisitesCompleted = (SELECT COUNT(*) FROM Prerequisites WHERE CourseID = @CourseID)
    BEGIN
        SELECT 'All prerequisites completed.' AS Message;
    END
    ELSE
    BEGIN
        SELECT 'Prerequisites not completed.' AS Message;
    END
END


GO
CREATE PROC Moduletraits--5  --check the input (Edge cases)if it exists
    @TargetTrait VARCHAR(50), 
    @CourseID INT
AS
BEGIN
   
    SELECT m.Module_ID, m.title, m.difficulty_level
    FROM Module m
    INNER JOIN TargetTraits tt ON m.Module_ID = tt.Module_ID
    WHERE tt.trait = @TargetTrait 
    AND m.Course_ID = @CourseID;
END;

GO
CREATE PROC LeaderboardRank  --6  --check the input (Edge cases)
    @LeaderboardID INT
    AS  
    SELECT r.LearnerID, r.CourseID, r.rank, r.total_points
    FROM Ranking r
    WHERE r.BoardID = @LeaderboardID
    ORDER BY r.rank; 


GO
CREATE PROC ViewMyDeviceCharge  --7
    @ActivityID INT,
    @LearnerID INT,
    @timestamp DATETIME,
    @emotionalstate VARCHAR(50)
AS
BEGIN
    INSERT INTO Emotional_feedback (LearnerID, timestamp, emotional_state)
    VALUES (@LearnerID, @timestamp, @emotionalstate);
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

    IF @CurrentParticipants >= @MaxParticipants
    BEGIN
        PRINT 'Rejection: Quest is already at full capacity.';
        RETURN;
    END

    
    INSERT INTO QuestParticipants (QuestID, LearnerID)
    VALUES (@QuestID, @LearnerID);

    PRINT 'Approval: Learner successfully joined the quest.';
END;
GO



GO

CREATE PROCEDURE SkillsProficiency   --8  handle the skill as an edge case
    @LearnerID INT
AS
BEGIN
   
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

   
    SELECT 
        s.skill AS Skill,
        sp.ProficiencyLevel AS ProficiencyLevel
    FROM 
        Skills s,SkillProgression
    LEFT JOIN 
        SkillProficiency sp ON s.Learner_ID = sp.Learner_ID AND s.skill = sp.skill
    WHERE 
        s.Learner_ID = @LearnerID;
END;
GO



GO
CREATE PROC Viewscore --10  --check the input (Edge cases)
    @LearnerID INT,
    @AssessmentID INT,
    @score INT OUTPUT
AS
BEGIN
    SELECT @score = s.score
    FROM Scores s
    WHERE s.LearnerID = @LearnerID AND s.AssessmentID = @AssessmentID;

    -- If no score found, set the score to NULL
    IF @score IS NULL
    BEGIN
        SET @score = -1; 
    END
END;


GO
CREATE PROC AssessmentsList --11
    @CourseID INT,
    @ModuleID INT
AS
BEGIN

    SELECT 
        a.Assessment_ID,
        a.title AS AssessmentTitle,
        s.score AS Grade
    FROM 
        Assessment a
    LEFT JOIN 
        Scores s ON a.Assessment_ID = s.Assessment_ID
    WHERE 
        a.Course_ID = @CourseID 
        AND a.Module_ID = @ModuleID;
END;

GO
CREATE PROC Courseregister --12  EDge case could be handled almost completly
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
    -- Insert the post into the Posts table
    INSERT INTO Posts (LearnerID, DiscussionID, PostContent, Timestamp)
    VALUES (@LearnerID, @DiscussionID, @Post, GETDATE());
    UPDATE Discussion_forum
    SET last_active = GETDATE()
    WHERE forumID = @DiscussionID;
END;

Go
CREATE PROC AddGoal  --14 --check the input (Edge cases)
    @LearnerID INT,
    @GoalID INT
AS
BEGIN
    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);
END;

GO
CREATE PROC CurrentPath --15 --check the input (Edge cases)
    @LearnerID INT
AS
    SELECT 
        Path_ID AS LearningPathID,
        completion_status AS Status
    FROM 
        LearningPath
    WHERE 
        Learner_ID = @LearnerID;
GO
CREATE PROC QuestMembers --16 --check the input (Edge cases)
	@LearnerId int
    AS
    BEGIN
    DECLARE @QuestID INT
    DECLARE @DEADLINE DATE
    SELECT LearnerID= @LearnerId FROM Learner
    SELECT QuestID, Deadline FROM Collaborative
	WHERE QuestID = @QuestID AND Deadline > @DEADLINE
	
	END;

    GO


    CREATE PROC QuestProgress --17
    @LearnerID INT,
    @QuestID INT
    AS
    BEGIN
     -- Validate if the learner exists
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    -- Fetch quest progress
    SELECT 
        q.QuestID AS QuestID,
        q.QuestName AS QuestName,
        qp.CompletionStatus AS CompletionStatus
    FROM 
       QuestReward qp
    INNER JOIN 
        Quest q ON qp.QuestID = q.QuestID
    WHERE 
        qp.LearnerID = @LearnerID AND qp.QuestID = @QuestID;

    -- Fetch badges earned by the learner
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

CREATE PROC GoalReminder --18 --check the input (Edge cases)
	@LearnerID INT,
    @GoalID INT
    AS
    BEGIN
    DECLARE @Deadline DATE;
    SELECT Deadline = @Deadline FROM Learning_goal
	WHERE GoalID = @GoalID AND Deadline > @Deadline
	END;

    GO
CREATE PROC SkillProgressHistory --19
    @LearnerId INT,
    @Skill VARCHAR(50)
    AS
    BEGIN
    SELECT  LearnerID = @LearnerId ,Skill = @Skill, ProficiencyLevel, Timestamp
    FROM SkillProgression
	END;

   GO
   CREATE PROC AssessmentAnalysis --20
	@AssessmentID INT,
    @LearnerID INT
	AS
	BEGIN
	 -- Validate Learner ID
    IF NOT EXISTS (SELECT 1 FROM Learner WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    -- Validate Assessment ID
    IF NOT EXISTS (SELECT 1 FROM Assessments WHERE AssessmentID = @AssessmentID)
    BEGIN
        PRINT 'Rejection: Assessment ID does not exist.';
        RETURN;
    END

    -- Fetch Assessment Overview
    SELECT 
        a.AssessmentID,
        a.AssessmentName,
        la.TotalScore,
        a.TotalMarks
    FROM 
        Assessments a
    LEFT JOIN 
        LearnerAssessments la ON a.AssessmentID = la.AssessmentID
    WHERE 
        a.AssessmentID = @AssessmentID AND la.LearnerID = @LearnerID;

    -- Fetch Section-wise Breakdown
    SELECT 
        s.SectionName,
        ss.Score AS LearnerScore,
        s.Weightage AS TotalWeightage,
        CAST((CAST(ss.Score AS FLOAT) / s.Weightage) * 100 AS DECIMAL(5, 2)) AS Percentage
    FROM 
        AssessmentSections s
    LEFT JOIN 
        SectionScores ss ON s.SectionID = ss.SectionID AND s.AssessmentID = ss.AssessmentID
    WHERE 
        ss.LearnerID = @LearnerID AND s.AssessmentID = @AssessmentID;

    -- Optional: Add Analysis (Strengths/Weaknesses)
    -- Consider adding thresholds to categorize performance, such as:
    PRINT 'Analysis: Focus on sections with less than 50% scores to improve performance.';
END;
GO

CREATE PROC LeaderboardFilter
    @LearnerID INT
AS
BEGIN
    -- Validate Learner ID
    IF NOT EXISTS (SELECT 1 FROM Learners WHERE Learner_ID = @LearnerID)
    BEGIN
        PRINT 'Rejection: Learner ID does not exist.';
        RETURN;
    END

    -- Fetch and filter the leaderboard by learner rank in descending order
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



