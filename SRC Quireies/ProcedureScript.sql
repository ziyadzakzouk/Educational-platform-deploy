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
select n.* from Notification n inner join RecivedNotfy r
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

Go 
CREATE PROC SkillLearners 
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
CREATE PROC NewActivity @CourseID int, @ModuleID int, @activitytype varchar(50), @instructiondetails varchar(max),
@maxpoints int
AS
BEGIN
INSERT INTO learningActivity(CourseID,ModuleID,activitytype, instructiondetails,maxpoints) values (@CourseID,@ModuleID,@activitytype, @instructiondetails,@maxpoints)
END;

GO
CREATE PROC NewAchievement @LearnerID int, @BadgeID int, @description varchar(max), @date_earned date, @type varchar(50)
AS
BEGIN
INSERT INTO Achievement(LearnerID, BadgeID , description, date_earned, type) VALUES (@LearnerID, @BadgeID , @description, @date_earned, @type)
END;

GO
CREATE PROC LearnerBadge @BadgeID int

AS
BEGIN

SELECT l.LearnerID,l.LearnerName, b.BadgeName
    FROM 
        Learners l
    INNER JOIN LearnersBadges lb ON l.LearnerID = lb.LearnerIDINNER JOIN Badges b ON lb.BadgeID = b.BadgeID
    WHERE 
        b.BadgeID = @BadgeID;
END;
