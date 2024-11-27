use nope
-- Insert data into Learner table
INSERT INTO Learner (first_name, last_name, birthday, gender, country, cultural_background) 
VALUES   
('Alice', 'Johnson', '1998-06-15', 'Female', 'Canada', 'Western'),
('Bob', 'Miller', '2001-09-12', 'Male', 'Germany', 'European'),
('Chris', 'Brown', NULL, 'Male', 'USA', 'Western'); -- Edge case: Missing birthday

-- Insert data into Skills table
INSERT INTO Skills (Learner_ID, skill) 
VALUES 
(1, 'Python Programming'),
(2, 'Machine Learning'),
(1, NULL); -- Edge case: Null skill

-- Insert data into LearningPrefrences table
INSERT INTO LearningPrefrences (Learner_ID, prefrences) 
VALUES 
(1, 'Visual Learning'),
(2, 'Auditory Learning'),
(3, 'Hands-on Practice');

-- Insert data into PersonalProfile table
INSERT INTO PersonalProfile (Learner_ID, profileID, PreferedContent_type, emotionalState, personality_type) 
VALUES 
(1, 1, 'Video Lectures', 'Calm', 'Introvert'),
(2, 2, 'Interactive Quizzes', 'Excited', 'Extrovert');

-- Insert data into HealthCondition table
INSERT INTO HealthCondition (Learner_ID, profileID, condition) 
VALUES 
(1, 1, 'Asthma'),
(2, 2, 'Anxiety');

-- Insert data into Course table
INSERT INTO Course (title, description, diff_level, credit_point, learning_objective) 
VALUES 
('Intro to AI', 'Basics of Artificial Intelligence', 'Beginner', 3, 'Understand AI principles'),
('Advanced AI', 'In-depth AI techniques', 'Advanced', 4, 'Apply AI models');

-- Insert data into CoursePrerequisites table
INSERT INTO CoursePrerequisites (Course_ID, prerequisite) 
VALUES 
(2, 'Intro to AI');

-- Insert data into Module table
INSERT INTO Module(Course_ID, title, difficulty_level, contentURL) 
VALUES 
(1, 'AI Basics', 'Beginner', 'http://example.com/ai-basics'),
(2, 'AI Models', 'Advanced', 'http://example.com/ai-models');

-- Insert data into TargetTraits table
INSERT INTO TargetTraits (Module_ID, Course_ID, trait) 
VALUES 
(1, 1, 'Problem-solving'),
(2, 2, 'Analytical Thinking');

-- Insert data into ModuleContent table
INSERT INTO ModuleContent (Module_ID, Course_ID, contetntType) 
VALUES 
(1, 1, 'Video'),
(2, 2, 'Document');

-- Insert data into ContentLibrary table
INSERT INTO ContentLibrary (Module_ID, Course_ID, title, description, metaData, type, contentURL) 
VALUES 
(1, 1, 'Algorithm Basics Video', 'Introduction to algorithms', 'Duration: 10 min', 'Video', 'http://example.com/algorithms/video'),
(2, 2, 'Trees and Graphs PDF', 'Comprehensive guide on trees', 'Pages: 20', 'Document', 'http://example.com/trees/pdf');

-- Insert data into Course_Enrollment table
INSERT INTO Course_Enrollment (Learner_ID, Course_ID, enrollment_date, completion_date, status) 
VALUES 
(1, 1, '2024-01-10', NULL, 'In Progress'),
(2, 2, '2024-01-15', '2024-05-01', 'Completed');

-- Insert data into Assessment table
INSERT INTO Assessment (Module_ID, Course_ID, type, totalMarks, passingMarks, criteria, weightage, description, title) 
VALUES 
(1, 1, 'Quiz', 100, 50, 'Basic understanding', 20, 'Introductory quiz', 'Algorithm Basics Quiz'),
(2, 2, 'Project', 200, 120, 'Full implementation', 40, 'Advanced project', 'Data Structures Project');

-- Insert data into TakenAssessment table
INSERT INTO TakenAssessment (Assessment_ID, Learner_ID, ScoredPoint) 
VALUES 
(1, 1, 85),
(2, 2, 150);

-- Insert data into Instructor table
INSERT INTO Instructor (Instructor_name, latest_qualification, expertise_area, email) 
VALUES 
('Dr. Brown', 'PhD', 'Computer Science', 'brown@example.com'),
('Prof. Green', 'MSc', 'Data Structures', 'green@example.com');

-- Insert data into Teaches table
INSERT INTO Teaches (Instructor_ID, Course_ID) 
VALUES 
(1, 1),
(2, 2);

-- Insert data into LearningPath table
INSERT INTO LearningPath (Learner_ID, profileID, completion_status, customContent, adaptiveRules) 
VALUES 
(1, 1, 'Active', 'Customized video content', 'Adaptive quizzes'),
(2, 2, 'Completed', 'Interactive assignments', 'Peer assessments');

