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



 
Go
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

CREATE PROC TotalPoints
    @LearnerID INT,
    @RewardType VARCHAR(50)
AS
    SELECT SUM(value) AS TotalPoints
    FROM Rewards
    WHERE LearnerID = @LearnerID
    AND RewardType = @RewardType;
GO

GO
CREATE PROC EnrolledCourses
    @LearnerID INT
AS
    SELECT c.CourseID, c.CourseName, c.Description, c.CreditHours
    FROM Course c
    INNER JOIN Enrollments e ON c.CourseID = e.CourseID
    WHERE e.LearnerID = @LearnerID;


    -- check to be reviewed 
GO
CREATE PROC Prerequisites
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
CREATE PROCEDURE Moduletraits
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
CREATE PROCEDURE LeaderboardRank
    @LeaderboardID INT
    AS  
    SELECT r.LearnerID, r.CourseID, r.rank, r.total_points
    FROM Ranking r
    WHERE r.BoardID = @LeaderboardID
    ORDER BY r.rank; 


GO
CREATE PROCEDURE ViewMyDeviceCharge
    @ActivityID INT,
    @LearnerID INT,
    @timestamp DATETIME,
    @emotionalstate VARCHAR(50)
AS
BEGIN
    INSERT INTO Emotional_feedback (LearnerID, timestamp, emotional_state)
    VALUES (@LearnerID, @timestamp, @emotionalstate);
END;













