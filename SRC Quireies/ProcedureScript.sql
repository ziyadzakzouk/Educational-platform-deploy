use EduPlatform

Go
CREATE PROC ViewInfo
@LearnerID int
AS
select * from Learner 
where Learner_ID = @LearnerID

Go
CREATE PROC LearnerInfo
@LearnerID int
AS
select * from PersonalProfile 
where Learner_ID = @LearnerID

Go
CREATE PROC EmotionalState
@LearnerID int,
 @emotional_state varchar(50) output
AS
select @emotional_state = emotional_state from Emotional_feedback 
where Learner_ID = @LearnerID

Go
CREATE PROC LogDetails
@LearnerID int
AS
select * from Interaction_log 
where Learner_ID = @LearnerID

Go
CREATE PROC InstructorReview
@InstructorID int
AS
select e.* from Emotional_feedback e inner join Emotionalfeedback_review er
on er.FeedbackID = e.FeedbackID where @InstructorID = er.InstructorID

Go
CREATE PROC CourseRemove
@courseID int 
AS
delete from Course where @courseID = Course_ID

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
select n.* from Notification n inner join RecivedNotfy r on n.Notification_ID = r.Notification_ID
where @LearnerID = r.Learner_ID

Go
CREATE PROC CreateDiscussion --some discussion attributes need to be null and the forumid need to be identity
@ModuleID int, @courseID int, @title varchar(50), @description varchar(50)
AS
insert into Discussion_forum(Module_ID,Course_ID,title,description) values (@ModuleID, @courseID, @title, @description)

Go
CREATE PROC RemoveBadge
@BadgeID int
AS
delete from Badge where BadgeID = @BadgeID

Go
CREATE PROC CriteriaDelete
@criteria varchar(50) 
AS
delete from Quest where criteria = @criteria

Go
CREATE PROC NotificationUpdate -- needs to be reviewed -------------------------------------------------------
@LearnerID int, @NotificationID int, @ReadStatus bit
AS
if @ReadStatus = 1 
delete from Notification where @NotificationID = Notification_ID

---------here is the start of the learner procedures



 
Go --1
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

CREATE PROC TotalPoints --2
    @LearnerID INT,
    @RewardType VARCHAR(50)
AS
    SELECT SUM(value) AS TotalPoints
    FROM Rewards
    WHERE LearnerID = @LearnerID
    AND RewardType = @RewardType;
GO

GO
CREATE PROC EnrolledCourses  --3
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
CREATE PROC Moduletraits--5
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
CREATE PROC LeaderboardRank  --6
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

CREATE PROCEDURE SkillsProficiency
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
CREATE PROC Viewscore --10
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
    -- Insert the post into the Posts table
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
    INSERT INTO LearnersGoals (GoalID, LearnerID)
    VALUES (@GoalID, @LearnerID);
END;

GO
CREATE PROC CurrentPath --15
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
CREATE PROC QuestMembers --16
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




