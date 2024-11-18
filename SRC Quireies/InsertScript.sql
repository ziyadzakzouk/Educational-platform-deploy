-- Insert data into Learner table
INSERT INTO Learner (Learner_ID, first_name, last_name, birthday, gender, country, cultural_background) 
VALUES 
(1, 'John', 'Doe', '2000-05-15', 'Male', 'USA', 'Western'),
(2, 'Anna', 'Smith', '1999-07-22', 'Female', 'UK', 'European');

--- Insert data into Skills table
INSERT INTO Skills (Learner_ID, skill) 
VALUES 
(1, 'Programming'),
(2, 'Data Analysis');

-- Insert data into LearningPrefrences table
INSERT INTO LearningPrefrences (Learner_ID, prefrences) 
VALUES 
(1, 'Visual Learning'),
(2, 'Hands-on Practice');

-- Insert data into PersonalProfile table
INSERT INTO PersonalProfile (Learner_ID, profileID, PreferedContent_type, emotionalState, personality_type) 
VALUES 
(1, 101, 'Video Lectures', 'Calm', 'Introvert'),
(2, 102, 'Interactive Quizzes', 'Excited', 'Extrovert');

-- Insert data into HealthCondition table
INSERT INTO HealthCondition (Learner_ID, profileID, condition) 
VALUES 
(1, 101, 'Asthma'),
(2, 102, 'Anxiety');

-- Insert data into Course table
INSERT INTO Course (Course_ID, title, description, diff_level, credit_point, learning_objective, pre_requisites) 
VALUES 
(201, 'Intro to Computer Science', 'Basic computer science concepts', 'Beginner', 3, 'Understand core principles of CS', 'None'),
(202, 'Data Structures', 'Learn about various data structures', 'Intermediate', 4, 'Implement basic data structures', 'Intro to Computer Science');

-- Insert data into Module table
INSERT INTO Module (Module_ID, Course_ID, title, difficulty_level, contentURL) 
VALUES 
(301, 201, 'Basics of Algorithms', 'Beginner', 'http://example.com/algorithms'),
(302, 202, 'Trees and Graphs', 'Intermediate', 'http://example.com/trees');

-- Insert data into TargetTraits table
INSERT INTO TargetTraits (Module_ID, Course_ID, trait) 
VALUES 
(301, 201, 'Problem-solving'),
(302, 202, 'Analytical Thinking');

-- Insert data into ModuleContent table
INSERT INTO ModuleContent (Module_ID, Course_ID, contetntType) 
VALUES 
(301, 201, 'Video'),
(302, 202, 'Document');

-- Insert data into ContentLibrary table
INSERT INTO ContentLibrary (Lib_ID, Module_ID, Course_ID, title, description, metaData, type, contentURL) 
VALUES 
(401, 301, 201, 'Algorithm Basics Video', 'Introduction to algorithms', 'Duration: 10 min', 'Video', 'http://example.com/algorithms/video'),
(402, 302, 202, 'Trees and Graphs PDF', 'Comprehensive guide on trees', 'Pages: 20', 'Document', 'http://example.com/trees/pdf');

INSERT INTO Course_Enrollment (Enrollment_ID, Learner_ID, Course_ID, enrollment_date, completion_date, status) 
VALUES 
(501, 1, 201, '2024-01-10', NULL, 'In Progress'),
(502, 2, 202, '2024-02-01', NULL, 'Not Started');
