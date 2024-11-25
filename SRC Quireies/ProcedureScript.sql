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
begin
select MAX(totalMarks) from Assessment
group by Course_ID
end

Go
CREATE PROC InstructorCount 
AS
begin
select c.* from Course c inner join Teaches t on c.Course_ID = t.Course_ID
where count(t.Instructor_ID)>1
end
Go
CREATE PROC ViewNot 
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

Go
CREATE PROC CreateDiscussion --some discussion attributes need to be null and the forumid need to be identity
@ModuleID int, @courseID int, @title varchar(50), @description varchar(50)
AS
begin
insert into Discussion_forum(Module_ID,Course_ID,title,description) values (@ModuleID, @courseID, @title, @description)
end
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
CREATE PROC Viewscore --10  --check the input (Edge cases)
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
    SELECT @score = s.scoredPoint
    FROM Takenassessment where
	AssessmentID = @AssessmentID
	and LearnerID = @LearnerID
    
END;
END;
GO
CREATE PROC AssessmentsList --11
    @CourseID INT,
    @ModuleID INT,
    @LearnerID INT
AS
BEGIN
    SET NOCOUNT ON;

   
    IF NOT EXISTS (SELECT 1 FROM Assessment WHERE Course_ID = @CourseID AND Module_ID = @ModuleID)
    BEGIN
        PRINT 'Error: No assessments found for the given CourseID and ModuleID.';
        RETURN;
    END

  
    SELECT 
        a.Assessment_ID,
        a.title AS AssessmentTitle,
       CASE
            WHEN s.score IS NULL THEN 'Not Graded'
            ELSE CAST(s.score AS VARCHAR(50))
        END AS Grade  

    FROM 
        Assessment a
    LEFT JOIN 
        Scores s ON a.Assessment_ID = s.Assessment_ID AND s.LearnerID = @LearnerID 
    WHERE 
        a.Course_ID = @CourseID 
        AND a.Module_ID = @ModuleID
    ORDER BY 
        a.Assessment_ID;  
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
CREATE PROC QuestMembers --16 --check the input (Edge cases)
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
        q.QuestName AS QuestName,
        qp.CompletionStatus AS CompletionStatus
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



