﻿use EduPlatform

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

