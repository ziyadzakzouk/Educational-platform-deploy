-- Insert data into Learner table
INSERT INTO Learner (Learner_ID, Name, Email, DateOfBirth)
VALUES 
(1, 'John Doe', 'john.doe@example.com', '1990-01-01'),
(2, 'Jane Smith', 'jane.smith@example.com', '1992-02-02'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '1994-03-03');

-- Insert data into PersonalProfile table
INSERT INTO PersonalProfile (Profile_ID, Learner_ID, ProfileName, ProfileDescription)
VALUES 
(1, 1, 'Main Profile', 'This is the main profile of John Doe.'),
(2, 2, 'Secondary Profile', 'This is the secondary profile of Jane Smith.'),
(3, 3, 'Main Profile', 'This is the main profile of Alice Johnson.');

-- Insert data into Emotional_feedback table
INSERT INTO Emotional_feedback (Feedback_ID, LearnerID, emotional_state, timestamp)
VALUES 
(1, 1, 'Happy', GETDATE()),
(2, 2, 'Sad', GETDATE()),
(3, 3, 'Neutral', GETDATE());

-- Insert data into Interaction_log table
INSERT INTO Interaction_log (Log_ID, LearnerID, InteractionType, Timestamp)
VALUES 
(1, 1, 'Login', GETDATE()),
(2, 2, 'Logout', GETDATE()),
(3, 3, 'Course Access', GETDATE());


-- Insert data into Course table
INSERT INTO Course (Course_ID, CourseName, Description)
VALUES 
(1, 'Introduction to SQL', 'Learn the basics of SQL.'),
(2, 'Advanced SQL', 'Deep dive into advanced SQL topics.'),
(3, 'Database Design', 'Learn how to design databases.');

-- Insert data into Assessment table
INSERT INTO Assessment (Assessment_ID, Course_ID, totalMarks)
VALUES 
(1, 1, 100),
(2, 2, 150),
(3, 3, 200);


-- Insert data into Instructor table
INSERT INTO Instructor (Instructor_ID, Name, Email, Department)
VALUES 
(1, 'Dr. Emily Brown', 'emily.brown@example.com', 'Computer Science'),
(2, 'Prof. Michael Green', 'michael.green@example.com', 'Information Technology'),
(3, 'Dr. Sarah White', 'sarah.white@example.com', 'Software Engineering');
-- Insert data into Teaches table
INSERT INTO Teaches (Instructor_ID, Course_ID)
VALUES 
(1, 1),
(2, 2),
(3, 3);