-- Insert data into pathreview table
INSERT INTO pathreview (Instructor_ID, Path_ID, feedback) 
VALUES 
(1, 1, 'Excellent progress with clear adaptive learning'),
(2, 2, 'Completed well with peer assessments');

-- Insert data into learningActivity table
INSERT INTO learningActivity (Course_ID, Module_ID, activityType, instruction_details, maxScore) 
VALUES 
(1, 1, 'Assignment', 'Solve basic algorithm questions', 50),
(2, 2, 'Project', 'Implement tree traversal', 100);

-- Insert data into Emotional_feedback table
INSERT INTO Emotional_feedback (LearnerID, Activity_ID, timestamp, emotional_state) 
VALUES 
(1, 1, '2024-03-01 12:00:00', 'Amusement'),
(2, 2, '2024-03-15 16:00:00', 'Anxiety');

-- Insert data into Emotionalfeedback_review table
INSERT INTO Emotionalfeedback_review (FeedbackID, InstructorID, review) 
VALUES 
(1, 1, 'Positive emotional response observed'),
(2, 2, 'Learner expressed signs of anxiety');

-- Insert data into Notification table
INSERT INTO Notification (time_stamp, message, urgency, readstatus) 
VALUES 
('2024-03-01 10:00:00', 'Upcoming quiz on algorithms', 'High', 0),
('2024-03-15 15:00:00', 'Project submission deadline', 'Medium', 0);

-- Insert data into RecivedNotfy table
INSERT INTO RecivedNotfy (Learner_ID, Notification_ID) 
VALUES 
(1, 1),
(2, 2);

-- Insert data into Reward table
INSERT INTO Reward (value, description, type) 
VALUES 
(10, 'Participation in quiz', 'Points'),
(20, 'Completion of project', 'Badge');

--insert data as interaction log
INSERT INTO Interaction_log(activity_ID,LearnerID,Duration,Timestamp,action_type)
VALUES
(1,1,2,'2002-2-2','comedy'),
(2,2,4,'2009-8-3','tragidyy')

-- Insert data into Quest table
INSERT INTO Quest (difficulty_level, criteria, description, title) 
VALUES 
(2, 'Basic knowledge', 'Complete introductory tasks', 'Beginner Quest'),
(5, 'Advanced skills', 'Implement complex algorithms', 'Advanced Quest');

-- Insert data into QuestReward table
INSERT INTO QuestReward (QuestID, RewardID, LearnerID, timeEarned) 
VALUES 
(1, 1, 1, '2024-03-02 11:00:00'),
(2, 2, 2, '2024-03-16 17:00:00');

-- Insert data into Skill_Mastery table
INSERT INTO Skill_Mastery (QuestID, Skill) 
VALUES 
(1, 'Java Programming'),
(2, 'Data Analysis');

-- Insert data into Collaborative table
INSERT INTO Collaborative (QuestID, Deadline, Max_Num_Participants) 
VALUES 
(1, '2024-12-01', 5),
(2, '2024-12-15', 10);

-- Insert data into LearnerCollaboration table
INSERT INTO LearnerCollaboration (LearnerId, QuestID, completion_status) 
VALUES 
(1, 1, 'In Progress'),
(2, 2, 'Completed');

-- Insert data into LearnerMastery table
INSERT INTO LearnerMastery (LearnerID, QuestID, completion_status) 
VALUES 
(1, 1, 'Completed'),
(2, 2, 'In Progress');

-- Insert data into Badge table
INSERT INTO Badge (title, description, criteria, points) 
VALUES 
('Beginner Badge', 'Awarded for completing beginner tasks', 'Complete Beginner Quest', 10),
('Advanced Badge', 'Awarded for completing advanced tasks', 'Complete Advanced Quest', 20);

-- Insert data into Discussion_forum table
INSERT INTO Discussion_forum (Course_ID, Module_ID, title, last_active, timestamp, description) 
VALUES 
(1, 1, 'AI Basics Discussion', '2024-03-01 10:00:00', '2024-03-01', 'Discussion on AI basics'),
(2, 2, 'AI Models Discussion', '2024-03-15 15:00:00', '2024-03-15', 'Discussion on AI models');

-- Insert data into Survey table
INSERT INTO Survey (Title) 
VALUES 
('Course Feedback Survey'),
('Module Feedback Survey');

-- Insert data into SurveyQuestions table
INSERT INTO SurveyQuestions (SurveyID, Question) 
VALUES 
(1, 'How would you rate the course content?'),
(2, 'How would you rate the module content?');

-- Insert data into LearnerDiscussion table
INSERT INTO LearnerDiscussion (ForumID, LearnerID, post, time) 
VALUES 
(1, 1, 'This is a great course!', '10:00:00'),
(2, 2, 'I found the module very challenging.', '15:00:00');

-- Insert data into FilledSurvey table
INSERT INTO FilledSurvey (SurveyID, Question, LearnerID, Answer) 
VALUES 
(1, 'How would you rate the course content?', 1)
INSERT INTO Achievement(LearnerID,BadgeID,Description,DateEarned,Type)
VALUES
(1,1,'hONEST','2001-1-2','EASY')
